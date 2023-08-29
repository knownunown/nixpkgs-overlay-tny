{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
, qemu
, makeWrapper
, darwin
}:

buildGoModule rec {
  pname = "lima";
  version = "0.15.1";

  src = fetchFromGitHub {
    owner = "lima-vm";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-uZE827dc79i7JPxHDI3kmAANN9XUIuhR0c9BUe92DyQ=";
  };

  vendorSha256 = "sha256-CysPzlup8TVVR4rCm3cWTjnxwJznMv0wbaeCC0ofWSU=";

  nativeBuildInputs = [ makeWrapper installShellFiles ];

  buildInputs = with darwin.apple_sdk.frameworks; [ Cocoa ];
  __propagatedImpureHostDeps = [ "/System/Library/Frameworks/Virtualization.framework/Virtualization" ];

  # clean fails with read only vendor dir
  postPatch = ''
    substituteInPlace Makefile --replace 'binaries: clean' 'binaries:'
  '';

  buildPhase = ''
    runHook preBuild
    make "VERSION=v${version}" binaries
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r _output/* $out
    wrapProgram $out/bin/limactl \
      --prefix PATH : ${lib.makeBinPath [ qemu ]}
    installShellCompletion --cmd limactl \
      --bash <($out/bin/limactl completion bash) \
      --fish <($out/bin/limactl completion fish) \
      --zsh <($out/bin/limactl completion zsh)
    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    USER=nix $out/bin/limactl validate examples/default.yaml
  '';

  meta = with lib; {
    homepage = "https://github.com/lima-vm/lima";
    description = "Linux virtual machines (on macOS, in most cases)";
    license = licenses.asl20;
    maintainers = with maintainers; [ anhduy ];
  };
}

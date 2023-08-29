{ lib, fetchFromGitHub, rustPlatform, targetPlatform, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "git-credential-keepassxc";
  version = "0.12.0";

  buildInputs = lib.optionals (targetPlatform.isDarwin)
    (with darwin.apple_sdk.frameworks; [
      IOKit
      DiskArbitration
      Foundation
    ]);
  src = fetchFromGitHub {
    owner = "Frederick888";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-siVSZke+anVTaLiJVyDEKvgX+VmS0axa+4721nlgmiw=";
  };

  cargoSha256 = "sha256-QMAAKkjWgM/UiOfkNMLQxyGEYYmiSvE0Pd8fZXYyN48=";

  meta = with lib; {
    description = "Helper that allows Git (and shell scripts) to use KeePassXC as credential store";
    homepage = "https://github.com/Frederick888/git-credential-keepassxc";
    license = licenses.gpl3Only;
    maintainers = [ "tny" ];
  };

  doCheck = false;
}

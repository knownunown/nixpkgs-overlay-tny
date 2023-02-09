{ final, prev, pkgs ? final, ... }: rec {
  tbb_2021 = pkgs.callPackage ./pkgs/tbb { };
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  nupack = pkgs.callPackage ./pkgs/nupack { inherit libsimdpp; tbb = tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };
  # rocm-thunk = prev.callPackage ./pkgs/overrides/rocm-thunk.nix { rocm-thunk = prev.rocm-thunk; };
  # compiler-rt = prev.callPackage ./pkgs/overrides/compiler-rt.nix { compiler-rt = prev.compiler-rt; };
  sops-install-secrets = prev.callPackage ./pkgs/overrides/sops-install-secrets.nix { sops-install-secrets = prev.sops-install-secrets; };

  emacsMacport = pkgs.callPackage ./pkgs/emacs-macport.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks)
      AppKit Carbon Cocoa IOKit OSAKit Quartz QuartzCore WebKit UniformTypeIdentifiers Metal
      ImageCaptureCore GSS ImageIO;
    inherit (pkgs.darwin) sigtool;
  };
  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
  vivado = pkgs.callPackage ./pkgs/vivado.nix { };
}

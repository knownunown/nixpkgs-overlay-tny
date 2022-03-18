{ final, prev, pkgs ? final, ... }: rec {
  tbb_2021 = pkgs.callPackage ./pkgs/tbb { };
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  nupack = pkgs.callPackage ./pkgs/nupack { inherit libsimdpp; tbb = tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };


  emacsMacport = pkgs.callPackage ./pkgs/emacs-macport.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks)
      AppKit Carbon Cocoa IOKit OSAKit Quartz QuartzCore WebKit UniformTypeIdentifiers Metal
      ImageCaptureCore GSS ImageIO;
    inherit (pkgs.darwin) sigtool;
  };
  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
}

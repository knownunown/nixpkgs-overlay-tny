{ pkgs, ... }: rec {
  tbb = pkgs.callPackage ./pkgs/tbb { };
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  nupack = pkgs.callPackage ./pkgs/nupack { inherit tbb libsimdpp; };

  discord = pkgs.callPackage ./pkgs/overrides/discord.nix { };

  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
}

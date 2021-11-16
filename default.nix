{ final, prev, pkgs ? final, ... }: rec {
  tbb_2021 = pkgs.callPackage ./pkgs/tbb { };
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  nupack = pkgs.callPackage ./pkgs/nupack { inherit libsimdpp; tbb = tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };

  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
}

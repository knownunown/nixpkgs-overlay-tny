{ pkgs, ... }: rec {
  tbb = pkgs.callPackage ./pkgs/tbb { };
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
}

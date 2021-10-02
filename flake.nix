{
  inputs = {
    nixpkgs.url = "nixpkgs/release-20.09";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        overlay = import ./overlay.nix { };
        packages = import ./default.nix { inherit pkgs; };
      });
}

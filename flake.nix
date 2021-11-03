{
  inputs = {
    nixpkgs.url = "nixpkgs/release-21.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
    nixpkgs-fmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, nixpkgs-fmt, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = [ pkgs.pre-commit pkgs.nixpkgs-fmt ];
          };
          packages = import ./default.nix { inherit pkgs; };
        }) // rec {
      overlay = import ./overlay.nix;
    };
}

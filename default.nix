{ final, prev, pkgs ? final, ... }:
let
  emacs29-macport = final.callPackage ./pkgs/overrides/emacs-macport/emacs-macport.nix { inherit (prev) emacs29-macport; };
in
{
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  tbb_2021 = final.callPackage ./pkgs/tbb { };
  nupack = final.callPackage ./pkgs/nupack { libsimdpp = final.libsimdpp; tbb = final.tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };

  inherit emacs29-macport;
  emacsMacportDebug = pkgs.enableDebugging emacs29-macport;

  lima = pkgs.callPackage ./pkgs/lima.nix { };

  # rocm-thunk = prev.callPackage ./pkgs/overrides/rocm-thunk.nix { rocm-thunk = prev.rocm-thunk; };
  sops-install-secrets = prev.callPackage ./pkgs/overrides/sops-install-secrets.nix { sops-install-secrets = prev.sops-install-secrets; };

  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
  vivado = pkgs.callPackage ./pkgs/vivado.nix { };
}

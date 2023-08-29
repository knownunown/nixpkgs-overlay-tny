{ final, prev, pkgs ? final, ... }:
let
  emacsMacport = final.callPackage ./pkgs/overrides/emacs-macport/emacs-macport.nix { inherit (prev) emacsMacport; };
in
{
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  tbb_2021 = final.callPackage ./pkgs/tbb { };
  nupack = final.callPackage ./pkgs/nupack { libsimdpp = final.libsimdpp; tbb = final.tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };

  inherit emacsMacport;
  emacsMacportDebug = pkgs.enableDebugging emacsMacport;

  lima = pkgs.callPackage ./pkgs/lima.nix { };

  # rocm-thunk = prev.callPackage ./pkgs/overrides/rocm-thunk.nix { rocm-thunk = prev.rocm-thunk; };
  sops-install-secrets = prev.callPackage ./pkgs/overrides/sops-install-secrets.nix { sops-install-secrets = prev.sops-install-secrets; };

  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
  vivado = pkgs.callPackage ./pkgs/vivado.nix { };
}

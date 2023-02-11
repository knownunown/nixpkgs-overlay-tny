{ final, prev, pkgs ? final, ... }: {
  libsimdpp = pkgs.callPackage ./pkgs/libsimdpp { };
  tbb_2021 = final.callPackage ./pkgs/tbb { };
  nupack = final.callPackage ./pkgs/nupack { libsimdpp = final.libsimdpp; tbb = final.tbb_2021; };

  discord = prev.callPackage ./pkgs/overrides/discord.nix { discord = prev.discord; };
  emacsMacport = final.callPackage ./pkgs/overrides/emacs-macport.nix { inherit (prev) emacsMacport; };

  # rocm-thunk = prev.callPackage ./pkgs/overrides/rocm-thunk.nix { rocm-thunk = prev.rocm-thunk; };
  sops-install-secrets = prev.callPackage ./pkgs/overrides/sops-install-secrets.nix { sops-install-secrets = prev.sops-install-secrets; };

  git-credential-keepassxc = pkgs.callPackage ./pkgs/git-credential-keepassxc.nix { };
  vivado = pkgs.callPackage ./pkgs/vivado.nix { };
}

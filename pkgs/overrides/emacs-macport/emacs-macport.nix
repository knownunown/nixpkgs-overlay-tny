{ lib, stdenv, fetchFromBitbucket, emacsMacport, llvmPackages_14, darwin }:
let
  version = "29.1-mac-10.0";
in
(emacsMacport.overrideAttrs (o: {
  inherit version;
  name = "emacs-mac-${version}";

  src = fetchFromBitbucket {
    owner = "mituharu";
    repo = "emacs-mac";
    rev = "emacs-${version}";
    hash = "sha256-TE829qJdPjeOQ+kD0SfyO8d5YpJjBge/g+nScwj+XVU=";
  };

  buildInputs = o.buildInputs ++ (with darwin.apple_sdk.frameworks; [ UniformTypeIdentifiers Accelerate ]);
  CFLAGS = [ "-include ${./noescape_noop.h}" ];
})).override {
  llvmPackages_6 = llvmPackages_14;
}

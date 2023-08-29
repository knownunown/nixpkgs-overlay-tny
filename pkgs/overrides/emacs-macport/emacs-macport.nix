{ lib, stdenv, fetchFromBitbucket, emacs29-macport, llvmPackages_14, darwin }:
(emacs29-macport.overrideAttrs (o: {
  buildInputs = o.buildInputs ++ (with darwin.apple_sdk.frameworks; [ UniformTypeIdentifiers Accelerate ]);
  CFLAGS = [ "-include ${./noescape_noop.h}" ];
})).override {
  llvmPackages_6 = llvmPackages_14;
}

{ emacsMacport, llvmPackages_14, darwin }:
(emacsMacport.overrideAttrs (o: {
  buildInputs = o.buildInputs ++ (with darwin.apple_sdk.frameworks; [ UniformTypeIdentifiers ]);
  patches = o.patches ++ [ ./0002-mac-gui-loop-block-autorelease.patch ]; 
})).override {
  llvmPackages_6 = llvmPackages_14;
}

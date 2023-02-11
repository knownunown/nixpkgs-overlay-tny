{ emacsMacport, llvmPackages_11, darwin }:
(emacsMacport.overrideAttrs (o: {
  buildInputs = o.buildInputs ++ (with darwin.apple_sdk.frameworks; [ UniformTypeIdentifiers ]);
})).override {
  llvmPackages_6 = llvmPackages_11;
}

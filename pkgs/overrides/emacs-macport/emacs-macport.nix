{ emacsMacport, llvmPackages_14, darwin }:
(emacsMacport.overrideAttrs (o: {
  buildInputs = o.buildInputs ++ (with darwin.apple_sdk.frameworks; [ UniformTypeIdentifiers ]);
  patches = o.patches ++ [ ./0001-mac-gui-loop-block-lifetime.patch ];
})).override {
  llvmPackages_6 = llvmPackages_14;
}

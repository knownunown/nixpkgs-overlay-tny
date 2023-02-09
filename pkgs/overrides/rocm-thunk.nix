{ rocm-thunk, lib }:
rocm-thunk.overrideAttrs (_: rec {
    cmakeFlags = [
        "-DCMAKE_INSTALL_INCLUDEDIR=include"
	"-DCMAKE_INSTALL_LIBDIR=lib"
    ];
})

{ lib
, clangStdenv
, fetchurl
, unzip
, cmake
, python38
, fmt
, tbb
, libsimdpp
, armadillo
, gecode
, nlohmann_json
, jsoncpp
, tclap
, spdlog
, boost
, lapack
, blas
, ...
}:

# TODO(tny): constexpr issues with gcc stdenv
# "other compilers are generally unsupported"
let
  python3 = python38;
  stdenv = clangStdenv;
in
stdenv.mkDerivation rec {
  pname = "nupack";
  version = "4.0.0.27";

  nativeBuildInputs = [ unzip cmake ] ++ (with python3.pkgs; [
    setuptoolsBuildHook
    pipInstallHook
  ]);

  buildInputs = [
    python3
    fmt
    tbb
    libsimdpp
    armadillo
    gecode
    nlohmann_json
    jsoncpp
    tclap
    spdlog
    boost
  ];

  propagatedBuildInputs = with python3.pkgs; [
    scipy
    numpy
    pandas
    jinja2
  ];

  # http://www.nupack.org/downloads
  # nix store prefetch-url file:///location/on/disk/of/nupack.zip
  # remember to update the hash.
  src = fetchurl {
    url = "http://localhost";
    name = "${pname}-${version}.zip";
    sha256 = "sha256-M7qpEY28YdJv3r5wZUGOQMn1UDUFyZ4gNy1TAbljKQA=";
  };

  patches = [ ./shared_h_parallelism.patch ];

  postUnpack = ''
    sourceRoot=''${sourceRoot}/source
  '';

  cmakeFlags = let
    soExt = if stdenv.isDarwin then "dylib" else "so";
  in [
    "-DCMAKE_CXX_STANDARD=17"
    "-DBLAS_LIBRARIES=${blas}/lib/libblas.${soExt}"
    "-DLAPACK_LIBRARIES=${lapack}/lib/liblapack.${soExt}"
  ];

  makeFlags = [
    "nupack-python"
  ];

  dontUseSetuptoolsBuild = true;

  # XX: setuptoolsBuildPhase calls postBuild itself.
  postBuild = ''
    postBuild=""
    setuptoolsBuildPhase
  '';
}

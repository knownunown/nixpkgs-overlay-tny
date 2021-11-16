{ lib
, stdenv
, fetchurl
, fetchFromGitHub
, cmake
, fixDarwinDylibNames
}:

stdenv.mkDerivation rec {
  pname = "tbb";
  version = "2021.3.0";

  src = fetchFromGitHub {
    owner = "oneapi-src";
    repo = "oneTBB";
    rev = "v${version}";
    sha256 = "sha256-eNLw88LOAvPIUgE8rF67VCJngsaaPUuEO0jV4Wsa4K8=";
  };

  /*
    patches = [
    # Fixes build with Musl.
    (fetchurl {
    url = "https://github.com/openembedded/meta-openembedded/raw/39185eb1d1615e919e3ae14ae63b8ed7d3e5d83f/meta-oe/recipes-support/tbb/tbb/GLIBC-PREREQ-is-not-defined-on-musl.patch";
    sha256 = "gUfXQ9OZQ82qD6brgauBCsKdjLvyHafMc18B+KxZoYs=";
    })

    # Fixes build with Musl.
    (fetchurl {
    url = "https://github.com/openembedded/meta-openembedded/raw/39185eb1d1615e919e3ae14ae63b8ed7d3e5d83f/meta-oe/recipes-support/tbb/tbb/0001-mallinfo-is-glibc-specific-API-mark-it-so.patch";
    sha256 = "fhorfqO1hHKZ61uq+yTR7eQ8KYdyLwpM3K7WpwJpV74=";
    })
    ];
  */

  nativeBuildInputs = [ cmake ] ++ lib.optionals stdenv.isDarwin [
    fixDarwinDylibNames
  ];

  makeFlags = lib.optionals stdenv.cc.isClang [
    "compiler=clang"
  ];

  cmakeFlags = [ "-DTBB_TEST=OFF" ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Intel Thread Building Blocks C++ Library";
    homepage = "http://threadingbuildingblocks.org/";
    license = licenses.asl20;
    longDescription = ''
      Intel Threading Building Blocks offers a rich and complete approach to
      expressing parallelism in a C++ program. It is a library that helps you
      take advantage of multi-core processor performance without having to be a
      threading expert. Intel TBB is not just a threads-replacement library. It
      represents a higher-level, task-based parallelism that abstracts platform
      details and threading mechanisms for scalability and performance.
    '';
    platforms = platforms.unix;
    maintainers = with maintainers; [ thoughtpolice dizfer ];
  };
}

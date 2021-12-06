{ lib
, fetchurl
, buildPythonPackage
}:

let
  pname = "lru-dict";
  version = "1.1.6";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "1k2lhd4dpl6xa6iialbwx4l6bkdzxmzhygms39pvf19x1rk5fm1n";
  };

  meta = {
    description = "An Dict like LRU container";
    homepage = https://github.com/amitdev/lru-dict;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}

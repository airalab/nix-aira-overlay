{ lib
, buildPythonPackage
, rustPlatform
, fetchPypi
, isPy38
}:


buildPythonPackage rec {
  pname = "py_sr25519_bindings";
  version = "0.1.4";
  format = "wheel";

  disabled = !isPy38;
  src = fetchPypi {
    inherit version format pname;
    sha256 = "128fp3wpri7s3hznwb6pr1sv49dlb715p8z8cw3ngigl9dxj9hfi";

    dist = "cp38";
    python = "cp38";
    abi = "cp38";
    platform = "manylinux_2_5_x86_64.manylinux1_x86_64";
  };

#  src = fetchPypi {
#    inherit pname version;
#    sha256 = "0vlpkqvnmqf44vbij1q3rv45rc992lpndfmnpzs4iw8lf2bwl4jy";
#  };

  meta = {
    description = "Python bindings for sr25519 library";
    homepage = "https://github.com/polkascan/py-ed25519-bindings";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}

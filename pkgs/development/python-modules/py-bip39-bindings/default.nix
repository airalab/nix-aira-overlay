{ lib
, buildPythonPackage
, isPy38
, fetchPypi
}:

buildPythonPackage rec {
  pname = "py_bip39_bindings";
  version = "0.1.9";
  format = "wheel";

  disabled = !isPy38;
  src = fetchPypi {
    inherit version format pname;
    sha256 = "0cbxw5z1jgbciy338i4r3671kx45nqzlwh9r1q567jf8mhwknp4j";

    dist = "cp38";
    python = "cp38";
    abi = "cp38";
    platform = "manylinux_2_5_x86_64.manylinux1_x86_64";
  };

  meta = {
    description = "Python bindings for the tiny-bip39 library";
    homepage = "https://github.com/polkascan/py-ed25519-bindings";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}

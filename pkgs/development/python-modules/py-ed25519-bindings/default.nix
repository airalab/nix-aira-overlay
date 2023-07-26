{ lib
, buildPythonPackage
, fetchPypi
, isPy38
}:


buildPythonPackage rec {
  pname = "py_ed25519_bindings";
  version = "1.0.1";
  format = "wheel";

  disabled = !isPy38;
  src = fetchPypi {
    inherit version format pname;
    sha256 = "0g1d4pnc2m55q29zcfbl82vjhpjm5nv9xmxcdq3pljxs72iqg7lm";

    dist = "cp38";
    python = "cp38";
    abi = "cp38";
    platform = "manylinux_2_5_x86_64.manylinux1_x86_64";
  };
#  src = fetchPypi {
#    inherit pname version;
#    sha256 = "1v9fvmsiihn2rx4i2i2wy85r2y15qjbkdx5zdghdsxiwnhxmqj5r";
#  };

#  propagatedBuildInputs = [
#    toml
#  ];

  meta = {
    description = "Python bindings for the ed25519-dalek RUST crate";
    homepage = "https://github.com/polkascan/py-ed25519-bindings";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}
#{ lib
#, buildPythonPackage
#, rustPlatform
#, fetchFromGitHub
#, fetchPypi
#}:

#let url = "https://files.pythonhosted.org/packages/d6/13/14440c23ca8599f6e023f5c31b4f25e16c08180aaa3bf82d392cd33f6190/py_ed25519_bindings-0.1.2-cp39-cp39-manylinux2010_x86_64.whl";

#in buildPythonPackage rec {
#  pname = "py_ed25519_bindings";
#  version = "0.1.2";

#  format = "wheel";
#  src = builtins.fetchurl {
#    inherit url;
#    sha256 = "sha256:0dzmlminb4mw8n7d7xf3hsppr7xaibkl1brk0h4ry33gr9l7d9mm";
#  };



#  meta = {
#    description = "Python bindings for the ed25519-dalek RUST crate";
#    homepage = "https://github.com/polkascan/py-ed25519-bindings";
#    license = lib.licenses.bsd3;
#    maintainers = with lib.maintainers; [ vourhey ];
#  };
#}

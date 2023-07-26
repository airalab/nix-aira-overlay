self: super: with self.lib; let

  pythonOverridesFor = superPython: fix (python: superPython.override ({
    packageOverrides ? _: _: {}, ...
  }: {
    self = python;
    packageOverrides = composeExtensions packageOverrides (pySelf: pySuper: {
      web3 = pySelf.callPackage ./web3 { };
      lru-dict = pySelf.callPackage ./lru-dict { };
      eth-abi = pySelf.callPackage ./eth-abi { };
      eth-account = pySelf.callPackage ./eth-account { };
      eth-hash = pySelf.callPackage ./eth-hash { };
      eth-keyfile = pySelf.callPackage ./eth-keyfile { };
      eth-keys = pySelf.callPackage ./eth-keys { };
      eth-rlp = pySelf.callPackage ./eth-rlp { };
      eth-typing = pySelf.callPackage ./eth-typing { };
      eth-utils = pySelf.callPackage ./eth-utils { };
      websockets6 = pySelf.callPackage ./websockets/6.nix { };
      websockets9 = pySelf.callPackage ./websockets { };
      hexbytes = pySelf.callPackage ./hexbytes { };
      python-persistent-queue = pySelf.callPackage ./python-persistent-queue { };
      pinatapy = pySelf.callPackage ./pinatapy { };
#      ipfsapi = pySelf.callPackage ./ipfsapi { };
      multihash = pySelf.callPackage ./multihash { };
      scalecodec = pySelf.callPackage ./scalecodec { };
      robonomics-interface = pySelf.callPackage ./robonomics-interface { };
      substrate-interface = pySelf.callPackage ./substrate-interface { };
      py-sr25519-bindings = pySelf.callPackage ./py-sr25519-bindings { };
      py-ed25519-bindings = pySelf.callPackage ./py-ed25519-bindings { };
      py-bip39-bindings = pySelf.callPackage ./py-bip39-bindings { };
      sensors-connectivity = pySelf.callPackage ./sensors-connectivity { };
      ipfshttpclient = pySelf.callPackage ./ipfshttpclient { };
      httpcore = pySuper.httpcore.overridePythonAttrs (oldAttrs: rec {
#        disabled = false;
        doCheck = false;
      });
    });
  }));
in {
  python27 = pythonOverridesFor super.python27;
  python37 = pythonOverridesFor super.python37;
  python38 = pythonOverridesFor super.python38;
  python39 = pythonOverridesFor super.python39;
  python310 = pythonOverridesFor super.python310;
}     

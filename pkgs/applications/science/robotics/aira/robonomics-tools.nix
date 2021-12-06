{ mkDerivation, aeson, async, base, base58string, bytestring
, exceptions, generics-sop, hashable, hpack, pipes, memory, http-conduit
, microlens, monad-control, monad-logger, mtl, optparse-applicative
, unordered-containers, heap, cryptonite, data-default, process, lib, text, web3
, fetchFromGitHub
}:

mkDerivation rec {
  pname = "robonomics-tools";
  version = "0.6.0.2";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
#    rev = "v${version}";
    rev = "764b7681bb1d87eb351d4de8425c354f9a148e93";
    sha256 = "1aihvwbhil3i529s3dcflkcb9lq6lli5g332g5jj9k68kah8aym5";
  };

  isLibrary = false;
  isExecutable = true;

  preConfigure = "${hpack}/bin/hpack";
  executableHaskellDepends = [
    aeson async base base58string bytestring pipes http-conduit
    unordered-containers cryptonite data-default exceptions generics-sop
    memory microlens monad-control monad-logger mtl hashable
    optparse-applicative process text heap web3
  ];

  homepage = "https://github.com/airalab/robonomics-tools#readme";
  description = "Robonomics.network tools";
  license = lib.licenses.bsd3;
  maintainers = with lib.maintainers; [ akru ];
}

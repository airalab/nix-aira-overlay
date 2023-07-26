{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "ipfs";
  version = "0.9.0";
  rev = "v${version}";

  # go-ipfs makes changes to it's source tarball that don't match the git source.
  src = fetchurl {
    url = "https://github.com/ipfs/kubo/releases/download/${rev}/go-ipfs_${rev}_linux-amd64.tar.gz";
    sha256 = "sha256-5zf9bMvRkX0wL83J6NKdWPpFbdao+Sg1vinwYMbdyWc=";
  };

  dontBuild = true;
  sourceRoot = ".";

  phases = "installPhase fixupPhase";

  installPhase = ''
   mkdir -p $out/bin
   tar -xvf ${src} 
   mv go-ipfs/ipfs $out/bin
   chmod +x $out/bin/ipfs
   patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
   --set-rpath "$libPath" $out/bin/ipfs
  '';

  meta = with lib; {
    description = "A global, versioned, peer-to-peer filesystem";
    homepage = "https://ipfs.io/";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ fpletz ];
  };
}

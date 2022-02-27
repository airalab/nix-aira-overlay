{ lib	
, stdenv
, fetchurl
, libgcc
, openssl
, zlib
, systemd
}:

let
  arch = if stdenv.hostPlatform.system == "x86_64-linux" then "x86_64"
    else if stdenv.hostPlatform.system == "aarch64-linux" then "aarch64"
    else throw "Encryptr for ${stdenv.hostPlatform.system} not supported!";

  sha256 = if stdenv.hostPlatform.system == "x86_64-linux" then "1gvp5mpwqx7yv73kp0llnbr0zv589dk79n2rpwr5bbkcmc768mq6"
    else if stdenv.hostPlatform.system == "aarch64-linux" then "05q1am4sq48dfwk64r5xa7kkar1x2m9xmh88r80xfhp3hg47sl0i"
    else throw "Encryptr for ${stdenv.hostPlatform.system} not supported!";

in stdenv.mkDerivation rec {
   name = "robonomics-bin-${version}";
   version = "1.7.1";
   repoUrl = "https://github.com/airalab/robonomics";
   src = fetchurl {
      url = "${repoUrl}/releases/download/v${version}/robonomics-${version}-${arch}-unknown-linux-gnu.tar.gz";
      inherit sha256;
   };
  dontBuild = true;
  sourceRoot = ".";
  libPath = lib.makeLibraryPath
    [ libgcc
      openssl
      stdenv.cc.cc.lib # libstdc++.so.6
      zlib
      systemd
    ];

  phases = "installPhase fixupPhase";

  installPhase = ''
   mkdir -p $out/bin
   tar -xf ${src} --directory $out/bin
   chmod +x $out/bin/robonomics
   patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
   --set-rpath "$libPath" $out/bin/robonomics
  '';

   meta = {
      description = "Robonomics on Substrate node";
      homepage = https://github.com/airalab/substrate-node-robonomics;
      license = lib.licenses.asl20;
      maintainers = [ "spd - spd@aira.life" ];
      platforms = [ "x86_64-linux" "aarch64-linux" ];
   };
}

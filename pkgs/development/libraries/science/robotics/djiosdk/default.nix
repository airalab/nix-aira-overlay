{ lib
, stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation rec {
  name = "djiosdk-${version}";
  version = "3.7.0";

  src = fetchFromGitHub {
    owner = "dji-sdk";
    repo = "Onboard-SDK";
    rev = version;
    sha256 = "0vyphabyh7m9i60kiw111rscmjcazw9n1a5xhf6dwcpjb35yqb7g";
  };

  buildInputs = [ cmake ];

  meta = with lib; {
    description = "DJI Onboard SDK";
    homepage = https://github.com/dji-sdk/Onboard-SDK;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };
}

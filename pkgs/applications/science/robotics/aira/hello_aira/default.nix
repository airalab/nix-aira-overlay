{ stdenv
, buildRosPackage
, robonomics_comm-nightly
, python3Packages
, fetchFromGitHub
, pkgs
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "hello_aira";
  version = "48c07e1";

  src = fetchFromGitHub {
    owner = "Vourhey";
    repo = pname;
    rev = "48c07e162633cf157c326cea24aa89a187562a2e";
    sha256 = "1cvdcrfr0cildh2z9qlc7dxsdjg0v7p4mivcvgrnmnrhnba9kdhi";
  };

  propagatedBuildInputs = [
    robonomics_comm-nightly
  ];

  meta = with pkgs.lib; {
    description = "";
    homepage = http://github.com/vourhey/hello_aira;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

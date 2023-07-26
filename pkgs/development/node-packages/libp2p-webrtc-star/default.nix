{ stdenv
, pkgs
, lib
, nodejs_18
}:

let
  nodejs = nodejs_18;

  nodePackages = import ./node-packages.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };

  libp2p-webrtc-star = lib.head (lib.attrValues nodePackages);

  combined = libp2p-webrtc-star.override {
    meta = with lib; {
      description = "libp2p-webrtc-star is one of the WebRTC transports available for libp2p.";
      license = with licenses; [ asl20 ];
      homepage = "https://github.com/libp2p/js-libp2p-webrtc-star";
#      maintainers = with maintainers; [ iblech ];
      platforms = platforms.unix;
    };
  };
in
  combined

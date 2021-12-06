{
nixpkgs.overlays = let
    nix-ros-overlay = builtins.fetchTarball {
      url = https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz;
      sha256 = "15ng9d5lj93qi7nv18cdcpimw2y3j61by9g1sp5llanf2mmwsvjk";

    };
in [ (import (nix-ros-overlay + "/overlay.nix")) ];
}

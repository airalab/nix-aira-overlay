{ pkgs ? import <nixpkgs> { } }:
#{ nixpkgs ? builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz"
#, nix-ros-overlay ? builtins.fetchTarball https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz
#, overlays ? [], ... }@args: import nixpkgs {
#  overlays = [ (import (nix-ros-overlay + "/overlay.nix")) (import ./overlay.nix) ] ++ overlays;
#} // args
with pkgs; {
  lib = import ./lib { inherit pkgs; }; # functions
#  modules = import ./nixos/modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

#  (import ./pkgs)

#  import ./pkgs;
#  adb-sync = callPackage ./pkgs/adb-sync { };
#  adx = callPackage ./pkgs/adx { };
#  bundletool-bin = callPackage ./pkgs/bundletool-bin { };
#  diffuse-bin = callPackage ./pkgs/diffuse-bin { };
#  gdrive = callPackage ./pkgs/gdrive { };
#  hcctl = callPackage ./pkgs/hcctl { };
#  healthchecks-monitor = callPackage ./pkgs/healthchecks-monitor { };
#  jetbrains-mono-nerdfonts =
#    callPackage ./pkgs/jetbrains-mono-nerdfonts { };
#  pidcat = callPackage ./pkgs/pidcat { };
}

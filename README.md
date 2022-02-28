# nix-aira-overlay

```let
  nix-ros-overlay = builtins.fetchTarball {
    url = https://github.com/lopsided98/nix-ros-overlay/archive/5a881cc7b5a96be946b6d360bb1a19c7ef07c524.tar.gz;
    sha256 = "0nbmg78ig6js61f3h7lnqh1rwidabkdpfzsgavvxjiw5nankmzjg";
  };
  nix-aira-overlay = builtins.fetchTarball {
    url = https://github.com/airalab/nix-aira-overlay/archive/master.tar.gz;
    sha256 = "0d5q9nyw26r80ddnv5bryp7hwa5qkfrxsg4sdccm3k1xd4hi6v3c";
  };
in
...
{
  nixpkgs = {
    overlays = [
      (import (nix-ros-overlay + "/overlay.nix"))
      (import (nix-aira-overlay + "/overlay.nix"))
    ];
  };
}
```

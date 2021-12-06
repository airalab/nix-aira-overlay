{ config, pkgs, lib, ... }:

{

  imports = [ ../profiles/aira-unstable.nix ];

  # https://github.com/NixOS/nixpkgs/issues/26776
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  services = {
    # Enable OpenSSH by default
    openssh.enable = true;

    # Enable mouse integration
    gpm.enable = true;

    # Enable telemetry node
    liability-nightly.graph = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    loginShellInit = ''
      echo -e "Starting..."
      sleep 5
      ${pkgs.figlet}/bin/figlet AIRA
      echo "\naira-unstable"
      export ADDRESS=`cat /var/lib/liability/keyfile|${pkgs.jq}/bin/jq ".address"`
      echo -e "\nMy Ethereum address is $ADDRESS"
      export ID=`${pkgs.ipfs}/bin/ipfs --api /ip4/127.0.0.1/tcp/5001 id|${pkgs.jq}/bin/jq ".ID"`
      echo -e "\nLook me at https://dapp.robonomics.network by $ID\n\n"
    '';
    shellInit = ''
      source ${pkgs.robonomics_tutorials}/setup.zsh
      source ${pkgs.hello_aira}/setup.zsh
    '';
  };

  # Allow the user to log in as root without a password.
  users.extraUsers.root.shell = pkgs.zsh;

  # Root autologin
  users.extraUsers.root.initialHashedPassword = "";
  services.getty.autologinUser = "root";

  # Useful preinstall utils
  environment.systemPackages = with pkgs; [
    vim git htop screen mosh cmake gcc substrate-node-robonomics-bin hello_aira
  ];

}

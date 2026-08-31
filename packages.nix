{ config, pkgs, ... }:

{

environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      websockets
    ]))
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    syncthing
    keepassxc
    thunderbird
    kdePackages.oxygen
    kdePackages.oxygen-sounds
    librewolf
    discord
    htop
    libreoffice
    mullvad
    cava
    kdePackages.qtwebsockets
    python3
    smartmontools
    fastfetch
    jetbrains-toolbox
    zsh-powerlevel10k
    krita
    electrum
  ];

}

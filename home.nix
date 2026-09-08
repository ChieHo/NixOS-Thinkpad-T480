{ config, pkgs, ... }:
{
  home.username = "chieho";
  home.homeDirectory = "/home/cchong";

  # don't change after first installation
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [ websockets ]))
    vim
    wget
    keepassxc
    thunderbird
    librewolf
    discord
    htop
    libreoffice
    cava
    smartmontools
    fastfetch
    jetbrains-toolbox
    krita
    electrum
    rpi-imager
    syncthing
    kdePackages.oxygen
    kdePackages.oxygen-sounds
    kdePackages.qtwebsockets
    mullvad
    tlp
    kdePackages.kalk
  ];

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Chie-Ho";
      user.email = "chieho.c@tutanota.com";
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}

{ config, pkgs, ...}:
{
  home.username = "chieho";
  home.homeDirectory = "/home/cchong";
  
  #don't change after first installation
  home.stateVersion = "26.05";

  home.packages = with pkgs;[
    (python3.withPackages (ps: with ps; [ websockets ]))
  wget
  git
  keepassxc
  thunderbird
  librewolf
  discord
  htop
  libreoffice
  cava
  python3
  smartmontools
  fastfetch
  jetbrains-toolbox
  krita
  electrum    
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
    userName = "Chie-Ho";
    userEmail = "chieho.c@tutanota.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  
  programs.home-manager.enable = true;

}

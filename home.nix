{ config, pkgs, ...}:
{
  home.username = "chieho";
  home.homeDirectory = "/home/cchong";
  
  #don't change after first installation
  home.stateVersion = "26.05"

  home.packages = with okgs;[
    
  ];

  programs.git = {
    enable = true;
    userName = "Chie-Ho"
    userEmail = "chieho.c@tutanota.com"
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  
  programs.home-manager.enable = true;

}

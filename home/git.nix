{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Juan Eiros";
    userEmail = "jeirosz@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
} 
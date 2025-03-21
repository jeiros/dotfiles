{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "juan";
  home.homeDirectory = "/home/juan";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Packages to install for your user
  home.packages = with pkgs; [
    # Add user packages here
  ];

  # Manage dotfiles with home-manager
  # Example for alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "Berkeley Mono";
        normal.style = "Regular";
        bold.family = "Berkeley Mono";
        bold.style = "Bold";
        italic.family = "Berkeley Mono";
        italic.style = "Oblique";
        bold_italic.family = "Berkeley Mono";
        bold_italic.style = "Bold Oblique";
        size = 12;
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You should not change this value, even if you update Home Manager.
  # If you do want to update the value, then make sure to first check the
  # Home Manager release notes.
  home.stateVersion = "24.11"; # Use the same version as your NixOS
} 
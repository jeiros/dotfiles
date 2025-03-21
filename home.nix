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

  home.stateVersion = "24.11"; # Use the same version as your NixOS
} 

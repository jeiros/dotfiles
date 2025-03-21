{ config, pkgs, ... }:

{
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
} 
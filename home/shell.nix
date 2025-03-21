{ config, pkgs, ... }:

{
  # Enable Zsh for the user
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    # History configuration
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
    };
    
    # Oh-My-Zsh configuration
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };
    
    # Shell aliases
    shellAliases = {
      l = "ls -l";
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nixos-rebuild switch --upgrade";
      config = "cd ~/.config/nixos && ${pkgs.neovim}/bin/nvim .";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";
      gd = "git diff";
      gl = "git log --oneline --graph --decorate";
    };
    
    # Additional Zsh options
    initExtra = ''     
      # Custom functions
      function mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Welcome message
      echo "Welcome to NixOS, $(whoami)!"
    '';
  };
  
  # Install additional shell utilities
  home.packages = with pkgs; [
    zsh             # Include zsh in user packages
    fzf             # Fuzzy finder
    zsh-autosuggestions
  ];
  
  # Set Zsh as the default shell for the user session
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
  
  # This tells Home Manager to manage your shell
  programs.bash.enable = true; # Keep bash available as fallback
  
  home.file.".profile".text = ''
    # If running bash
    if [ -n "$BASH_VERSION" ]; then
      # Include .bashrc if it exists
      if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
      fi
    fi
    
    # Set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
      PATH="$HOME/bin:$PATH"
    fi
    
    # Set PATH so it includes user's private .local/bin if it exists
    if [ -d "$HOME/.local/bin" ] ; then
      PATH="$HOME/.local/bin:$PATH"
    fi
    
    # Start zsh if it's available
    if [ -x "$(command -v zsh)" ]; then
      exec zsh
    fi
  '';
} 

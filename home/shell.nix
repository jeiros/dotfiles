{ config, pkgs, ... }:

{
  # Enable Zsh for the user
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
        "docker"
        "sudo"
        "command-not-found"
        "history"
        "extract"
      ];
      theme = "robbyrussell";
    };
    
    # Shell aliases
    shellAliases = {
      ll = "ls -la";
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
      # Set up direnv hook if installed
      if command -v direnv &> /dev/null; then
        eval "$(direnv hook zsh)"
      fi
      
      # Better command history navigation with arrow keys
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      
      # Set default editor
      export EDITOR=nvim
      export VISUAL=nvim
      
      # Custom functions
      function mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Colorize man pages
      export LESS_TERMCAP_mb=$'\e[1;31m'
      export LESS_TERMCAP_md=$'\e[1;31m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[1;44;33m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;32m'
      
      # Welcome message
      echo "Welcome to NixOS, $(whoami)!"
    '';
    
    # Zsh plugins not available in oh-my-zsh
    plugins = [
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
  };
  
  # Install additional shell utilities
  home.packages = with pkgs; [
    zsh             # Include zsh in user packages
    fzf             # Fuzzy finder
    bat             # Better cat
    exa             # Modern ls replacement
    ripgrep         # Fast grep replacement
    fd              # Simple, fast alternative to find
    htop            # Interactive process viewer
    tldr            # Simplified man pages
    jq              # JSON processor
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
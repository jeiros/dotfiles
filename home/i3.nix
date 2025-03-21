{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod1";
      terminal = "alacritty";
      fonts = {
        names = [ "DejaVu Sans Mono" ];
        size = 8.0;
      };
      workspaceLayout = "default";
      
      # Keybindings
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in {
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec --no-startup-id dmenu_run";
        
        # Focus
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+ntilde" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        
        # Move
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+ntilde" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        
        # Split
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        
        # Fullscreen
        "${modifier}+f" = "fullscreen toggle";
        
        # Layout
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        
        # Floating
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        
        # Focus parent/child
        "${modifier}+a" = "focus parent";
        
        # Workspace switching
        "${modifier}+Tab" = "workspace next";
        "${modifier}+Shift+Tab" = "workspace prev";
        
        # Workspace selection
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        
        # Move to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        
        # Reload/restart
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
        
        # Resize mode
        "${modifier}+r" = "mode resize";
        
        # Keyboard layout toggle
        "Mod4+space" = "exec setxkbmap -layout gb,es -option grp:win_space_toggle";
      };
      
      # Resize mode
      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "ntilde" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
          "${config.xsession.windowManager.i3.config.modifier}+r" = "mode default";
        };
      };
      
      # Bar configuration
      bars = [{
        statusCommand = "i3status";
        position = "bottom";
      }];
      
      # Startup applications
      startup = [
        { command = "dex --autostart --environment i3"; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock --nofork"; notification = false; }
        { command = "nm-applet"; notification = false; }
        { command = "setxkbmap -layout gb"; notification = false; }
      ];
      
      # Window behavior
      floating = {
        modifier = "Mod1";
        titlebar = true;
      };
    };
    extraConfig = ''
      # Use pactl to adjust volume in PulseAudio
      set $refresh_i3status killall -SIGUSR1 i3status
      bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
      bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
      bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
      bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
      
      # Move tiling windows via drag & drop
      tiling_drag modifier titlebar
    '';
  };
} 
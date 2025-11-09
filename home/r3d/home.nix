{ config, pkgs, ... }:

let
  personal = builtins.pathExists ./git-personal.nix;
  gitConfig =
    if personal then import ./git-personal.nix { inherit config pkgs; } else import ./git-demo.nix { inherit config pkgs; };
in
 
{

  # Import Git configuration
  imports = [ gitConfig ];

  # User configs
  home.username = "r3d";
  home.homeDirectory = "/home/r3d";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # User-level apps...
  home.packages = with pkgs; [
    tree
    helix
    waybar
    fuzzel
    mako
    foot
    zellij
    wl-clipboard
    swaybg
    grim
    slurp
    bibata-cursors
  ];
 
  # Enable notifications
  services.mako.enable = true;

  # Example enable foot config
  programs.foot = {
    enable = true;
    settings.main = {
      font = "JetbrainsMono Nerd Font:size=11";
      dpi-aware = "no";
      shell = "zellij";
    };
  };

  # Github Configuration
  programs.git = {
    enable = true;
  };

  # Waybar config
  programs.waybar.enable = true;

  # Basic environment variables for user sesssion
    home = {
    sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      QT_QPA_PLATFORMTHEME = "gtk2";
  };
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic-Right";
      package = pkgs.bibata-cursors;
      size = 24;
      x11.enable = true; # For X11 apps
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}

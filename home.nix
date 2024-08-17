{ config, pkgs, ... }:

{

    imports = [
          ./modules/user/zsh/zsh.nix
          ./modules/user/themes/themes.nix
    ];

  home.username = "ehwazm";
  home.homeDirectory = "/home/ehwazm";


  home.stateVersion = "24.05"; # Please read the comment before changing.


  home.packages = [

     pkgs.hello

  ];

  home.file = {
  };

  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

    services.cliphist = {
        enable = true;
        allowImages = true;
    };

    home.pointerCursor = {
        name = "Bibata-Original-Classic";
        size = 20;
        package = pkgs.bibata-cursors;
        gtk.enable = true;
    };


  services.gnome-keyring.enable = true;


    xdg.mimeApps = {
        enable = true;
        associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        };
        defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        };
    };

  # wayland.windowManager.hyprland.enable = true;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

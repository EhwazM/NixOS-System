{config, pkgs, ...}:

{
    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "kvantum";
    };

    home.file.".config/Kvantum/" = {
        source = ./kvantum;
        recursive = true;
    };

    gtk = {
        enable = true;

        theme = {
            name = "Breeze-Dark";
            package = pkgs.breeze-gtk;
        };
        
        font = {
            name = "Noto Sans Regular";
            size = 10;
        };

        iconTheme = {
            name = "WhiteSur-dark";
            package = pkgs.whitesur-icon-theme;
        };
    };

}

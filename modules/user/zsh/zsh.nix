{config, pkgs, ...}:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
	        nv = "nvim";
        };
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
        };
    };
}

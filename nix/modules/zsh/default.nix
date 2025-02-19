{ config, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
	    enable = true;
	    theme = "robbyrussell";
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export PATH="$PATH:${config.home.homeDirectory}/.local/bin"
      export EDITOR="nvim"
    '';

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}


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
      mkdir -p ${config.home.homeDirectory}/.nvm # Doesn't recreate or error if exists
      export NVM_DIR="${config.home.homeDirectory}/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      sm = "git submodule update --init --recursive";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}


{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
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
      eval "$(pyenv init -)"
      export CLAUDE_CODE_USE_VERTEX=1
      export ANTHROPIC_SMALL_FAST_MODEL='claude-3-5-haiku@20241022'
      export CLOUD_ML_REGION='europe-west1'
      export VERTEX_REGION_CLAUDE_4_1_OPUS='europe-west4'
      export VERTEX_REGION_CLAUDE_4_0_OPUS='europe-west4'
      export ANTHROPIC_VERTEX_PROJECT_ID=spotify-claude-code-trial
      nv() {
        local title
        # Check if we are in a git repository
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
          # If yes, use the repo's root directory name as the title
          title=$(basename "$(git rev-parse --show-toplevel)")
        else
          # Otherwise, use the current directory's name
          title=$(basename "$PWD")
        fi

        # Set the terminal title using a standard escape sequence
        printf "\e]2;%s\a" "$title"

        # Execute the actual nvim command with any arguments you passed
        command nvim "$@"
      }

      # Enable history search with up/down arrows using raw escape codes
      bindkey '^[[A' history-beginning-search-backward
      bindkey '^[[B' history-beginning-search-forward

      autoload -U promptinit; promptinit
      prompt pure
      # Optimise for monorepos
      PRE_GIT_PULL=0
      PURE_GIT_UNTRACKED_DIRTY=0
      # PURE_GIT_DELAY_DIRTY_CHECK=1800

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


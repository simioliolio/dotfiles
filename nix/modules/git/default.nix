{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      br = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      l = "log --pretty=format:'%C(cyan)%h%Creset %C(green)%ad%Creset %C(yellow)%an%Creset: %C(reset)%s' --date=short --abbrev-commit";
    };
    extraConfig = {
      core = {
        editor = "vim";
      };
      include.path = "~/.config/git/writable_config";
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
    };
    lfs.enable = true;
  };
}


{ ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        editor = "vim";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
    };
  };
}


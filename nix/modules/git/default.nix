{ ... }:
{
  programs.git.extraConfig = {
    core = {
      editor = "vim";
    };
    push = {
      autoSetupRemote = true;
    };
  }
}


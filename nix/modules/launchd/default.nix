{ pkgs, ... }:
{
  launchd.agents = {
    gridStartup = {
      enable = true;
      config = {
        Program = "/Applications/Grid.app/MacOS/Grid";
        RunAtLoad = true;
      };
    };
    kittyStartup = {
      enable = true;
      config = {
        KeepAlive = true;
        Program = "${pkgs.kitty}/bin/kitty";
        RunAtLoad = true;
      };
    };

    ghosttyStartup = {
      enable = true;
      config = {
        KeepAlive = true;
        Program = "/Applications/Ghostty.app/Contents/MacOS/ghostty";
        RunAtLoad = true;
      };
    };
  };
}

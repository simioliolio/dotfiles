{ ... }:
{
  launchd.agents = {
    gridStartup = {
      enable = true;
      config = {
        Program = "/Applications/Grid.app/MacOS/Grid";
        RunAtLoad = true;
      };
    };
  };
}

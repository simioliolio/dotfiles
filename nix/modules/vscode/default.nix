{ config, ... }:
{
  programs.vscode.profiles.userSettings = {
    "files.autoSave" = "afterDelay";
  };
}


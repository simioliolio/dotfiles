{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  home.file.".config/git/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/dotfiles/nix/modules/git/config";
  };
}


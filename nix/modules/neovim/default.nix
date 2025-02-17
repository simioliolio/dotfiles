{ config, ... }:
{
  # xdg.configFile = {
  #   nvim = {
  #     source = ./config;
  #     recursive = true;
  #   };
  # };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/dotfiles/nix/modules/neovim/config";
  };
}


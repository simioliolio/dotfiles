{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ruff
      stylua
    ];
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/dotfiles/nix/modules/neovim/config";
  };
}


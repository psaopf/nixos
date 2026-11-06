{ config, pkgs, ... }:
{
  home-manager.users.p = { pkgs, ... }: {
    home.stateVersion = "26.05";

    programs.git = {
      enable = true;
      settings = {
        user.name = "psao";
        # Email is kept out of the repo: put it in ~/.config/git/local
        # (not managed by Nix), e.g.:  [user] email = you@example.com
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
      includes = [ { path = "~/.config/git/local"; } ];
    };

    # ungoogled-chromium is installed and configured here rather than in
    # systemPackages so home-manager can declaratively manage extensions.
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
        "mgngbgbhliflggkamjnpdmegbkidiapm" # Remove YouTube Shorts
        "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
      ];
    };

    ### DESKTOP SETTINGS + SHORTCUTS ###

    dconf.settings = {
      "org/cinnamon/muffin" = {
        edge-tiling = true;
      };
      "org/cinnamon/desktop/wm/preferences" = {
        tile-maximize = true;
      };
      "org/cinnamon/desktop/interface" = {
        clock-use-24h = false;
      };
      "org/cinnamon/sounds" = {
        tile-enabled = false;
      };
      "org/nemo/preferences" = {
        default-folder-viewer = "list-view";
      };

      "org/cinnamon/desktop/keybindings" = {
        custom-list = [ "custom0" "custom1" ];
      };
      "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
        name = "Open Terminal";
        command = "ghostty";
        binding = [ "<Control><Shift>p" ];
      };
      "org/cinnamon/desktop/keybindings/custom-keybindings/custom1" = {
        name = "Screen Shot";
        command = "flameshot gui";
        binding = [ "<Super><Shift>s" ];
      };
    };

    # Create new folder nemo shortcut
    home.file.".config/nemo/accels/nemo".text =
      ''(gtk_accel_path "<Actions>/ShellActions/NewFolder" "<Primary>d")'';
  };
}

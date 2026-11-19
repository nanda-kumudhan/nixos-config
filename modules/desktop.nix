{ config, lib, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling
      brightnessctl
      bluetui
      dunst
      foot
      grim
      htop
      imv
      kanshi
      mpv
      nwg-look
      pavucontrol
      playerctl
      polkit_gnome
      rofi
      slurp
      swaybg
      swayidle
      swaylock
      thunar
      waybar
      wdisplays
      wf-recorder
      xarchiver
      zathura
    ];
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Select Output:'";
      };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [
        "wlr"
        "gtk"
      ];
      sway = {
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = lib.concatStringsSep " " [
      (lib.getExe pkgs.tuigreet)
      "--cmd ${lib.getExe config.programs.sway.package}"
      "--env XDG_SESSION_TYPE=wayland"
      "--sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
    ];
  };

  security.polkit.enable = true;
  security.pam.services.greetd = {
    allowNullPassword = lib.mkForce false;
    enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  programs.starship.enable = true;

}

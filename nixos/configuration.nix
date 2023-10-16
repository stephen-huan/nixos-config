# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, modulesPath, options, ... }:

let
  password-store = "/home/ikue/.password-store/encryption/tuxedo";
in
{
  boot.kernelParams = [ "boot.shell_on_fail" ];

  boot.initrd.luks.devices.cryptlvm.device =
    "/dev/disk/by-uuid/5d57809c-d0e9-49e9-939e-f5d68392faf4";
  # https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=755" ];
  };
  # manually specify because `nixos-generate-config` doesn't pick it up
  fileSystems."/persistent" = {
    device = "/dev/VolumeGroup/root";
    fsType = "ext4";
    neededForBoot = true;
  };
  # https://nixos.wiki/wiki/Filesystems
  fileSystems."/nix" = {
    device = "/persistent/nix";
    options = [ "bind" ];
  };
  # overwrite ./hardware-configuration.nix
  swapDevices = lib.mkForce
    [
      { device = "/dev/VolumeGroup/swap"; }
    ];

  # overwrite /installer/netboot/netboot-minimal.nix
  hardware.enableRedistributableFirmware = lib.mkForce true;

  hardware.tuxedo-keyboard.enable = true;

  # hidden option. see: nixos/modules/config/shells-environment.nix
  # follow nixpkgs's default sandbox shell (which shouldn't pull in deps)
  # see https://github.com/NixOS/nix/blob/master/flake.nix
  environment.binsh = "${pkgs.busybox-sandbox-shell}/bin/busybox";
  # hidden option. see: nixos/modules/system/activation/activation-script.nix
  # remove /usr/bin/env for reproducibility or purity or whatever
  environment.usrbinenv = null;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    # https://www.pixiv.net/artworks/57200827
    splashImage = import ./figures/splashImage.nix;
    # https://github.com/NixOS/nixpkgs/issues/243026
    efiInstallAsRemovable = true;
    extraGrubInstallArgs = [
      "--disable-shim-lock"
    ];
  };

  networking.hostName = "sora"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking = {
    wireless.iwd.enable = true;
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
      wlan0.useDHCP = true;
    };
    dhcpcd = {
      enable = true;
      runHook = "";
    };
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.ikue = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable `sudo` for the user.
    hashedPasswordFile = "${password-store}/ikue.yescrypt";
    packages = with pkgs; [
      # todo remove
      firefox
      tree
    ];
    shell = pkgs.fish;
  };
  users.users.root.hashedPasswordFile = "${password-store}/root.yescrypt";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    xorg.xkbcomp
    git # required for flakes
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # todo
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "ikue";
  services.xserver.windowManager.i3.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = true;
  services.mullvad-vpn.package = pkgs.mullvad; # cli only

  services.locate = {
    enable = true;
    interval = "never";
    localuser = null;
    prunePaths = options.services.locate.prunePaths.default ++ [
      "/persistent"
    ];
    package = pkgs.plocate;
  };

  programs.nano.enable = false; # disable default nano
  programs.fish.enable = true;
  programs.fuse.userAllowOther = true;

  security.sudo.wheelNeedsPassword = false;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans" "IPAGothic" ];
      serif = [ "Noto Serif" "IPAMincho" ];
      monospace = [ "Noto Sans Mono" "IPAGothic" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/260658
  system.activationScripts.usrbinenv =
    lib.mkIf (config.environment.usrbinenv == null) (
      lib.mkForce ''
        rm -f /usr/bin/env
        if test -e /usr/bin; then
          rmdir --ignore-fail-on-non-empty /usr/bin
        fi
        if test -e /usr; then
          rmdir --ignore-fail-on-non-empty /usr
        fi
      ''
    );
  systemd.services.systemd-update-done.serviceConfig.ExecStart = [
    "" # clear
    (
      pkgs.writeShellScript "systemd-update-done-wrapper" ''
        mkdir -p /usr
        ${pkgs.systemd}/lib/systemd/systemd-update-done
        rmdir --ignore-fail-on-non-empty /usr
      ''
    )
  ];

  nix = {
    channel.enable = false;
    settings.trusted-users = [ "root" "ikue" "@wheel" ];
  };
}


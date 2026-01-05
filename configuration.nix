
{ config, pkgs, ... }:

{
    imports =
	[ 
	# include
	./hardware-configuration.nix
	    ./borg_petra.nix
	    ./borg_petra_nas.nix

	];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # host
    networking.hostName = "petra-laptop"; 

    # networking
    networking.networkmanager.enable = true;

    # time zone.
    time.timeZone = "America/Edmonton";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    # KDE wayland
    services = {
	desktopManager.plasma6.enable = true;
	displayManager.sddm.enable = true;
	displayManager.sddm.wayland.enable = true;
    };

    # CUPS 
    services.printing.enable = true;

    # tailscale
    services.tailscale.enable = true;

    # pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
    };

    # waydroid
    virtualisation.waydroid.enable = true;

    # steam
    programs.steam = {
	enable = true;
	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # flatpak
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
	wantedBy = [ "multi-user.target" ];
	path = [ pkgs.flatpak ];
	script = ''
	    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	    '';
    };

    # user account 
    users.users.petra = {
	isNormalUser = true;
	description = "petra";
	extraGroups = [ "networkmanager" "wheel" ];
    };

    # user account 
    users.users.blair = {
	isNormalUser = true;
	description = "blair";
	extraGroups = [ "networkmanager" "wheel" ];
    };



    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # system packages
    environment.systemPackages = with pkgs; [

	borgbackup
	    git
	    firefox
	    syncthing
	    neovim
	    tailscale
	    alacritty  
	    libreoffice
	    htop
	    bottom
	    eza
	    trash-cli
	    gnome-disk-utility
	    gnome-multi-writer
	    retroarch-full
	    onlyoffice-desktopeditors
	    luanti
	    wl-clipboard
	    wayland-utils
	    unzip


	    ];

    # for bash scripts 
    services.envfs.enable = true;

    # version
    system.stateVersion = "23.05"; # Did you read the comment?

}

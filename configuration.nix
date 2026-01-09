
{ config, pkgs, ... }:

{
    imports =
	[ 
	# include
	./hardware-configuration.nix
	./borg_emily.nix
	./borg_emily_nas.nix
	./wine.nix
	];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # host
    networking.hostName = "emily-laptop"; 

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
    users.users.emily = {
	isNormalUser = true;
	description = "emily";
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
	fzf
	trash-cli
	gnome-disk-utility
	gnome-multi-writer
	onlyoffice-desktopeditors
	wl-clipboard
	wayland-utils
	wget
	curl
	unzip
	ncdu
	smartmontools
	zoom-us
	vlc

    ];

    # for bash scripts 
    services.envfs.enable = true;

    # home directories
    systemd.tmpfiles.rules = [
	"d /home/emily/Desktop 755 emily users -"
	"d /home/emily/Downloads 755 emily users -"
	"d /home/emily/Documents 755 emily users -"
	"d /home/emily/bin 755 emily users -"
    ];


    # version
    system.stateVersion = "24.05"; # Did you read the comment?

}

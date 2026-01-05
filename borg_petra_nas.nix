{ config, pkgs, ... }:
{

    # borg petra
    #----------------------------------------

    systemd.timers."borg_petra_nas" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar= "*-*-* 04:00:00";
	    Persistent = "true";
	    Unit = "borg_petra_nas.service";
	};
    };

    systemd.services."borg_petra_nas" = {
	serviceConfig = {
	    Type = "simple";
	    User = "petra";
	    WorkingDirectory = "/home/petra/bin";
	};
	path = with pkgs; [ 
	    bash
	    borgbackup
	];
	script = ''
	    bash /home/petra/bin/backup_nas.sh
	    '';
    };

}

{ config, pkgs, ... }:
{

    # borg petra
    #----------------------------------------

    systemd.timers."borg_petra" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar = "*-*-*  *:19:00";
	    Persistent = "true";
	    Unit = "borg_petra.service";
	};
    };

    systemd.services."borg_petra" = {
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
	    bash /home/petra/bin/backup.sh
	    '';
    };

}

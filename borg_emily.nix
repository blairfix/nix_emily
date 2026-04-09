{ config, pkgs, ... }:
{

    # borg emily
    #----------------------------------------

    systemd.timers."borg_emily" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar= "*-*-* 03:00:00";
	    Persistent = "true";
	    Unit = "borg_emily.service";
	};
    };

    systemd.services."borg_emily" = {
	serviceConfig = {
	    Type = "simple";
	    User = "emily";
	    WorkingDirectory = "/home/emily/bin";
	};
	path = with pkgs; [ 
	    bash
	    borgbackup
	];
	script = ''
	    bash /home/emily/bin/backup.sh
	    '';
    };

}

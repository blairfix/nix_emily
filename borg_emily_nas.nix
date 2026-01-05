{ config, pkgs, ... }:
{

    # borg emily
    #----------------------------------------

    systemd.timers."borg_emily_nas" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar= "*-*-* 04:00:00";
	    Persistent = "true";
	    Unit = "borg_emily_nas.service";
	};
    };

    systemd.services."borg_emily_nas" = {
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
	    bash /home/emily/bin/backup_nas.sh
	    '';
    };

}

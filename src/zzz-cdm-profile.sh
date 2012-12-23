if [[ -z "$DISPLAY" && -z "$SSH_TTY" && $(runlevel|cut  -d" " -f 2) == 4 && $(tty) = /dev/tty* ]]; then
	# Drop root to console
	if ! [[ $EUID -eq 0 ]]; then
		/usr/bin/cdm
		if (( $? == 0 )); then
			exit 0
		fi
	fi
fi

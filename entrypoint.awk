#!/usr/bin/awk -f

BEGIN {
	default_dest = ENVIRON["DEFAULT_DEST"]
	printf("Connected to SSH Gateway. ")
	promptdest()
}

{ promptdest() }

/^q(uit)?$/ { exit }

!NF && default_dest { ssh(default_dest) }

/^[A-Za-z0-9_.-]+@[A-Za-z0-9_.-]+$/ { ssh($0) }

function ssh(dest) {
	cmd = "dbclient -o StrictHostKeyChecking=accept-new "

	key = "/home/gateway/.ssh/id_dropbear"

	if ((getline < key) >= 0) {
		close(key)
		cmd = cmd "-i " key " "
	}


	system(cmd dest)
	exit
}

function promptdest() {
	print ("Enter USER@HOST" (default_dest? " [" default_dest "]:" : ":"))
}

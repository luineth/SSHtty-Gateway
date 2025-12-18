#!/usr/bin/awk -f

BEGIN {
	default_dest = ENVIRON["DEFAULT_DEST"]
	printf("Connected to SSH Gateway. ")
	getdest()
}

{ getdest() }

/^q(uit)?$/ { exit }

!NF && default_dest { ssh(default_dest) }

/.+@.+/ { ssh($0) }

function ssh(dest) {
	system("dbclient -i /root/.ssh/id_rsa -o StrictHostKeyChecking=accept-new " dest)
	exit
}

function getdest() {
	print ("Enter USER@HOST" (default_dest? " [" default_dest "]:" : ":"))
}

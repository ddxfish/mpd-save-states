#!/bin/bash
# MPD Save States
#This gives something like save slots to MPD player
#Save your current playlist, position and state to a slot
#Recover that exact state, playlist and postition later
#Allows for multiple playlists to switch back and forth to

statedir="/var/lib/mpd"
statefile="$statedir/state"
totalstates=3


if [ ! -f "$statedir/mss-current" ]
then
	echo "Welcome to MPD Save States! Settings things up."
	cd $statedir
	#copy current state so we have a template
	for i in `seq 1 1 $totalstates`; do
		cp state $i
       	done
	touch "$statedir/mss-current"
	echo 1 > "$statedir/mss-current"
fi

currentstate=`cat $statedir/mss-current`

if [[ $# -ne 0 ]] && ( [[ $1 == "save" ]] || [[ $1 == "load" ]] )
then	
	if [[ $1 == "load" ]] && [[ $2 -ge 1 ]] && [[ $2 -le $totalstates ]]
	then
		#will save current state before load if third param is y
		if [[ $# -gt 2 ]]; then
			if [[ $3 == "y" ]]
			then
				cp -f state $currentstate;
				echo "saved $currentstate";
			fi	
		fi
		systemctl stop mpd
		sleep 5
		cd $statedir
		echo "I am now activating state $2"
		cp -f $2 state
		echo $2 > "$statedir/mss-current"
		sleep 1
		systemctl start mpd
	fi
	if [[ $1 == "save" ]] && [[ $2 -ge 1 ]] && [[ $2 -le $totalstates ]]
	then
		newcurrentstate=$2
		cp -f state $newcurrentstate
		echo "Saved State $newcurrentstate"
		cd $statedir
		echo "activating $newcurrentstate"
		echo $newcurrentstate > mss-current
	fi
else
	echo "Usage: ./mpdss.sh (save|load) <slot>"
	echo "You are currently on slot: $currentstate"
fi

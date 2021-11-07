# MPD Save States
Use multiple playlists with MPD (Music Player Daemon) and switch back and forth with ease. Saves one MPD playlist and position, load another, then switch back to continue listening.

## Install
You can drop the sh script anywhere or put it in your path. You can edit the location of the MPD state file if needed in the script. You can also edit how many playlists are built, the default is 3.

# Usage:
Save current playlist in slot 1
./mpdss.sh save 1

Load playlist in slot 3
./mpdss.sh load 3

# Troubleshooting
cd /var/lib/mpd
rm 1 2 3 mss-current
./mpdss.sh

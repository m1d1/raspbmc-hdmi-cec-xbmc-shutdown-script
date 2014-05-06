#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/opt/vc/bin:/home/pi/.xbmc-current/xbmc-bin/bin
sleep 30
cec-client -r | /usr/local/bin/cec_listener.pl



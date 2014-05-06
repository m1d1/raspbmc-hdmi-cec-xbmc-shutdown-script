rasbmc-hdmi-cec-xbmc-shutdown-script
====================================

RASPBMC

If you turn off your TV via hdmi cec the scripts shutsdown xbmc
and turns it on again if you power up your TV.


Note: 
This has only been tested with my Panasonic TV
I've no idea if this works with other hardware.


Here is how you set it up:


1.)  copy files as root (with sudo) 
     cec_listener.pl, cec_listener.sh and new_listener.sh to
     /usr/local/bin
    
2.)  make sure these files have the executable flag
     sudo chmod +x /usr/local/bin/cec_listener.* /usr/local/bin/new_listener.sh
     
3.) add cec_listener.sh to your root's crontab. 
    (for some strange reason rc.local didn't work)
    
    sudo crontab -e
    
    add this line save and reboot (or just start cec_listener.sh)
    @reboot /usr/local/bin/cec_listener.sh
    

leave some feedback.

m1d1

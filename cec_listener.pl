#!/usr/bin/perl

# hdmi-cec listener perl script for stdin
# 
# purpose: 
#	listen to hdmi-cec power-off / power-on button
#	and turn off /on xbmc service to idle raspi.
#
# author:
#	April 2014, Michael Dinkelaker 
#           michael.dinkelaker<at>gmail<dot>com
#
# history:
#	2014-04-25: creation
#	2014-05-03: change to restarting script when xbmc starts

use 5.010;
use strict;
use warnings;

my $XBMC_STATE		= `pgrep xbmc -c`;
my $POWER_ON_STR 	= "40:04";
my $POWER_OFF_STR	= "0f:36";
my $LOG			= "/home/pi/cec_listener.log";
my $res;


# ------------------------------------------------------------------------------
sub logg {
	#  write to log
	my ($log_str) = @_;
	open my $fh, '>>', $LOG  or die "Can't create logfile\n";
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
	my $nice_timestamp = sprintf ( "%04d%02d%02d %02d:%02d:%02d", $year+1900,$mon+1,$mday,$hour,$min,$sec);
    	my $logdata = $nice_timestamp."\t".$log_str."\n";
	print $fh $logdata;
	close $fh;
}
sub get_search_str {
	return ($XBMC_STATE) ? $POWER_OFF_STR : $POWER_ON_STR;
}

sub turn_xbmc_off {
	logg("stopping xbmc ... ");
	$res = `stop xbmc`;
}

sub turn_xbmc_on {
	logg("starting xbmc ...");
	$res = `start xbmc & /usr/local/bin/new_listener.sh`;
	exit 0;
}

sub service_event {
	if ($XBMC_STATE) {
		turn_xbmc_off();
	} else {
		turn_xbmc_on();
	}
	$XBMC_STATE = ($XBMC_STATE) ? 0 : 1;
	return get_search_str();
}

# ------------------------------------------------------------------------------
my $statestr = ($XBMC_STATE) ? "running" : "not running";
logg("# -----  cec listener started. xbmc is ".$statestr);
my $search_str = get_search_str();
while (<>) {

	if (index($_, $search_str) != -1) {
	    $search_str = service_event();
	} 
}
logg("exiting cec_listener.pl  ------#");

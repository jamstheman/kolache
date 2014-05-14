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
  }
}
  
firstrun;  


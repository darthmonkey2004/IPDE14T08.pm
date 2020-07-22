# IPDE14T08.pm
ZoneMinder PTZ Control Protocol Perl5 driver script for the Chineese unbranded dome ptz IP camera, model number IPD-E14T08.
Put this file in /usr/share/perl5/ZoneMinder/Control directory.
Then in the ZoneMinder web interface, in camera properties, under the control tab, hit the edit button. 
You'll have to create a new entry for it.
You'll want to set this file name as the control protocol (without the .pm), and the method as 'cURL'.
You'll also want to enable pan(continuous, speed 1-8), tilt(continous, speed 1-8), zoom(continous, speed 1-8), and iris(continous, speed 1-8). I haven't had the time to add much more than that, the basic ptz functionality... but will update when I do.

# ==========================================================================
#
# ZoneMinder Maginon Supra IPC Camera Control Protocol Module,
# Copyright (C) 2017  Martin Gutenbrunner (martin.gutenbrunner@SPAMsonic.net)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# ==========================================================================
#
# This module contains the implementation of the Maginon Supra IPC camera
# procotol version.
#
package ZoneMinder::Control::IPDE14T08;

use 5.006;
use strict;
use warnings;

require ZoneMinder::Base;
require ZoneMinder::Control;

our @ISA = qw(ZoneMinder::Control);

our $REALM = '';
our $USERNAME = '';
our $PASSWORD = '';
our $ADDRESS = '';
our $PROTOCOL = 'http://';

use Time::HiRes qw(usleep);

use ZoneMinder::Logger qw(:all);
use ZoneMinder::Config qw(:all);

sub open
{
	my $self = shift;

	$self->loadMonitor();

	use LWP::UserAgent;
	$self->{ua} = LWP::UserAgent->new(keep_alive => 1);
	$self->{ua}->agent("ZoneMinder Control Agent/".ZoneMinder::Base::ZM_VERSION);
	$self->{state} = 'open';
}

sub printMsg
{
	my $self = shift;
	my $msg = shift;
	my $msg_len = length($msg);

	Debug( $msg."[".$msg_len."]" );
}

sub sendCmd {
	my $self = shift;
	my $cmd = shift;
	printMsg( $cmd, "Tx" );
	my $url = "http://".$self->{Monitor}->{ControlAddress}."$cmd";
	my $req = HTTP::Request->new( GET=>$url );
	my $res = $self->{ua}->request($req);
	return( !undef );
}

sub moveStop
{
	Debug("moveStop");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=0";
	$self->sendCmd( $cmd );
}

sub moveConLeft
{
	Debug("moveConLeft");
	my $self = shift;
	my $params = shift;
	my $cmd = "/decoder_control.cgi?command=3";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConRight
{
	Debug("moveConRight");
	my $self = shift;
	my $params = shift;
	my $cmd = "/decoder_control.cgi?command=4";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConUp
{
	Debug("moveConUp");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=1";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConDown
{
	Debug("moveConDown");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=5";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConUpRight
{
	Debug("moveConUpRight");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=7";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConDownRight
{
	Debug("moveConDownRight");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=8";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConUpLeft
{
	Debug("moveConUpLeft");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=6";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub moveConDownLeft
{
	Debug("moveConDownLeft");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=5";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub zoomConTele
{
	Debug("zoomConTele");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=13";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub zoomConWide
{
	Debug("zoomConWide");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=14";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}
sub irisConOpen
{
	Debug("irisConOpen");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=9";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub irisConClose
{
	Debug("irisConClose");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=10";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub focusConNear
{
	Debug("focusConNear");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=11";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub focusConFar
{
	Debug("focusConFar");
	my $self = shift;
	my $params = shift;
	my $cmd = "/form/setPTZCfg?command=12";
	$self->sendCmd( $cmd );
	my $autostop = $self->getParam( $params, 'autostop', 0 );
	if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
	{
		usleep( $self->{Monitor}->{AutoStopTimeout} );
		$self->moveStop( $params );
	}
}

sub reboot
{
	Debug( "Camera Reboot" );
	my $self = shift;
	my $cmd = "/form/reboot?";
	$self->sendCmd( $cmd );
}

1;
__END__

# Below is stub documentation for an unbranded Chineese cheapo ip camera. Enjoy!

=head1 NAME

ZoneMinder::Control::IPDE14T08 - Zoneminder PTZ control module for the Unbranded Chineese dome ptz IP Cameras, model IPD-E14T08

=head1 SYNOPSIS

  use ZoneMinder::Control::IPDE14T08;

=head1 DESCRIPTION

	Zoneminder PTZ control module for the Unbranded Chineese dome ptz IP Cameras, model IPD-E14T08

=head2 EXPORT

None by default.



=head1 SEE ALSO

www.zoneminder.com

=head1 AUTHOR

Matt McClellan, E<lt>darthmonkey2004@gmail.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright info is that of ZoneMinder, and quite honestly has been modified from several of many control scripts found in the /usr/share/perl5/ZoneMinder/Control directory.
Change to your heart's content.
:-)


=cut

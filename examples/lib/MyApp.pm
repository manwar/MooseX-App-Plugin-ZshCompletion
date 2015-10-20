use strict;
use warnings;
use 5.010;

package MyApp;

use MooseX::App qw/ Color BashCompletion ZshCompletion /;

option 'verbose' => (
    is            => 'rw',
    isa           => 'Bool',
    documentation => q[be verbose],
); # Global option

has 'private' => ( 
    is              => 'rw',
); # not exposed

package MyApp::FetchMail;
use MooseX::App::Command; # important (also imports Moose)
extends qw(MyApp); # optional, only if you want to use global options from base class

# Positional parameter
parameter 'server' => (
    is            => 'rw',
    isa           => 'Str',
    required      => 1,
    documentation => q[Mailserver],
);

parameter 'type' => (
    is            => 'rw',
    isa           => 'Str',
    required      => 0,
    documentation => q[IMAP or POP3],
);

option 'max' => (
    is            => 'rw',
    isa           => 'Int',
    required      => 1,
    documentation => q[Maximum number of emails to fetch],
); # Option

option 'dir' => (
    is            => 'rw',
    isa           => 'Str',
    required      => 0,
    documentation => q[Output 'dir'],
); # Option

option 'user' => (
    is            => 'rw',
    isa           => 'Str',
    required      => 1,
    documentation => q[User],
); # Option

sub run {
    my ($self) = @_;
    # Do something
    my $server = $self->server;
    my $max = $self->max;
    if ($self->verbose) {
        say "Connecting to $server...";
        say "Fetching up to $max emails...";
    }
    my $count = int rand 150;
    $count = $max if $count >= $max;
    say "Fetched $count emails";
}

1;

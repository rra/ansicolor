# Term::ANSIColor -- Color screen output using ANSI escape sequences.
#
# Copyright 1996 by Russ Allbery <rra@cs.stanford.edu>
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

############################################################################
# Modules and declarations
############################################################################

package Term::ANSIColor;
require 5.001;

use strict;
use vars qw(@ISA @EXPORT $ID $VERSION %attributes);

require Exporter;
@ISA     = qw(Exporter);
@EXPORT  = qw(color colored);

$ID      = '$Id$';
$VERSION = (split (' ', $ID))[2];


############################################################################
# Internal data structures
############################################################################

%attributes = ('reset'      => 0,
	       'clear'      => 0,
	       'bold'       => 1,
	       'underscore' => 4,
	       'blink'      => 5,
	       'reverse'    => 7,
	       'concealed'  => 8,

	       'fg_black'   => 30,
	       'black'      => 30,
	       'fg_red'     => 31,
	       'red'        => 31,
	       'fg_green'   => 32,
	       'green'      => 32,
	       'fg_yellow'  => 33,
	       'yellow'     => 33,
	       'fg_blue'    => 34,
	       'blue'       => 34,
	       'fg_magenta' => 35,
	       'magenta'    => 35,
	       'fg_cyan'    => 36,
	       'cyan'       => 36,
	       'fg_white'   => 37,
	       'white'      => 37,

	       'bg_black'   => 40,
	       'bg_red'     => 41,
	       'bg_green'   => 42,
	       'bg_yellow'  => 43,
	       'bg_blue'    => 44,
	       'bg_magenta' => 45,
	       'bg_cyan'    => 46,
	       'bg_white'   => 47);


############################################################################
# Implementation
############################################################################

# Return the escape code for a given set of color attributes.
sub color {
    my $attribute = '';
    foreach (@_) {
	unless (defined $attributes{$_}) { die "invalid attribute name $_" }
	$attribute .= $attributes{$_} . ';';
    }
    chop $attribute;
    if (defined $attribute) {
	"\e[${attribute}m";
    } else {
	undef;
    }
}

# Given a string and a set of attributes, returns the string surrounded by
# escape codes to set those attributes and then clear them at the end of the
# string.
sub colored {
    my $string = shift;
    return color (@_) . $string . color ('reset');
}


############################################################################
# Module return value
############################################################################

# Ensure we evaluate to true.
1;

# Term::ANSIColor -- Color screen output using ANSI escape sequences.
#
# Copyright 1996 by Russ Allbery <rra@cs.stanford.edu>
#               and Zenin <zenin@best.com>
#
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

############################################################################
# Modules and declarations
############################################################################

package Term::ANSIColor;
require 5.001;

use strict;
use vars qw(@ISA @EXPORT %EXPORT_TAGS $ID $VERSION %attributes);

require Exporter;
@ISA         = qw(Exporter);
@EXPORT      = qw(color colored);
%EXPORT_TAGS = (constants => [qw(RESET CLEAR BOLD UNDERSCORE BLINK REVERSE
				 CONCEALED BLACK RED GREEN YELLOW BLUE
				 MAGENTA CYAN WHITE ON_BLACK ON_RED ON_GREEN
				 ON_YELLOW ON_BLUE ON_MAGENTA ON_CYAN
				 ON_WHITE)]);
Exporter::export_ok_tags('constants');
    
$ID      = '$Id$';
$VERSION = (split (' ', $ID))[2];


############################################################################
# Internal data structures
############################################################################

%attributes = ('reset'      => 0,
	       'clear'      => 0,
	       'bold'       => 1,
               'underline'  => 4,
	       'underscore' => 4,
	       'blink'      => 5,
	       'reverse'    => 7,
	       'concealed'  => 8,

	       'black'      => 30,   'on_black'   => 40, 
	       'red'        => 31,   'on_red'     => 41, 
	       'green'      => 32,   'on_green'   => 42, 
	       'yellow'     => 33,   'on_yellow'  => 43, 
	       'blue'       => 34,   'on_blue'    => 44, 
	       'magenta'    => 35,   'on_magenta' => 45, 
	       'cyan'       => 36,   'on_cyan'    => 46, 
	       'white'      => 37,   'on_white'   => 47);


############################################################################
# Implementation (constant form)
############################################################################

sub RESET      { "\e[00m", @_ }
sub CLEAR      { "\e[00m", @_ }
sub BOLD       { "\e[01m", @_ }
sub UNDERLINE  { "\e[04m", @_ }
sub UNDERSCORE { "\e[04m", @_ }
sub BLINK      { "\e[05m", @_ }
sub REVERSE    { "\e[07m", @_ }
sub CONCEALED  { "\e[08m", @_ }

sub BLACK      { "\e[30m", @_ }
sub RED        { "\e[31m", @_ }
sub GREEN      { "\e[32m", @_ }
sub YELLOW     { "\e[33m", @_ }
sub BLUE       { "\e[34m", @_ }
sub MAGENTA    { "\e[35m", @_ }
sub CYAN       { "\e[36m", @_ }
sub WHITE      { "\e[37m", @_ }

sub ON_BLACK   { "\e[40m", @_ }
sub ON_RED     { "\e[41m", @_ }
sub ON_GREEN   { "\e[42m", @_ }
sub ON_YELLOW  { "\e[43m", @_ }
sub ON_BLUE    { "\e[44m", @_ }
sub ON_MAGENTA { "\e[45m", @_ }
sub ON_CYAN    { "\e[46m", @_ }
sub ON_WHITE   { "\e[47m", @_ }


############################################################################
# Implementation (attribute string form)
############################################################################

# Return the escape code for a given set of color attributes.
sub color {
    my @codes = map { split } @_;
    my $attribute = '';
    foreach (@codes) {
	unless (defined $attributes{$_}) { die "invalid attribute name $_" }
	$attribute .= $attributes{$_} . ';';
    }
    chop $attribute;
    return ($attribute ne '') ? "\e[${attribute}m" : undef;
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

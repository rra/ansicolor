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

sub BLACK      { "\e[30m", @_ }        sub ON_BLACK   { "\e[40m", @_ }
sub RED        { "\e[31m", @_ }	       sub ON_RED     { "\e[41m", @_ }
sub GREEN      { "\e[32m", @_ }	       sub ON_GREEN   { "\e[42m", @_ }
sub YELLOW     { "\e[33m", @_ }	       sub ON_YELLOW  { "\e[43m", @_ }
sub BLUE       { "\e[34m", @_ }	       sub ON_BLUE    { "\e[44m", @_ }
sub MAGENTA    { "\e[35m", @_ }	       sub ON_MAGENTA { "\e[45m", @_ }
sub CYAN       { "\e[36m", @_ }	       sub ON_CYAN    { "\e[46m", @_ }
sub WHITE      { "\e[37m", @_ }	       sub ON_WHITE   { "\e[47m", @_ }


############################################################################
# Implementation (attribute string form)
############################################################################

# Return the escape code for a given set of color attributes.
sub color {
    my @codes = map { split } @_;
    my $attribute = '';
    foreach (@codes) {
	$_ = lc $_;
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
__END__

=head1 NAME

Term::ANSIColor - Color screen output using ANSI escape sequences

=head1 SYNOPSIS

    use Term::ANSIColor;
    print color 'bold blue';
    print "This text is bold blue.\n";
    print color 'reset';
    print "This text is normal.\n";
    print colored ("Yellow on magenta.\n", 'yellow on_magenta');
    print "This text is normal.\n";

    use Term::ANSIColor qw(:constants);
    print BOLD BLUE "This text is in bold blue.\n";
    print RESET;

=head1 DESCRIPTION

C<Term::ANSIColor::color> takes any number of strings as arguments and
considers them to be space-separated lists of attributes.  It then forms
and returns the escape sequence to set those attributes.  It doesn't print
it out, just returns it, so you'll have to print it yourself if you want
to (this is so that you can save it as a string, pass it to something
else, send it to a file handle, or do anything else with it that you might
care to).

The recognized attributes (all of which should be fairly intuitive) are
reset, clear, bold, underline, underscore, blink, reverse, concealed,
black, red, green, yellow, blue, magenta, on_black, on_red, on_green,
on_yellow, on_blue, on_magenta, on_cyan, and on_white.  Case is not
significant.  Reset and clear are equivalent, as are underline and
underscore, so use whichever is the most intuitive to you.  The color
alone sets the foreground color, and on_color sets the background color.

Note that attributes, once set, last until they are unset (by sending the
attribute "reset" or "clear").  Be careful to do this, or otherwise your
attribute will last after your script is done running, and people get very
annoyed at having their prompt and typing changed to weird colors.

As an aid to help with this, C<Term::ANSIColor::colored> takes a scalar as
the first argument and any number of attribute strings as the second
argument and returns the scalar wrapped in escape codes so that the
attributes will be set as requested before the string and reset to normal
after the string.

Alternately, if you import C<:constants>, you can use the constants RESET,
CLEAR, BOLD, UNDERLINE, UNDERSCORE, BLINK, REVERSE, CONCEALED, BLACK, RED,
GREEN, YELLOW, BLUE, MAGENTA, ON_BLACK, ON_RED, ON_GREEN, ON_YELLOW,
ON_BLUE, ON_MAGENTA, ON_CYAN, and ON_WHITE directly.  These are the same
as C<Term::ANSIColor::color ('attribute')> and are included solely for
convenience if you prefer typing:

    print BOLD BLUE ON_WHITE "Text\n", RESET;

to

    print colored ("Text\n", 'bold blue on_white');

Your choice.  TIMTOWTDI.

=head1 DIAGNOSTICS

=over 4

=item invalid attribute name %s

You passed an invalid attribute name to either C<Term::ANSIColor::color>
or C<Term::ANSIColor::colored>.

=back

=head1 RESTRICTIONS

It would be nice if one could leave off the commas around the constants
entirely and just say:

    print BOLD BLUE ON_WHITE "Text\n" RESET;

but the syntax of Perl doesn't allow this.  You need a comma after the
string.  (Of course, you may consider it a bug that commas between all the
constants aren't required, in which case you may feel free to insert
commas.)

=head1 AUTHORS

Original idea (using constants) by Zenin (zenin@best.com), reimplemented
using subs by Russ Allbery (rra@cs.stanford.edu), and then combined with
the original idea by Russ with input from Zenin.

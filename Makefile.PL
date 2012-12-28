# Makefile.PL for Term::ANSIColor.
#
# Copyright 1997, 1998, 2000, 2009, 2011, 2012 Russ Allbery <rra@stanford.edu>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile (
    NAME          => 'Term::ANSIColor',
    DISTNAME      => 'Term-ANSIColor',
    ($] >= 5.006 ?
     (INSTALLDIRS => 'perl') : ()),
    ($] >= 5.005 ?
     (ABSTRACT    => 'Color output using ANSI escape sequences',
      AUTHOR      => 'Russ Allbery (rra@stanford.edu)') : ()),
    ($] >= 5.010 ?
     (LICENSE     => 'perl') : ()),
    VERSION_FROM  => 'ANSIColor.pm',
    dist          => { COMPRESS => 'gzip', SUFFIX => 'gz' }
);

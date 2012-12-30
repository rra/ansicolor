# Makefile.PL for Term::ANSIColor.
#
# Copyright 1997, 1998, 2000, 2009, 2011, 2012 Russ Allbery <rra@stanford.edu>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use 5.006;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Term::ANSIColor',
    DISTNAME     => 'Term-ANSIColor',
    INSTALLDIRS  => 'perl',
    ABSTRACT     => 'Color output using ANSI escape sequences',
    AUTHOR       => 'Russ Allbery <rra@stanford.edu>',
    VERSION_FROM => 'ANSIColor.pm',
    clean        => { FILES => 'cover_db' },
    dist         => { COMPRESS => 'gzip', SUFFIX => 'gz' },

    # ExtUtils::MakeMaker only understands this with Perl 5.10 or later.
    ## no critic (ValuesAndExpressions::ProhibitMagicNumbers)
    ($] >= 5.010 ? (LICENSE => 'perl') : ()),
);

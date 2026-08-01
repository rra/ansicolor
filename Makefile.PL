# Build instructions for Term::ANSIColor.
#
# We prefer to use ExtUtils::MakeMaker since this module is part of Perl core,
# which only supports that build method.  While Module::Build can generate a
# backards-compatible Makefile.PL, this way normal releases test the same
# build system that is used for Perl core.
#
# Copyright 1999-2001, 2008, 2010, 2012, 2014-2016, 2020, 2026
#     Russ Allbery <rra@cpan.org>
#
# SPDX-License-Identifier: GPL-1.0-or-later OR Artistic-1.0-Perl

use 5.012;
use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;
use File::Spec;

my $BUGS = 'https://rt.cpan.org/Dist/Display.html?Name=Term-ANSIColor';

# The hash of all the metadata.  This will be modified before WriteMakefile to
# remove keys not supported by the local version of ExtUtils::MakeMaker.
my %metadata = (
    NAME             => 'Term::ANSIColor',
    ABSTRACT         => 'Color output using ANSI escape sequences',
    AUTHOR           => 'Russ Allbery <rra@cpan.org>',
    LICENSE          => 'perl_5',
    VERSION_FROM     => 'lib/Term/ANSIColor.pm',
    MIN_PERL_VERSION => '5.012',
    realclean        => { FILES => 'MANIFEST.bak cover_db' },

    # Older versions of ExtUtils::MakeMaker don't pick up nested test
    # directories by default.
    test => { TESTS => 't/*/*.t' },

    # Additional metadata.
    META_ADD => {
        'meta-spec' => { version => 2 },
        resources   => {
            bugtracker => {
                mailto => 'bug-Term-ANSIColor@rt.cpan.org',
                web    => $BUGS,
            },
            homepage   => 'https://www.eyrie.org/~eagle/software/ansicolor/',
            repository => {
                url  => 'git://github.com/rra/ansicolor.git',
                web  => 'https://github.com/rra/ansicolor',
                type => 'git',
            },
        },
    },
);

# Generate the actual Makefile.
WriteMakefile(%metadata);

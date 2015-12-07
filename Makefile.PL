# Build instructions for Term::ANSIColor.
#
# We prefer to use ExtUtils::MakeMaker since this module is part of Perl core,
# which only supports that build method.  While Module::Build can generate a
# backards-compatible Makefile.PL, this way normal releases test the same
# build system that is used for Perl core.
#
# Copyright 1999, 2000, 2001, 2008, 2010, 2012, 2014, 2015
#     Russ Allbery <rra@cpan.org>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use 5.006;
use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;
use File::Spec;

my $BUGS = 'https://rt.cpan.org/Public/Dist/Display.html?Name=Term::ANSIColor';

# Generate the actual Makefile.  Pick an arbitrary module to pull the version
# from, since they should all have the same version.
WriteMakefile(
    NAME         => 'Term::ANSIColor',
    ABSTRACT     => 'Color output using ANSI escape sequences',
    AUTHOR       => 'Russ Allbery <rra@cpan.org>',
    VERSION_FROM => 'lib/Term/ANSIColor.pm',

    # ExtUtils::MakeMaker doesn't pick up nested test directories by default.
    test => { TESTS => 't/*/*.t' },

    # For older versions of Perl, we have to force installation into the Perl
    # module directories since site modules did not take precedence over core
    # modules.
    INSTALLDIRS => $] lt '5.011' ? 'perl' : 'site',

    # For ExtUtils::MakeMaker 6.31 and later, we can specify the license.
    ($ExtUtils::MakeMaker::VERSION >= 6.31 ? (
        LICENSE => 'perl',
    ) : ()),

    # For ExtUtils::MakeMaker 6.46 or later, we can provide some additional
    # metadata.
    ($ExtUtils::MakeMaker::VERSION >= 6.46 ? (
        META_ADD => {
            resources => {
                repository => 'git://git.eyrie.org/perl/ansicolor.git',
                bugtracker => $BUGS,
            },
        },
    ) : ()),

    # For ExtUtils::MakeMaker 6.48 and later, we can specify the minimum Perl
    # version required.
    ($ExtUtils::MakeMaker::VERSION >= 6.48 ? (
        MIN_PERL_VERSION => '5.006',
    ) : ()),
);

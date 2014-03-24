#!/usr/bin/perl
#
# Build script for the Term::ANSIColor distribution.
#
# Copyright 1997, 1998, 2000, 2009, 2011, 2012, 2013, 2014
#     Russ Allbery <rra@cpan.org>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use 5.006;
use strict;
use warnings;

use Module::Build;

# Basic package configuration.
my $build = Module::Build->new(
    module_name          => 'Term::ANSIColor',
    dist_abstract        => 'Color output using ANSI escape sequences',
    dist_author          => 'Russ Allbery <rra@cpan.org>',
    dist_version_from    => 'lib/Term/ANSIColor.pm',
    license              => 'perl',
    recursive_test_files => 1,
    create_makefile_pl   => 'traditional',

    # Add additional package metadata.
    meta_merge => {
        resources => {
            repository => 'git://git.eyrie.org/perl/ansicolor.git',
            bugtracker =>
'https://rt.cpan.org/Public/Dist/Display.html?Name=Term-ANSIColor',
        },
    },

    # Other package relationships.
    configure_requires => { 'Module::Build' => 0.28 },
    requires           => { perl            => '5.006' },
);

# Generate the build script.
$build->create_build_script;

# Makefile.PL for Term::ANSIColor module  -*- perl -*-
# $Id$
use ExtUtils::MakeMaker;
WriteMakefile (NAME         => 'Term::ANSIColor',
               DISTNAME     => 'ANSIColor',
               VERSION_FROM => 'ANSIColor.pm',
               dist         => { COMPRESS => 'gzip', SUFFIX => 'gz' });

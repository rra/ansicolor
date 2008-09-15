# Makefile.PL for Term::ANSIColor.

use ExtUtils::MakeMaker;

WriteMakefile (
    NAME         => 'Term::ANSIColor',
    DISTNAME     => 'ANSIColor',
    ($] >= 5.006 ?
     (INSTALLDIRS => 'perl') : ()),
    ($] >= 5.005 ?
     (ABSTRACT   => 'Color output using ANSI escape sequences',
      AUTHOR     => 'Russ Allbery (rra@stanford.edu)') : ()),
    VERSION_FROM => 'ANSIColor.pm',
    dist         => { COMPRESS => 'gzip', SUFFIX => 'gz' }
);

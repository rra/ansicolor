# Term::ANSIColor

[![Build
status](https://github.com/rra/ansicolor/workflows/build/badge.svg)](https://github.com/rra/ansicolor/actions)
[![CPAN
version](https://img.shields.io/cpan/v/Term-ANSIColor)](https://metacpan.org/release/Term-ANSIColor)
[![License](https://img.shields.io/cpan/l/Term-ANSIColor)](https://github.com/rra/ansicolor/blob/master/LICENSE)

Copyright 1996-1998, 2000-2002, 2005-2006, 2008-2020, 2024 Russ Allbery
<rra@cpan.org>.  Copyright 1996 Zenin.  Copyright 2012 Kurt Starsinic
<kstarsinic@gmail.com>.  This software is distributed under the same terms
as Perl itself.  Please see the section [License](#license) below for more
information.

## Blurb

Term::ANSIColor provides constants and simple functions for setting ANSI
text attributes, most notably colors.  It can be used to set the current
text attributes or to apply a set of attributes to a string and reset the
current text attributes at the end of that string.  Eight-color,
sixteen-color, 256-color, and truecolor (24-bit color) escape sequences
are all supported.

## Description

This Perl module is a simple and convenient interface to the ANSI X3.64
(ECMA-48, ISO 6429) terminal escape sequences for color and other
formatting attributes such as bold or underline.  The sequences are
provided in two forms, either as constants for each attribute or via a
function that takes the names of attributes and returns the appropriate
escape codes or wraps them around the provided text.  Also supported are
the extended colors used for sixteen-color, 256-color, and truecolor
emulators.

This module is very stable, and I've used it in a wide variety of
applications.  Perl 5.6.0 and later include it in the core distribution,
so you don't need to download and install it yourself unless you need a
newer version than comes with your version of Perl.  I continue to
maintain it as a separate module, and the version included in Perl is
resynced with mine before each release.

The original module came out of a discussion in comp.lang.perl.misc and is
a combination of two approaches, one with constants by Zenin and one with
functions that I wrote.  I offered to maintain a combined module that
included both approaches.

## Requirements

This module requires Perl 5.12 or later.  It has no other dependencies.

In order to see color, you will need to use a terminal window that
supports the ANSI escape sequences for color.  Any recent version of
xterm, most xterm derivatives and replacements, and most telnet and SSH
clients for Windows and Macintosh should work, as will the MacOS X
Terminal application (although Terminal.app reportedly doesn't support 256
colors).  The console windows for Windows NT and Windows 2000 will not
work, as they do not even attempt to support ANSI X3.64, but I have heard
newer versions of Windows have improved support.

For a terminal emulator compatibility list, see the Term::ANSIColor module
documentation.  If you have any additions to the table in the
documentation, please send them to me.

## Building and Installation

Term::ANSIColor uses ExtUtils::MakeMaker and can be installed using the
same process as any other ExtUtils::MakeMaker module:

```
    perl Makefile.PL
    make
    make install
```

You'll probably need to do the last as root unless you're installing into
a local Perl module tree in your home directory.

## Testing

Term::ANSIColor comes with a test suite, which you can run after building
with:

```
    make test
```

If a test vails, you can run a single test with verbose output via:

```
    prove -vb <path-to-test>
```

The following additional Perl modules will be used by the test suite if
present:

* Devel::Cover
* Test::MinimumVersion
* Test::Perl::Critic
* Test::Pod
* Test::Pod::Coverage
* Test::Spelling
* Test::Strict
* Test::Synopsis
* Test::Warn

All are available on CPAN.  Those tests will be skipped if the modules are
not available.

To enable tests that don't detect functionality problems but are used to
sanity-check the release, set the environment variable `RELEASE_TESTING`
to a true value.  To enable tests that may be sensitive to the local
environment or that produce a lot of false positives without uncovering
many problems, set the environment variable `AUTHOR_TESTING` to a true
value.

## Support

The [Term::ANSIColor web
page](https://www.eyrie.org/~eagle/software/ansicolor/) will always have
the current version of this package, the current documentation, and
pointers to any additional resources.

For bug tracking, use the [issue tracker on
GitHub](https://github.com/rra/ansicolor/issues).  However, please be
aware that I tend to be extremely busy and work projects often take
priority.  I'll save your report and get to it as soon as I can, but it
may take me a couple of months.

## Source Repository

Term::ANSIColor is maintained using Git.  You can access the current
source on [GitHub](https://github.com/rra/ansicolor) or by cloning the
repository at:

https://git.eyrie.org/git/perl/ansicolor.git

or [view the repository on the
web](https://git.eyrie.org/?p=perl/ansicolor.git).

The eyrie.org repository is the canonical one, maintained by the author,
but using GitHub is probably more convenient for most purposes.  Pull
requests are gratefully reviewed and normally accepted.

## License

The Term::ANSIColor package as a whole is covered by the following
copyright statement and license:

> Copyright 1996-1998, 2000-2002, 2005-2006, 2008-2020, 2024
>     Russ Allbery <rra@cpan.org>
>
> Copyright 1996
>     Zenin
>
> Copyright 2012
>     Kurt Starsinic <kstarsinic@gmail.com>
>
> This program is free software; you may redistribute it and/or modify it
> under the same terms as Perl itself.  This means that you may choose
> between the two licenses that Perl is released under: the GNU GPL and the
> Artistic License.  Please see your Perl distribution for the details and
> copies of the licenses.
>
> PUSH/POP support, by David Nicol, contributed in 2007 by openmethods.com
> voice solutions

Some files in this distribution are individually released under different
licenses, all of which are compatible with the above general package
license but which may require preservation of additional notices.  All
required notices, and detailed information about the licensing of each
file, are recorded in the LICENSE file.

Files covered by a license with an assigned SPDX License Identifier
include SPDX-License-Identifier tags to enable automated processing of
license information.  See https://spdx.org/licenses/ for more information.

For any copyright range specified by files in this package as YYYY-ZZZZ,
the range specifies every single year in that closed interval.

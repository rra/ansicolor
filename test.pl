# Test suite for the Term::ANSIColor Perl module.  Before `make install' is
# performed this script should be runnable with `make test'.  After `make
# install' it should work as `perl test.pl'.
#
# Copyright 1996, 1997 by Russ Allbery <rra@cs.stanford.edu>
#                     and Zenin <zenin@best.com>
#
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

############################################################################
# Ensure module can be loaded
############################################################################

BEGIN { $| = 1; print "1..6\n" }
END   { print "not ok 1\n" unless $loaded }
use Term::ANSIColor qw(:constants color colored);
$loaded = 1;
print "ok 1\n";


############################################################################
# Test suite
############################################################################

# Note that all of these tests are really rather trivial, and I would be
# utterly astonished if any of them failed.  So if you *do* see any of them
# fail, please let me know about it.

# Test simple color attributes.
if (color ('blue on_green', 'bold') eq "\e[34;42;1m") {
    print "ok 2\n";
} else {
    print "not ok 2\n";
}

# Test colored.
if (colored ("testing", 'blue', 'bold') eq "\e[34;1mtesting\e[0m") {
    print "ok 3\n";
} else {
    print "not ok 3\n";
}

# Test the constants.
if (BLUE BOLD "testing" eq "\e[34m\e[1mtesting") {
    print "ok 4\n";
} else {
    print "not ok 4\n";
}

# Test autoreset.
$Term::ANSIColor::AUTORESET = 1;
if (BLUE BOLD "testing" eq "\e[34m\e[1mtesting\e[0m\e[0m") {
    print "ok 5\n";
} else {
    print "not ok 5\n";
}

# Test EACHLINE.
$Term::ANSIColor::EACHLINE = "\n";
if (colored ("test\n\ntest", 'bold')
    eq "\e[1mtest\e[0m\n\n\e[1mtest\e[0m") {
    print "ok 6\n";
} else {
    print "not ok 6\n";
}

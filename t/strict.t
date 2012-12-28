#!/usr/bin/perl
#
# Test Perl code for strict, warnings, and syntax.
#
# Copyright 2012 Russ Allbery <rra@stanford.edu>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use strict;
use warnings;

use Test::More;

# Skip tests if Test::Strict is not installed.
if (!eval { require Test::Strict }) {
    plan skip_all => 'Test::Strict required to test Perl syntax';
    $Test::Strict::TEST_WARNINGS = 0;    # suppress warning
}
Test::Strict->import;

# Test everything in the distribution directory.  We also want to check use
# warnings.
$Test::Strict::TEST_WARNINGS = 1;
all_perl_files_ok();

#!/usr/bin/perl
#
# Test Perl code for strict, warnings, syntax, and test coverage.
#
# Test coverage checking is disabled unless RRA_MAINTAINER_TESTS is set since
# it takes a long time, is sensitive to the versions of various libraries,
# and will not interfere with functionality.
#
# Copyright 2012 Russ Allbery <rra@stanford.edu>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use strict;
use warnings;

use File::Spec;
use Test::More;

# Coverage level achieved.
use constant COVERAGE_LEVEL => 100;

# Non-fuctional, generic tests to skip for test coverage analysis.  Also skip
# t/taint.t since Devel::Cover doesn't know how to run scripts requiring
# taint checking.
use constant COVERAGE_SKIP_TESTS => (
    't/critic.t',       't/minimum-version.t',
    't/pod-coverage.t', 't/pod-spelling.t',
    't/pod.t',          't/synopsis.t',
    't/taint.t',
);

# Skip tests if Test::Strict is not installed.
if (!eval { require Test::Strict }) {
    plan skip_all => 'Test::Strict required to test Perl syntax';

    # Suppress "only used once" warnings.
    $Test::Strict::TEST_SKIP           = [];
    $Test::Strict::TEST_WARNINGS       = 0;
    $Test::Strict::DEVEL_COVER_OPTIONS = q{};
}
Test::Strict->import;

# Test everything in the distribution directory.  We also want to check use
# warnings.
$Test::Strict::TEST_WARNINGS = 1;
all_perl_files_ok();

# Test code coverage.  Skip this test unless we're running the test suite in
# maintainer mode.
SKIP: {
    if (!$ENV{RRA_MAINTAINER_TESTS}) {
        skip 'Coverage test only run for maintainer', 1;
    }
    if (!eval { require Devel::Cover }) {
        skip 'Devel::Cover required to check test coverage', 1;
    }

    # Skip the various generic tests that don't add to coverage.  Some of
    # these load a lot of Perl code, which causes Devel::Cover to be very
    # slow.
    my @skip = map { File::Spec->canonpath($_) } COVERAGE_SKIP_TESTS;
    $Test::Strict::TEST_SKIP = [@skip];

    # Disable POD coverage; that's handled separately and is confused by our
    # autoloading.
    $Test::Strict::DEVEL_COVER_OPTIONS
      = '-coverage,statement,branch,condition,subroutine';
    all_cover_ok(COVERAGE_LEVEL);
}

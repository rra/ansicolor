#!/usr/bin/perl
#
# t/pod.t -- Test POD formatting for Term::ANSIColor.
#
# Taken essentially verbatim from the examples in the Test::Pod documentation.

use strict;
use Test::More;
eval 'use Test::Pod 1.00';
plan skip_all => "Test::Pod 1.00 required for testing POD" if $@;
all_pod_files_ok ();

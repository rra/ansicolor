#!/usr/bin/perl
#
# Check all POD documents for POD formatting errors.
#
# Copyright 2012 Russ Allbery <rra@stanford.edu>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.

use strict;
use warnings;

use Test::More;

# Skip tests if Test::Pod is not installed.
if (!eval { require Test::Pod }) {
    plan skip_all => 'Test::Pod required to test POD syntax';
}
Test::Pod->import;

# Check all POD in the Perl distribution.
all_pod_files_ok();

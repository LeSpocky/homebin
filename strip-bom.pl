#!/usr/bin/perl -w

use strict;
use warnings;

while ( my $line = <ARGV> ) {
    $line =~ s{^\xEF\xBB\xBF}{}xms;
    print $line;
}

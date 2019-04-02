#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'List::LineNumbered' ) || print "Bail out!\n";
}

diag( "Testing List::LineNumbered $List::LineNumbered::VERSION, Perl $], $^X" );

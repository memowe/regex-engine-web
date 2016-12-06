#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 17;
use Test::Mojo;

# prepare
use FindBin '$Bin';
use lib "$Bin/../regex-engine/lib";
require "$Bin/../regex-engine-web";
my $t = Test::Mojo->new;

# test form
$t->get_ok('/')->status_is(200)->text_is(h1 => 'Regular Expression Engine Web')
    ->element_exists('form input[name=regex]')
    ->element_exists('form input[name=input]')
    ->element_exists('form input[type=submit]');

# wrong regex
$t->post_ok('/match' => form => {regex => '*', input => 'foo'})
    ->status_is(200)->content_like(qr/Parse error: unexpected \*/);

# no match
$t->post_ok('/match' => form => {regex => 'a', input => 'b'})->status_is(200)
    ->text_is('tr:nth-child(3) th', 'Match')
    ->text_is('tr:nth-child(3) td', 'No');

# match
$t->post_ok('/match' => form => {regex => 'a', input => 'a'})->status_is(200)
    ->text_is('tr:nth-child(3) th', 'Match')
    ->text_is('tr:nth-child(3) td', 'Yes');

__END__

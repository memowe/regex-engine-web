#!/usr/bin/env perl

use FindBin '$Bin';
use lib "$Bin/regex-engine/lib";
use REE;
use Mojolicious::Lite;

# regex form (template only)
any '/' => 'home';

# information about a match
post '/match' => sub {
    my $c = shift;

    # form data
    my $regex   = $c->param('regex');
    my $input   = $c->param('input');

    # try to compile
    my $ree     = eval {REE->new(regex => $regex)};
    return $c->render(text => $@) if $@;

    # done
    $c->stash(
        regex   => $regex,
        input   => $input,
        success => $ree->match($input) ? 1 : 0,
        ree     => $ree,
    );
};

app->start;
__DATA__

@@ home.html.ep
% layout 'default';
% title 'Regular Expression Engine Web';
<h1><%= title %></h1>
%= form_for match => (method => 'post') => begin
    <p>
        %= label_for regex => 'Regular Expression:'
        %= text_field regex => param('regex') => (id => 'regex')
        %= label_for input => 'Input:'
        %= text_field input => param('input') => (id => 'input')
    </p>
    <p><%= submit_button 'Try to match!' %></p>
% end

@@ match.html.ep
% layout 'default';
% title 'REE Matching Result';
<h1><%= title %></h1>
<table>
    <tr><th>Regular Expression</th><td><code><%= $regex %></code></td></tr>
    <tr><th>Input</th><td><code><%= $input %></code></td></tr>
    <tr><th>Match</th><td><%= $success ? 'Yes' : 'No' %></td></tr>
</table>
<p>NFA:</p>
<pre><code><%= $ree->nfa_representation %></code></pre>
%= form_for home => (method => 'post') => begin
    %= hidden_field regex => $regex
    %= hidden_field input => $input
    %= submit_button 'Try again!'
% end

@@ layouts/default.html.ep
<!DOCTYPE html>
<html><head><title><%= title %></title></head><body>
%= content
</body></html>

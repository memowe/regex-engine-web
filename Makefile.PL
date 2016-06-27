use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR      => q{Mirko Westermeier <mirko@westermeier.de>},
    VERSION     => '0.01',
    LICENSE     => 'mit',
    PREREQ_PM   => {
        'Mojolicious' => '7.0',
    },
    test      => {TESTS => 't/*.t'}
);

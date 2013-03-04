use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    license        => 'perl',
    dynamic_config => 0,

    build_requires     => {
        'Test::More'     => '0.98',
        'Test::Requires' => '0.06',
    },
    configure_requires => { 'Module::Build' => '0.38' },
    requires           => {
        perl              => '5.008001',
        'Data::Validator' => '0',
    },

    no_index    => { 'directory' => [ 'inc' ] },
    name        => 'Data-Validator-Recursive',
    module_name => 'Data::Validator::Recursive',

    # script_files => [''],

    test_files           => (-d '.git' || $ENV{RELEASE_TESTING}) ? 't/ xt/' : 't/',
    recursive_test_files => 1,

    meta_merge => {
        resources => {
            repository => 'https://github.com/xaicron/p5-Data-Validator-Recursive',
            bugtracker => 'https://github.com/xaicron/p5-Data-Validator-Recursive/issues',
        },
    },

    create_readme  => 1,
    create_license => 1,
);

$build->create_build_script();

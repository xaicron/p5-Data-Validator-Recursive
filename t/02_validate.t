use strict;
use warnings;
use Test::More;
use Data::Validator::Recursive;

my $rule = Data::Validator::Recursive->new(
    foo => 'Str',
    bar => { isa => 'Int', optional => 1 },
    baz => {
        isa  => 'HashRef',
        rule => [
            hoge => 'Str',
            fuga => 'Int',
        ],
    },
);

subtest 'valid data' => sub {
    my $input = {
        foo => 'xxx',
        bar => 123,
        baz => {
            hoge => 'xxx',
            fuga => 123,
        },
    };
    my $params = $rule->validate($input);

    is_deeply $params, $input;
    ok !$rule->has_error;
    ok !$rule->error;
    ok !$rule->errors;
    ok !$rule->clear_errors;
};

subtest 'valid data' => sub {
    my $input = {
        foo => 'xxx',
        bar => 123,
        baz => {
            fuga => 'piyo',
        },
    };
    ok! $rule->validate($input);

    ok $rule->has_error;
    is_deeply $rule->error, {
        name    => 'baz.fuga',
        type    => 'InvalidValue',
        message => q{'baz.fuga' is InvalidValue},
    };

    is_deeply $rule->errors, [
        {
            name    => 'baz.fuga',
            type    => 'InvalidValue',
            message => q{'baz.fuga' is InvalidValue},
        },
        {
            name    => 'baz.hoge',
            type    => 'MissingParameter',
            message => q{'baz.hoge' is MissingParameter},
        },
    ];
    is_deeply $rule->errors, $rule->clear_errors;
    ok !$rule->has_error;
};

done_testing;

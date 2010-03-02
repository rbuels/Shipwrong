use Module::Build;
my $build = Module::Build->new(

    module_name        => 'CXGN::Build',
    dist_name          => 'CXGN-Builder',
    license            => 'perl',
    create_makefile_pl => 'passthrough',

    # current version of our core libraries distribution
    dist_version => '0.1',

    recursive_test_files => 1,

    share_dir => 'share',

    build_requires => {
        'File::Temp'   => 0,
        'Test::Output' => 0,
        'Test::More'   => 0,
    },
    requires => {
        'autodie' => 0,
        'File::Copy::Recursive' => 0,
        'File::ShareDir' => 0,
        'File::Temp' => 0,
        'IPC::Cmd' => 0,
        'Path::Class' => 0,
	'Shipwright'  => 0,
    },
);
$build->create_build_script;

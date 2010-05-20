use Module::Build;
my $build = Module::Build->new(

    dist_name          => 'Shipwrong',
    dist_author        => 'Robert Buels',
    dist_abstract      => 'a simple Perl build and deployment system that wraps Shipwright',
    dist_version_from  => 'bin/shipwrong',
    license            => 'perl',
    create_makefile_pl => 'passthrough',

    meta_merge         => {
        resources =>
          { repository => 'http://github.com/rbuels/Shipwrong' },
    },

    recursive_test_files => 1,

    share_dir => 'share',

    build_requires => {
        'File::Temp'    => 0,
        'Capture::Tiny' => 0,
        'Test::More'    => 0,
    },
    requires => {
        'autodie'               => 0,
        'File::Copy::Recursive' => 0,
        'File::ShareDir'        => 0,
        'File::Spec'            => 0,
        'File::Temp'            => 0,
        'Getopt::Std'           => 0,
        'IPC::Cmd'              => 0,
        'Module::Pluggable'     => 0,
        'Path::Class'           => 0,
        'Pod::Usage'            => 0,
	'Shipwright'            => 0,
        'YAML'                  => 0,
    },
);
$build->create_build_script;

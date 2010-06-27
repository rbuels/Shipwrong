use strict;
use warnings;

use Cwd;
use Test::More;
use Capture::Tiny qw/ capture /;

use FindBin;

use File::Temp ();
use File::Spec::Functions;


my $tempdir    = File::Temp->newdir( CLEANUP => 0 );
my $test_repos = catdir( $tempdir, 'tester' );

my ($stdout, $stderr) = capture {
    system "bin/shipwrong-repo", 'create', $test_repos;
};

is( $stdout, "running shipwright ... created with success\n", 'stdout looks ok' );
is( $stderr, '', 'stderr looks ok' );

ok(   -e catfile( $test_repos, $_ ), "got $_" ) for qw( shipwrong.conf Makefile );
ok( ! -e catfile( $test_repos, $_ ), "no $_"  ) for qw( debian );


$test_repos = catdir( $tempdir, 'debianized' );

($stdout, $stderr) = capture {
    system "bin/shipwrong-repo", 'create', '--debianize', $test_repos;
};

like( $stdout, qr/^running shipwright ... created with success\ndebianizing/, 'stdout looks ok' );
is( $stderr, '', 'stderr looks ok' );

ok(   -e catfile( $test_repos, $_ ), "got $_" ) for qw( shipwrong.conf Makefile debian );
my $rules = do {
    local $/;
    open my $r, catfile( $test_repos, 'debian', 'rules' ) or die;
    <$r>
};
like( $rules, qr/#dh_link/, 'dh_link appears to be commented out in debian rules file' );


done_testing;

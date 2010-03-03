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
    system "bin/shipwrong", 'create', $test_repos;
};

is( $stdout, "running shipwright ... created with success\n", 'stdout looks ok' );
is( $stderr, '', 'stderr looks ok' );

ok(   -e catfile( $test_repos, $_ ), "got $_" ) for qw( shipwrong.conf Makefile );
ok( ! -e catfile( $test_repos, $_ ), "no $_"  ) for qw( debian );


$test_repos = catdir( $tempdir, 'debianized' );

($stdout, $stderr) = capture {
    system "bin/shipwrong", 'create', '--debianize', $test_repos;
};

like( $stdout, qr/^running shipwright ... created with success\ndebianizing/, 'stdout looks ok' );
is( $stderr, '', 'stderr looks ok' );

ok(   -e catfile( $test_repos, $_ ), "got $_" ) for qw( shipwrong.conf Makefile debian );

done_testing;

use strict;
use warnings;

use Cwd;
use Test::More;
use Test::Output;

use FindBin;

use File::Temp ();
use File::Spec::Functions;

my $tempdir    = File::Temp->newdir( CLEANUP => 0 );
diag "tempdir is $tempdir";
my $test_repos = catdir( $tempdir, 'tester' );

output_like(sub {
    system "bin/shipwrong", 'create', catdir($tempdir,'tester')
   },
   qr/foo/,
   qr/bar/,
   'create output looks OK'
  );

for my $f (qw(  shipwrong.conf Makefile )) {
    ok( -e catfile( $test_repos, $f ), "got $f" );
}

done_testing;

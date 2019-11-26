#!perl
use strict;
use warnings;

$ENV{XZ_DEFAULTS} = "-C none -9e -vv --lzma2=dict=30KiB,mode=normal,nice=273,depth=1000 --memlimit-decompress=100KiB";

my $name = $ARGV[0];
my $version = $ARGV[1];
my $plevel = ( $ARGV[2] || '0' );

my $src_dir = ( substr $name, 0, 1 ) . '/' . $name . '/' . $version;
my $archive = $name . '-' . $version . '-p' . $plevel . '.tar.xz';

system(
  'tar', '-acvf', $archive, '-C', $src_dir,'--owner=nobody','--group=nobody','--sort=name','--show-transformed-names','--totals', '--transform=s|^./|./patches/|', './'
) == 0 or die;
system(
  'tar', '-atvf', $archive
) == 0 or die;

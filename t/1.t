use Test::More tests => 5;

use_ok('File::BaseDir', qw/xdg_data_home xdg_data_dirs xdg_data_files/); # 1

ok( ref(File::BaseDir->new) eq 'File::BaseDir', 'OO constructor works'); # 2

$ENV{XDG_DATA_HOME} = 'test123';
ok( xdg_data_home() eq 'test123', 'xdg_data_home works'); # 3

$ENV{XDG_DATA_DIRS} = './t/';
ok( -d ( xdg_data_dirs() )[0], 'xdg_data_dirs work'); # 4

my $file = ( xdg_data_files('some_file') )[0];
ok( -e $file, 'xdg_data_files seems to work'); # 5


#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use File::UserDirs qw(:all);
use File::BaseDir qw(config_home);
use File::Spec::Functions qw(catfile);
use File::Which qw(which);

my $xdg_user_dir_installed = 0;
if (which 'xdg-user-dir') {
    plan tests => 8;
    $xdg_user_dir_installed = 0;
} else {
    plan skip_all => '"xdg-user-dir" executable not found. Install package "xdg-user-dirs".';
    
}

my $udd = config_home('user-dirs.dirs');
if (-e $udd) {
    rename $udd, "$udd~" or die "could not make backup of $udd: $!";
}

open my $fh, '>', $udd or die "could not open $udd for writing: $!";
print $fh <<'UDD';
XDG_DESKTOP_DIR="$HOME/Workspace"
XDG_DOCUMENTS_DIR="$HOME/Files"
XDG_DOWNLOAD_DIR="$HOME/Files/Downloads"
XDG_MUSIC_DIR="$HOME/Files/Audio"
XDG_PICTURES_DIR="$HOME/Files/Images"
XDG_PUBLICSHARE_DIR="$HOME/public_html"
XDG_TEMPLATES_DIR="$HOME/Files/Document templates"
XDG_VIDEOS_DIR="$HOME/Files/Video"
UDD
close $fh;

is xdg_desktop_dir,     catfile($ENV{HOME}, 'Workspace');
is xdg_documents_dir,   catfile($ENV{HOME}, 'Files');
is xdg_download_dir,    catfile($ENV{HOME}, 'Files/Downloads');
is xdg_music_dir,       catfile($ENV{HOME}, 'Files/Audio');
is xdg_pictures_dir,    catfile($ENV{HOME}, 'Files/Images');
is xdg_publicshare_dir, catfile($ENV{HOME}, 'public_html');
is xdg_templates_dir,   catfile($ENV{HOME}, 'Files/Document templates');
is xdg_videos_dir,      catfile($ENV{HOME}, 'Files/Video');

END {
    if ($xdg_user_dir_installed) {
        if (-e "$udd~") {
            rename "$udd~", $udd or die "could not restore backup of $udd: $!";
        } else {
            unlink $udd or die "could not delete $udd: $!";
        }
    }
}
package File::BaseDir;

use strict;
use Carp;
require File::Spec;
require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
	xdg_data_home xdg_data_dirs xdg_data_files
	xdg_config_home xdg_config_dirs xdg_config_files
	xdg_cache_home
);
our $VERSION = 0.02;

my $rootdir = File::Spec->rootdir();

our $xdg_data_home = File::Spec->catdir($ENV{HOME}, qw/.local share/);
our @xdg_data_dirs = (
	File::Spec->catdir($rootdir, qw/usr local share/),
	File::Spec->catdir($rootdir, qw/usr share/),
);

our $xdg_config_home = File::Spec->catdir($ENV{HOME}, '.config');
our @xdg_config_dirs = ( File::Spec->catdir($rootdir, qw/etc xdg/) );

our $xdg_cache_home = File::Spec->catdir($ENV{HOME}, '.cache');

sub new { bless \$VERSION, shift } # what else is there to bless ?

sub xdg_data_home { $ENV{XDG_DATA_HOME} || $xdg_data_home }

sub xdg_data_dirs {
	( $ENV{XDG_DATA_DIRS}
		? _adapt($ENV{XDG_DATA_DIRS})
		: @xdg_data_dirs
	)
}

sub xdg_data_files { _find_files(\@_, xdg_data_home, xdg_data_dirs) }

sub xdg_config_home {$ENV{XDG_CONFIG_HOME} || $xdg_config_home }

sub xdg_config_dirs {
	( $ENV{XDG_CONFIG_DIRS}
		? _adapt($ENV{XDG_CONFIG_DIRS})
		: @xdg_config_dirs
	)
}

sub xdg_config_files { _find_files(\@_, xdg_config_home, xdg_config_dirs) }

sub xdg_cache_home { $ENV{XDG_CACHE_HOME} || $xdg_cache_home }

sub _adapt {
	map { File::Spec->catdir( split('/', $_) ) }
	split ':', shift;
}

sub _find_files {
	my $file = shift;
	return
		grep { -f $_ && -r $_ }
		map  { File::Spec->catfile($_, @$file) }
		@_;
}

1;

__END__

=head1 NAME

File::BaseDir - use the freedesktop basedir spec

=head1 SYNOPSIS

	use File::BaseDir qw/xdg_data_files/;
	for ( xdg_data_files('mime/globs') ) {
		# do something
	}

=head1 DESCRIPTION

This module can be used to find directories and files as specified
by the XDG Base Directory Specification. It takes care of defaults
and uses L<File::Spec> to make the output platform specific.

This module forked from L<File::MimeInfo>.

For this module the XDG basedir specification 0.6 was used.

=head1 EXPORT

None by default, but all methods can be exported on demand.

=head1 METHODS

=over 4

=item C<new()>

Simple constructor to allow Object Oriented use of this module.

=item C<xdg_data_home>

Returns either C<$ENV{XDG_DATA_HOME}> or it's default value.

=item C<xdg_data_dirs>

Returns either C<$ENV{XDG_DATA_DIRS}> or it's default value.

=item C<xdg_data_files($file)>

Searches for C<$file> in all C<XDG_DATA_DIRS> and only returns
existing readable files.

The file path can also be given as a list.

=item C<xdg_config_home>

Returns either C<$ENV{XDG_CONFIG_HOME}> or it's default value.

=item C<xdg_config_dirs>

Returns either C<$ENV{XDG_CONFIG_DIRS}> or it's default value.

=item C<xdg_config_files($file)>

Searches for C<$file> in all C<XDG_CONFIG_DIRS> and only returns
existing readable files.

The file path can also be given as a list.

=item C<xdg_cache_home>

Returns either C<$ENV{XDG_CACHE_HOME}> or it's default value.

=back

=head1 BUGS

Please mail the author if you encounter any bugs.

=head1 AUTHOR

Jaap Karssenberg || Pardus [Larus] E<lt>pardus@cpan.orgE<gt>

Copyright (c) 2003 Jaap G Karssenberg. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://www.freedesktop.org/standards/basedir-spec/>


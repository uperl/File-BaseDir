#!/usr/bin/perl

use Module::Build;

my $build = Module::Build->new(
	dist_name => 'File-BaseDir',
	dist_version_from => 'lib/File/BaseDir.pm',
	dist_author => 'Jaap Karssenberg <pardus@cpan.org>',
	license => 'perl',
	requires => {
		'Carp'		=> 0,
		'Exporter'	=> '5.57',
		'File::Spec'	=> 0,
        'IPC::System::Simple' => 0
	},
	build_requires => {
		'Module::Build'  => '0.24',
        	'File::Temp'     => 0
	},
	test_requires => {
		'Test::More'      => 0,
	        'File::Which'     => 0,
	        'File::chdir'     => 0,
	},
);
$build->add_to_cleanup('File-BaseDir-*');
$build->create_build_script;


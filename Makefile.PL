use ExtUtils::MakeMaker;

WriteMakefile(
	'NAME'		=> 'File::BaseDir',
	'VERSION_FROM'	=> 'BaseDir.pm',
	'PREREQ_PM'	=> {
		'Carp'		=> 0,
		'Exporter'	=> 0,
		'File::Spec'	=> 0,
	}, 
	($] >= 5.005
		? (AUTHOR     => 'Jaap Karssenberg <pardus@cpan.org>') 
		: ()
	),
);

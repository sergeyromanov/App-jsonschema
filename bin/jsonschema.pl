#!/usr/bin/env perl 

use strict; use warnings;
use App::jsonschema;

		
&usage if @ARGV < 2;
my $schema_file = shift;

my $app = App::jsonschema->new(	schema_file => $schema_file );
$app->validate(@ARGV);

sub usage {
	print STDERR "Usage: $0 schema.json file1.json [file2.json ...]\n";
	exit 1;
}


# ABSTRACT: Validate JSON files using JSON Schema
# PODNAME: jsonschema.pl

=head1 SYNOPSIS

jsonschema.pl schema.json file1.json [file2.json ...]

=head1 COMMANDS

=over 4


=back

=head1 OPTIONS

=over 4

=back

=head1 SEE ALSO

L<App::jsonschema>

=head1 COPYRIGHT

Copyright 2013 Andre Santos.

=head1 AUTHOR

Andre Santos <andrefs@cpan.org>

=cut

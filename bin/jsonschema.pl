#!/usr/bin/env perl 

use strict; use warnings;
use App::jsonschema;

#ABSTRACT: Validate JSON files using JSON Schema
		
&usage if @ARGV < 2;
my $schema_file = shift;

my $app = App::jsonschema->new(	schema_file => $schema_file );
$app->validate(@ARGV);

sub usage {
	print STDERR "Usage: $0 schema.json file1.json [file2.json ...]\n";
	exit 1;
}


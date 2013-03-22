use strict;
use warnings;
package App::jsonschema;
use JSON::Schema;
use JSON qw/from_json/;
use autodie;
use Moo;
use feature qw/say/;
use Data::Dump qw/dump/;


# ABSTRACT: Command-line utility to validate JSON using JSON Schema

has schema_file => ( 
	is 			=> 'rw', 
	required 	=> 1,
	isa 		=> sub { die "Could not find file '$_[0]'!" unless -f $_[0] }
);
has schema		=> ( is => 'lazy' );
has validator	=> ( is => 'lazy' );

sub _build_validator  {
	my $self = shift;
	return JSON::Schema->new($self->schema);
}

sub _build_schema {
	my $self = shift;
	my $schema;
	{
		local $/;
		open my $fh, '<', $self->schema_file;
		$schema = <$fh>;
		close $fh;
	}
	return $schema;
}

sub validate {
	my ($self,@files) = @_;
	my $result;
	my $status = 0;
	for my $file (@files){
		my $json;
		{
			local $/;
			open my $fh, '<', $file;
			$json = <$fh>;
			close $fh;
		}
		$result = $self->validator->validate(from_json($json));
		unless($result->valid){
			$self->_report_errors($result,$file);
			$status++;
		}
	}
	exit $status;
}

sub _report_errors {
	my ($self,$result,$json_file) = @_;
	print STDERR "Cannot validate '$json_file' against schema '".$self->schema_file."':\n";
	foreach ($result->errors){
		print STDERR "  ".$_->{property}.":\t".$_->{message}."\n";
	}
}


1;

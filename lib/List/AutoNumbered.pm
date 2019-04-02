package List::AutoNumbered;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.000001';  # TRIAL

use parent 'Exporter';
our @EXPORT = qw(LSKIP);

# Documentation ======================================================== {{{1

=head1 NAME

List::AutoNumbered - Add line numbers to lists while creating them

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use List::AutoNumbered;

    my $foo = List::AutoNumbered->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

# }}}1

# Internals {{{1

# Defined-or
sub _dor { (defined $_[0]) ? $_[0] : $_[1] }

# }}}1

=head1 new

Constructor.  Call as $class->new(__LINE__); each element is one line.

=cut
sub new {
    my $class = shift;
    my $self = bless {lnum => _dor(shift, 0), arr => []}, $class;

    # Make a loader that adds an item and returns itself --- not $self
    $self->{loader} = sub { $self->L(@_); return $self->{loader} };
        # TODO add a skip() method callable on the loader

    return $self;
} #new()

# Accessors {{{1
sub size { return scalar @{ shift->{arr} }; }
sub last { return shift->size-1; }      # $#
sub arr { return shift->{arr}; }

# }}}1
# Loading {{{1
sub load { goto &{ shift->{loader} } }  # kick off loading

=head2 L

Push a new record with the next line number on the front.  Usage:

    $instance->L(whatever args you want to push);

Or, if the current record isn't on the line immediately after the previous
record,

    $instance->L(

=cut

sub L {
    my $self = shift;

    # Check for skipped lines from LSKIP()
    if(@_ && ref $_[0] eq 'TestcaseList::Skipper') {
        $self->{lnum} += $_[0]->{how_many};
        shift;
    }

    push @{ $self->{arr} }, [++$self->{lnum}, @_];
    return $self;
} #L

sub add {   # just add it
    my $self = shift;
    ++$self->{lnum};    # keep it consistent
    push @{ $self->{arr} }, [@_];
    return $self;
} #add

# }}}1
# Skipping {{{1

=head2 LSKIP

A convenience function to create a skipper.  Prototyped as C<($)> so you can
use it conveniently with L</L>:

    $instance->L(LSKIP 1, whatever args...);

=cut

sub LSKIP ($) {
    TestcaseList::Skipper->new(@_);
} #LSKIP()

{
    package TestcaseList::Skipper;
    use Scalar::Util qw(looks_like_number);

    sub new {
        my $class = shift;
        die "Need a number" unless @_==1 and looks_like_number $_[0];
        bless {how_many => $_[0]}, $class;
    }
}

# }}}1

1; # End of List::AutoNumbered

# Rest of the docs {{{1
__END__

=head1 AUTHOR

Christopher White, C<< <cxwembedded at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests through the web interface at
L<https://github.com/cxw42/List-AutoNumbered/issues>.  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc List::AutoNumbered

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/pod/List::AutoNumbered>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/List-AutoNumbered>

=back

=head1 ACKNOWLEDGEMENTS

Thanks to zdim for discussion on the
L<Stack Overflow question|https://stackoverflow.com/q/50510809/2877364>
that was the starting point for this module.

=head1 LICENSE AND COPYRIGHT

Copyright 2019 Christopher White.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut

# }}}1
# vi: set fdm=marker: #

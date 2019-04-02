# List::LineNumbered - Add line numbers to lists while creating them



Quick summary of what the module does.

Perhaps a little code snippet.

    use List::LineNumbered;

    my $foo = List::LineNumbered->new();
    ...

# EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

# SUBROUTINES/METHODS

# new

Constructor.  Call as $class->new(\_\_LINE\_\_); each element is one line.

## L

Push a new record with the next line number on the front.  Usage:

    $instance->L(whatever args you want to push);

Or, if the current record isn't on the line immediately after the previous
record,

    $instance->L(

## LSKIP

A convenience function to create a skipper.  Prototyped as `($)` so you can
use it conveniently with ["L"](#l):

    $instance->L(LSKIP 1, whatever args...);

# AUTHOR

Christopher White, `<cxwembedded at gmail.com>`

# BUGS

Please report any bugs or feature requests through the web interface at
[https://github.com/cxw42/List-LineNumbered/issues](https://github.com/cxw42/List-LineNumbered/issues).  I will be notified, and
then you'll automatically be notified of progress on your bug as I make
changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc List::LineNumbered

You can also look for information at:

- MetaCPAN

    [https://metacpan.org/pod/List::LineNumbered](https://metacpan.org/pod/List::LineNumbered)

- CPAN Ratings

    [https://cpanratings.perl.org/d/List-LineNumbered](https://cpanratings.perl.org/d/List-LineNumbered)

# ACKNOWLEDGEMENTS

Thanks to zdim for discussion on the
[Stack Overflow question](https://stackoverflow.com/q/50510809/2877364)
that was the starting point for this module.

# LICENSE AND COPYRIGHT

Copyright 2019 Christopher White.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See [http://dev.perl.org/licenses/](http://dev.perl.org/licenses/) for more information.

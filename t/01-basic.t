#!perl
use 5.006;
use lib::relative '.';
use MY::Kit;

# Skipper
my $dut = LSKIP 1;
isa_ok($dut, $DUT . '::Skipper');

# List::AutoNumbered
$dut = $DUT->new;    # No parameters
isa_ok($dut, $DUT);

$dut = $DUT->new(42);   # With parameters
isa_ok($dut, $DUT);

# Initial members
num_is($dut->size, 0, 'Zero size initially');
num_is($dut->last, -1, '$# == -1 initially');
is_deeply($dut->arr, [], 'Empty array initially');

# Loads
$dut->load(1337);
is_deeply($dut->arr, [ [43, 1337] ], 'Adding an element also adds next number');
num_is($dut->size, 1, 'size 1 after add');
num_is($dut->last, 0, '$# == 0 after add');

$dut->load(1338);
is_deeply($dut->arr, [ [43, 1337], [44, 1338] ], 'Adding another element also adds next number');
num_is($dut->size, 2, 'size 2 after add 2');
num_is($dut->last, 1, '$# == 1 after add 2');

# skips

$dut->load(LSKIP 1, 1339);
is_deeply($dut->arr, [ [43, 1337], [44, 1338], [46, 1339] ], 'Adding after skip skips number');
num_is($dut->size, 3, 'size 3 after add 3');
num_is($dut->last, 2, '$# == 2 after add 3');

$dut->load(LSKIP 9, 1340);
is_deeply($dut->arr, [ [43, 1337], [44, 1338], [46, 1339], [56, 1340] ], 'Adding after skip skips numbers');
num_is($dut->size, 4, 'size 4 after add 4');
num_is($dut->last, 3, '$# == 3 after add 4');

done_testing;

MACHINE
	BIT_DEFINITION

CONSTANTS
	BIT,
	bit_not,
	bit_and,
	bit_or,
	bit_xor,
	bool_to_bit

PROPERTIES
	BIT = 0..1 &
	bit_not : BIT --> BIT &
	! (bb). (bb : BIT => bit_not(bb) = 1-bb) &
	bit_and : BIT * BIT --> BIT &
	! (b1, b2).(b1 : BIT & b2 : BIT => ((bit_and(b1, b2) = 1) <=> (b1 = 1) & (b2 = 1))) &
	bit_or : BIT * BIT --> BIT &
	! (b1, b2).(b1 : BIT & b2 : BIT => ((bit_or(b1, b2) = 1) <=> (b1 = 1) or (b2 = 1))) &
	bit_xor : BIT * BIT --> BIT &
	! (b1, b2).(b1 : BIT & b2 : BIT => ((bit_xor(b1, b2) = 1) <=> (b1 /= b2))) &
	bool_to_bit : BOOL --> BIT &
	bool_to_bit = { TRUE |-> 1, FALSE |-> 0 }

ASSERTIONS
	bit_not(0) = 1;
	bit_not(1) = 0;
	!(bb).(bb : BIT => bit_not(bit_not(bb)) = bb);

	bit_and(0,0) = 0;
	bit_and(0,1) = 0;
	bit_and(1,0) = 0;
	bit_and(1,1) = 1;
	!(b1,b2).(b1 : BIT & b2 : BIT => (bit_and(b1, b2) = bit_and(b2,b1)));
	!(b1,b2,b3).(b1 : BIT & b2 : BIT & b3 : BIT => (bit_and(b1, bit_and(b2,b3)) = bit_and(bit_and(b1,b2),b3)));
	!(b1).(b1 : BIT => (bit_and(b1, 1) = b1));
	!(b1).(b1 : BIT => (bit_and(b1, 0) = 0));

	bit_or(0,0) = 0;
	bit_or(0,1) = 0;
	bit_or(1,0) = 0;
	bit_or(1,1) = 1;
	!(b1, b2).(b1 : BIT & b2 : BIT => (bit_or(b1, b2) = bit_or(b2,b1)));
	!(b1,b2,b3).(b1 : BIT & b2 : BIT & b3 : BIT => (bit_or(b1, bit_or(b2,b3)) = bit_or(bit_or(b1,b2),b3)));
	!(b1).(b1 : BIT => (bit_or(b1, 1) = 1));
	!(b1).(b1 : BIT => (bit_or(b1, 0) = b1));

	bit_xor(0,0) = 0;
	bit_xor(0,1) = 1;
	bit_xor(1,0) = 1;
	bit_xor(1,1) = 0;
	!(b1, b2).(b1 : BIT & b2 : BIT => (bit_xor(b1, b2) = bit_xor(b2,b1)));
	!(b1,b2,b3).(b1 : BIT & b2 : BIT & b3 : BIT => (bit_xor(b1, bit_xor(b2,b3)) = bit_xor(bit_xor(b1,b2),b3)));
	!(bb).(bb : BIT => bit_xor(bb,bb) = 0);

	bool_to_bit(TRUE) = 1;
	bool_to_bit(FALSE) = 0

END
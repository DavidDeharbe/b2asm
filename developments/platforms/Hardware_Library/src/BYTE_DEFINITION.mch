MACHINE
    BYTE_DEFINITION
    
SEES 
    BIT_DEFINITION,
    BIT_VECTOR_DEFINITION,
    POWER2
    
DEFINITIONS
    BYTE_WIDTH == 8 ;
    
    pow2_0 == 1;
    pow2_1 == 2;
    pow2_2 == 4;
    pow2_3 == 8;
    pow2_4 == 16;
    pow2_5 == 32;
    pow2_6 == 64;
    pow2_7 == 128;
    pow2_8 == 256;
    pow2_9 == 512;
    pow2_10 == 1024;    
    pow2_11 == 2048;  
    pow2_12 == 4096;   
    pow2_13 == 8192;
    pow2_14 == 16384;   
    pow2_15 == 32768; 
    pow2_16 == 65536       
    
CONSTANTS
    
    BYTE,
    BYTE_INDEX,
    BYTE_ZERO,
    PHYS_BYTE_INDEX,
    
    
    is_zero,
    parity_even,
    and , ior , xor ,
    bitclear , bitset , bitget ,
    complement, swap , rotateleft , rotateright,   
    get_upper_digit ,
    get_lower_digit 
    
PROPERTIES
    
    BYTE_INDEX = 1.. (BYTE_WIDTH) &
    PHYS_BYTE_INDEX = 0..(BYTE_WIDTH-1)  &
    BYTE = { bt | bt:BIT_VECTOR & bv_size(bt)=BYTE_WIDTH}  &
    BYTE_ZERO : BYTE &
    BYTE_ZERO = BYTE_INDEX * {0} &
    
    
    is_zero : BYTE --> BIT &
    is_zero = %(w1).(w1 : BYTE | bool_bit( bool(w1(1) + w1(2)+ w1(3) + w1(4) + w1(5) + w1(6) + w1(7) + w1(8) = 0) )) &

    
    parity_even : BYTE --> BIT	&
    parity_even = % (bv). (bv : BYTE | 1-( bv(1)+ bv(2)+ bv(3)+bv(4)+bv(5)+ bv(6)+bv(7)+bv(8) mod 2)) &
    
    and : (BYTE * BYTE) --> BYTE &
    and = %(bt1, bt2).(bt1:BYTE & bt2:BYTE | bv_and(bt1,bt2)) &
    
    ior : (BYTE * BYTE) --> BYTE & 
    ior = %(bt1, bt2).(bt1:BYTE & bt2:BYTE | bv_or(bt1,bt2))   & 
    
    xor : (BYTE * BYTE) --> BYTE &
    xor = %(bt1, bt2).(bt1 : BYTE & bt2 : BYTE | bv_xor(bt1,bt2)) &
    
    
    bitget : (BYTE * PHYS_BYTE_INDEX) --> BIT & 
/*  bitget = %(bt1, ii).(bt1 : BYTE & ii : PHYS_BYTE_INDEX | bv_get(bt1, ii)) &  */
    bitget = %(bt1, ii).(bt1 : BYTE & ii : PHYS_BYTE_INDEX | bt1(ii+1)) & /* mode more simple */
    
    bitset : (BYTE * PHYS_BYTE_INDEX) --> BYTE & 
    bitset = %(bt1, ii).(bt1 : BYTE & ii : PHYS_BYTE_INDEX | bv_set(bt1, ii)) & 
    
    bitclear : (BYTE * PHYS_BYTE_INDEX) --> BYTE & 
    ! (ww, ii, bb).(ww : BYTE & ii : PHYS_BYTE_INDEX & bb : BIT => bitclear(ww,ii) = bv_clear(ww, ii)) & 
    
    complement : BYTE --> BYTE &
    complement = %(bt).(bt : BYTE | bv_not(bt)) &
    
    
    swap : BYTE --> BYTE &
    swap=%(bt).(bt:BYTE |{1|->bt(5), 2|->bt(6), 3|->bt(7), 4 |->bt(8), 5|->bt(1), 6|->bt(2), 7|->bt(3), 8|->bt(4)}) &
    
    
    rotateleft : BYTE --> BYTE  &
    rotateleft  = %(bv).(bv:BYTE| {1|->bv(8), 2|->bv(1), 3|->bv(2), 4|->bv(3), 5|->bv(4),6|->bv(5),7|->bv(6),8|->bv(7)} ) &
    
    
    rotateright : BYTE --> BYTE  &
    rotateright= %(bv).(bv:BYTE|{1|->bv(2), 2|->bv(3), 3|->bv(4), 4|->bv(5),5|->bv(6), 6|->bv(7), 7|->bv(8), 8|->bv(1)})  &
    
    
    get_upper_digit =%( by ). ( by : BYTE |  pow2_3 * by (8 ) + pow2_2 * by ( 7 ) + 2 * by ( 6 ) +  by ( 5 )   ) &
    get_lower_digit =%( by ). ( by : BYTE |  pow2_3 * by (4 ) + pow2_2 * by ( 3 ) + 2 * by ( 2 ) +  by ( 1 )   )
    
    
ASSERTIONS

    size(BYTE_ZERO) = 8 &
    BYTE <: BIT_VECTOR &
    BYTE_ZERO : BIT_VECTOR &
    first(BYTE_ZERO)=0 &
    
    !(bt).(bt : BYTE => bv_size(bt)=size(bt) & bv_size(bt)=8 & bt : seq1(BIT)  ) &
    
    BYTE_WIDTH : NATURAL &
        
    dom(is_zero)= BYTE &
    ran(is_zero)= BIT  &
    
    dom(parity_even) = BYTE &
    ran(parity_even) = BIT &
    
    dom(and) = BYTE * BYTE &
    ran(and) = BYTE  &
    
    dom(ior) = BYTE * BYTE &	
    ran(ior) = BYTE  &
    
    dom(xor) = BYTE * BYTE &
    ran(xor) = BYTE  &
    
    dom(bitget)=(BYTE * PHYS_BYTE_INDEX) &
    ran(bitget)=BIT &
    
    dom(bitset)=(BYTE * PHYS_BYTE_INDEX) &
    ran(bitset)= BYTE &   
    
    dom(bitclear)=(BYTE * PHYS_BYTE_INDEX)&
    ran(bitclear)= BYTE &
    
    dom(complement) = BYTE &
    ran(complement) = BYTE &
    
    dom(swap) = BYTE &
    ran(swap) = BYTE &
    
    dom(rotateleft) = BYTE &
    ran(rotateleft) = BYTE &
    
    dom(rotateright) = BYTE &
    ran(rotateright) = BYTE &
    
    dom(get_upper_digit ) = BYTE &
    ran(get_upper_digit) = 0..(pow2_4 - 1) &
    
    dom(get_lower_digit ) = BYTE &
    ran(get_lower_digit) = 0..(pow2_4 - 1) &
    
    
    [1,1,1,1,1,1,1,1] : BYTE &  
    [0,0,0,0,0,0,0,0] : BYTE &
    
    
    pow2_0 = 2**0 &
    pow2_1 = 2**1 &
    pow2_2 = 2**2 &
    pow2_3 = 2**3 &
    pow2_4 = 2**4 &
    pow2_5 = 2**5 &
    pow2_6 = 2**6 &
    pow2_7 = 2**7 &
    pow2_8 = 2**8 &
    pow2_9 = 2**9 &    
    pow2_10 = 2**10 &
    pow2_11 = 2**11 &
    pow2_12 = 2**12 &
    pow2_13 = 2**13 &
    pow2_14 = 2**14 &
    pow2_15 = 2**15 &
    pow2_16 = 2**16 
    
    
    
    
END

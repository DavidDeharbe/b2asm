/* Z80Man_bitControl
* Author: valerio
* Creation date: qua dez 3 2008
*/

MACHINE
    Z80Man_bitControl
INCLUDES
    MEMORY
SEES 
    ALU ,
    BIT_DEFINITION ,
    BIT_VECTOR_DEFINITION,
    BYTE_DEFINITION,
    BV16_DEFINITION,
    
    UCHAR_DEFINITION,
    SCHAR_DEFINITION,
    SSHORT_DEFINITION,
    USHORT_DEFINITION,
    POWER2 
SETS
    id_reg_8 = { a0 , f0 , f_0 , a_0 ,
        b0 , c0 , b_0 , c_0 ,
        d0 , e0 , d_0 , e_0 ,
        h0 , l0 , h_0 , l_0 } ;
    id_reg_16 = { BC , DE , HL , SP , AF }        
ABSTRACT_VARIABLES
    rgs8,
    pc , sp , ix , iy ,
    i_,r_ , 
    iff1 , iff2,
    im ,
    io_ports   
INVARIANT
    rgs8 : id_reg_8 --> BYTE &
    pc : INSTRUCTION & sp : BV16 & ix : BV16 & iy : BV16 &
    i_ : BYTE & r_  : BYTE & 
    iff1 : BIT &  iff2 : BIT &
    im : (BIT*BIT) &
    io_ports  : BYTE --> BYTE
DEFINITIONS
    bv_BC == byte_bv16 ( rgs8 ( b0 ) , rgs8 ( c0 ) ) ;
    bv_HL == byte_bv16 ( rgs8 ( h0 ) , rgs8 ( l0 ) ) ;
    bv_DE == byte_bv16 ( rgs8 ( d0 ) , rgs8 ( e0 ) ) ;
    bv_AF == byte_bv16 ( rgs8 ( a0 ) , rgs8 ( f0 ) ) ;
    
    bv_9BC0 == mem ( byte_bv16 ( rgs8 ( b0 ) , rgs8 ( c0 ) ) );
    bv_9DE0 == mem ( byte_bv16 ( rgs8 ( d0 ) , rgs8 ( e0 ) ) );
    bv_9HL0 == mem ( byte_bv16 ( rgs8 ( h0 ) , rgs8 ( l0 ) ) );
    bv_9AF0 == mem ( byte_bv16 ( rgs8 ( a0 ) , rgs8 ( f0 ) ) );
    
    bv_9SP0 == mem ( sp );
    bv_9IX0 == mem ( ix );
    bv_9IY0 == mem ( iy );
    
    sp_plus_one == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , 1 ) );
    sp_plus_two == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , 2 ) );
    sp_minus_one == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , -1 ) );
    sp_minus_two == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , -2 ) );
    
    z_s  == bitget ( rgs8 ( f0 ) , 7 ) ;
    z_z  == bitget ( rgs8 ( f0 ) , 6 ) ;
    z_00 == bitget ( rgs8 ( f0 ) , 5 ) ;
    z_h  == bitget ( rgs8 ( f0 ) , 4 ) ;
    z_01 == bitget ( rgs8 ( f0 ) , 3 ) ;
    z_p  == bitget ( rgs8 ( f0 ) , 2 ) ;
    z_n  == bitget ( rgs8 ( f0 ) , 1 ) ;
    z_c  == bitget ( rgs8 ( f0 ) , 0 )    
CONCRETE_CONSTANTS
    get_bv_reg16 ,
    REG16_TO_REG8 ,
    REG8_TO_REG16 ,
    
    update_flag_register_SZ_H_PvNC ,
    get_new_flag_register_SZ_H_PvNC ,
    
    bv_ireg_plus_d ,
    bv_9ireg_plus_d0,
    
    cc_get
PROPERTIES
    
    
    get_bv_reg16 : ( BV16 * ( id_reg_8 --> BYTE ) * id_reg_16 ) --> ( BV16 )
    & ! ( sp_ , rgs8_ , r1 ) .
    ( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 : id_reg_16
        => ( r1 = BC =>  get_bv_reg16 ( sp_ , rgs8_ , r1 ) = byte_bv16 ( rgs8_ ( b0 ) , rgs8_ ( c0 ) ) ) &
        ( r1 = DE =>  get_bv_reg16 ( sp_ , rgs8_ , r1 ) = byte_bv16 ( rgs8_ ( d0 ) , rgs8_ ( e0 ) ) ) &
        ( r1 = HL =>  get_bv_reg16 ( sp_ , rgs8_ , r1 ) = byte_bv16 ( rgs8_ ( h0 ) , rgs8_ ( l0 ) ) ) &
        ( r1 = SP =>  get_bv_reg16 ( sp_ , rgs8_ , r1 ) = sp_ ) &
        ( r1 = AF =>  get_bv_reg16 ( sp_ , rgs8_ , r1 ) = byte_bv16 ( rgs8_ ( a0 ) , rgs8_ ( f0 ) ) )
    ) &
    
    
    REG16_TO_REG8 : id_reg_16 --> ( id_reg_8 * id_reg_8 ) &
    REG16_TO_REG8 ( BC ) = ( b0 , c0 )  &
    REG16_TO_REG8 ( DE ) = ( d0 , e0 )  &
    REG16_TO_REG8 ( HL ) = ( h0 , l0 )  &
    REG16_TO_REG8 ( AF ) = ( a0 , f0 ) 
    
    &
    REG8_TO_REG16 = REG16_TO_REG8 ~ &
    
    update_flag_register_SZ_H_PvNC = % ( rgs8_ , s7 , z6 , h4 , pv2 , n_add_sub , c0 ) .
    ( rgs8_ : id_reg_8 --> BYTE & s7 : BIT & z6  : BIT &   h4 : BIT  & pv2 : BIT & n_add_sub : BIT & c0 : BIT |
        rgs8_ <+ { ( f0 |-> {
                    /*S*/         ( 7 |-> s7 ) ,
                    /*Z*/         ( 6 |-> z6 ) ,
                    /*(5 |-> rgs8_(f0)(5) ),*/
                    /*H*/         ( 4 |-> h4 ) ,
                    /*(3 |-> rgs8_(f0)(3) ),*/
                    /*P/V*/       ( 2 |-> pv2 ) ,
                    /*N*/         ( 1 |-> n_add_sub ) ,
                    /*C*/         ( 0 |-> c0 ) } ) } )
    
    &
    
    get_new_flag_register_SZ_H_PvNC = % ( s7 , z6 , h4 , pv2 , n_add_sub , c0 ) .
    (  s7 : BIT & z6  : BIT &   h4 : BIT  & pv2 : BIT & n_add_sub : BIT & c0 : BIT |
        ( f0 |-> {
                /*S*/         ( 7 |-> s7 ) ,
                /*Z*/         ( 6 |-> z6 ) ,
                /*(5 |-> rgs8_(f0)(5) ),*/
                /*H*/         ( 4 |-> h4 ) ,
                /*(3 |-> rgs8_(f0)(3) ),*/
                /*P/V*/       ( 2 |-> pv2 ) ,
                /*N*/         ( 1 |-> n_add_sub ) ,
                /*C*/         ( 0 |-> c0 ) } ) ) &
    
    bv_ireg_plus_d = % ( ix_iy , desloc ) . ( ix_iy : BV16 & desloc : SCHAR |
        ushort_bv16 ( (bv16_ushort ( ix_iy ) + desloc ) mod 65536 ) ) &
    
    bv_9ireg_plus_d0 = % ( mem , ix_iy , desloc ) . ( mem : ( BV16 --> BYTE ) & ix_iy : BV16 & desloc : SCHAR |
        mem ( bv_ireg_plus_d(ix_iy , desloc) ) ) &
    
    cc_get : ( (id_reg_8 --> BYTE) * (0..8) ) --> BIT &
    !(rgs8_).(rgs8_ : id_reg_8 --> BYTE => 	 cc_get(rgs8_ , 0) = 1 - bitget ( rgs8_ ( f0 ) , 6 )   &
        cc_get(rgs8_ , 1) =  bitget ( rgs8_ ( f0 ) , 6 )   &
        cc_get(rgs8_ , 2) =  1 - bitget ( rgs8_ ( f0 ) , 0 )   &
        cc_get(rgs8_ , 3) =   bitget ( rgs8_ ( f0 ) , 0 )   &
        cc_get(rgs8_ , 4) =  1 - bitget ( rgs8_ ( f0 ) , 2 )   &
        cc_get(rgs8_ , 5) =   bitget ( rgs8_ ( f0 ) , 2 )   & 
        cc_get(rgs8_ , 6) =  1 - bitget ( rgs8_ ( f0 ) , 7 )   & 
        cc_get(rgs8_ , 7) =  bitget ( rgs8_ ( f0 ) , 7 )   )
    
ASSERTIONS
    ran ( mem ) <: BYTE &
    dom ( mem ) = BV16 &
    ran ( rgs8 ) <: BYTE &
    dom ( rgs8 ) = id_reg_8 &
    instruction_next ( 0 ) = 1 &
    instruction_next ( 1 ) = 2 &
    instruction_next ( 2 ) = 3 &
    instruction_next ( 3 ) = 4 &
    instruction_next ( 4 ) = 5 &
    instruction_next ( 5 ) = 6 &
    instruction_next ( 6 ) = 7 &
    instruction_next ( 7 ) = 8 &
    instruction_next ( 8 ) = 9 &
    instruction_next ( 9 ) = 10 &
    instruction_next ( 10 ) = 11 &
    instruction_next ( 11 ) = 12 &
    instruction_next ( 12 ) = 13 &
    instruction_next ( 13 ) = 14 &
    
    bv_9BC0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9BC0 ) ) : BYTE &
    bv_9DE0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9DE0 ) ) : BYTE &
    bv_9HL0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9HL0 ) ) : BYTE &
    bv_9AF0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9AF0 ) ) : BYTE &
    
    bv_9SP0 : BYTE  &
    bv_9IX0 : BYTE  &
    bv_9IY0 : BYTE &
    
    ! ( ii , des ) . ( ii : BV16 & des : SCHAR => bv_ireg_plus_d ( ii , des ) : BV16 ) &
    
    ! ( mmm , ii , des ) . ( mmm : BV16 >-> BYTE & ii : BV16 & des : SCHAR => bv_9ireg_plus_d0 ( mmm , ii , des ) : BYTE )
    
INITIALISATION
    
    rgs8 := { (a0 |-> uchar_byte(255)) , (f0 |-> uchar_byte(255)) , (f_0 |-> uchar_byte(255)) , (a_0 |-> uchar_byte(255)) ,
        (b0 |-> uchar_byte(255)) , (c0 |-> uchar_byte(255)) , (b_0 |-> uchar_byte(255)) , (c_0 |-> uchar_byte(255)) ,
        (d0 |-> uchar_byte(255)) , (e0 |-> uchar_byte(255)) , (d_0 |-> uchar_byte(255)) , (e_0 |-> uchar_byte(255)) ,
        (h0 |-> uchar_byte(255)) , (l0 |-> uchar_byte(255)) , (h_0 |-> uchar_byte(255)) , (l_0 |-> uchar_byte(255)) } ||
    
    pc := 0 || sp := ushort_bv16(65535) || ix := ushort_bv16(65535) || iy := ushort_bv16(65535) ||
    i_ :=uchar_byte(0) || r_  :=uchar_byte(0) || 
    io_ports  :: (BYTE --> {uchar_byte(0)}) ||
    iff1 :=0  ||  iff2 :=0 ||
    im := (0|->0)
    
OPERATIONS
    
    /************************************************************************************** 
    ***  			Rotate and Shift Group pg. 190
    **************************************************************************************/
    
    RLCA =
    BEGIN
        rgs8 := rgs8 <+ { a0 |->rotateleft(rgs8(a0)) , 
            get_new_flag_register_SZ_H_PvNC(z_s,z_z,0,z_p,0,bitget(rgs8(a0),7) )   }||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        
    END;
    
    
    RLA =
    BEGIN
        rgs8 := rgs8 <+ { a0 |-> (rotateleft(rgs8(a0)) <+ {(0|-> z_c)} ), 
            get_new_flag_register_SZ_H_PvNC(z_s,z_z,0,z_p,0,bitget(rgs8(a0),7) )   }||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        
    END;
    
    
    RRCA =
    BEGIN
        rgs8 := rgs8 <+ { a0 |-> rotateright(rgs8(a0)) , 
            get_new_flag_register_SZ_H_PvNC(z_s,z_z,0,z_p,0,bitget(rgs8(a0),0) )   }||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        
    END;
    
    
    RRA =
    BEGIN
        rgs8 := rgs8 <+ { a0 |-> (rotateright(rgs8(a0))<+ {(0|-> z_c)} ), 
            get_new_flag_register_SZ_H_PvNC(z_s,z_z,0,z_p,0,bitget(rgs8(a0),0) )   }||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        
    END;
    
    RLC_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = rotateleft(rgs8(rr)) THEN
            
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),7) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RLC_9HL0 =
    PRE bv16_ushort( bv_HL )  : DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = rotateleft( bv_9HL0 ) THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(  is_negative(res), is_zero(res),0,
                    parity_even_BYTE(res) ,0,bitget(bv_9HL0,7) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    RLC_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort ( bv_ireg_plus_d(ix,desloc)) :  DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = rotateleft( bv_9ireg_plus_d0(mem,ix,desloc) ) THEN         
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RLC_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort (bv_ireg_plus_d(iy,desloc)) :  DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = rotateleft( bv_9ireg_plus_d0(mem,iy,desloc) ) THEN         
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    
    
    RL_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = (rotateleft(rgs8(rr))<+ {(0|-> z_c)} ) THEN
            
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),7) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RL_9HL =
    PRE bv16_ushort (bv_HL) :  DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateleft( bv_9HL0 )<+ {( 0 |-> z_c)} ) THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,7) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END	;
    
    
    RL_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) :  DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = (rotateleft( bv_9ireg_plus_d0(mem,ix,desloc) ) <+ {(0|-> z_c)} ) 			THEN
            
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0, bitget(bv_9ireg_plus_d0(mem,ix,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RL_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) :  DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = (rotateleft( bv_9ireg_plus_d0(mem,iy,desloc) )<+ {(0|-> z_c)} ) 		
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RRC_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = rotateright(rgs8(rr)) THEN
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),0) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RRC_9HL0 =
    PRE bv16_ushort(bv_HL) :  DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = rotateright( bv_9HL0 ) THEN
            
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,0) )   }||
            
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    RRC_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) :  DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = rotateright( bv_9ireg_plus_d0(mem,ix,desloc) ) THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RRC_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) :  DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = rotateright( bv_9ireg_plus_d0(mem,iy,desloc) ) THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RR_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = (rotateright(rgs8(rr))<+ {(0|-> z_c)} ) THEN
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),0) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RR_9HL =
    PRE bv16_ushort(bv_HL) : STACK_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9HL0 )<+ {(0|-> z_c)} ) THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,0) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    RR_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9ireg_plus_d0(mem,ix,desloc) ) <+ {(0|-> z_c)} ) 			THEN
            
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RR_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9ireg_plus_d0(mem,iy,desloc) )<+ {(0|-> z_c)} ) 		
        THEN            
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SLA_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = (rotateright(rgs8(rr))<+ {(0|-> z_c)} ) THEN
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),7) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SLA_9HL =
    PRE  bv16_ushort(bv_HL) : STACK_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9HL0 )<+ {(0|-> z_c)} ) THEN      
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,7) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    SLA_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9ireg_plus_d0(mem,ix,desloc) ) <+ {(0|-> z_c)} ) 			THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SLA_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9ireg_plus_d0(mem,iy,desloc) )<+ {(0|-> z_c)} ) 		
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),7) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRA_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = (rotateright(rgs8(rr))) <+ {7|-> bitget(rgs8(rr),7)}  THEN
            
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),0) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRA_9HL0 =
    PRE  bv16_ushort(bv_HL) : DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = (rotateright( bv_9HL0 )) <+ {7|-> bv_9HL0(7)}  THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,0) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRA_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & 
            res = (rotateright( bv_9ireg_plus_d0(mem,ix,desloc) ))<+ 
            {7 |-> bitget(bv_9ireg_plus_d0(mem,ix,desloc),7) }
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRA_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & 
            res = rotateright( bv_9ireg_plus_d0(mem,iy,desloc) ) <+
            {7 |-> bv_9ireg_plus_d0(mem,iy,desloc)(7) }
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(res), is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRL_r(rr) =
    PRE rr : id_reg_8 THEN
        ANY res WHERE res : BYTE & res = bitclear(rotateright(rgs8(rr)),7)  THEN
            rgs8 := rgs8 <+ { rr |-> res, 
                get_new_flag_register_SZ_H_PvNC(
                    0, is_zero(res),0, parity_even_BYTE(res) ,0,bitget(rgs8(rr),0) )   }||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRL_9HL0 =
    PRE  bv16_ushort(bv_HL) : DATA_R_ADR  THEN
        ANY res WHERE res : BYTE & res = bitclear(rotateright( bv_9HL0 ),7)  THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    0, is_zero(res),0, parity_even_BYTE(res) ,0,bitget(bv_9HL0,0) )   }||
            updateAddressMem(bv_HL, res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    SRL_9IX_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR  THEN 
        ANY res WHERE res : BYTE & 
            res = bitclear(rotateright( bv_9ireg_plus_d0(mem,ix,desloc) ),7)
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    0, is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,ix,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(ix,desloc), res ) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    SRL_9IY_d9(desloc) =
    PRE desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR  THEN 
        ANY res WHERE res : BYTE & 
            res = bitclear(rotateright( bv_9ireg_plus_d0(mem,iy,desloc) ),7)
        THEN          
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    0, is_zero(res),0, parity_even_BYTE(res),
                    0,bitget(bv_9ireg_plus_d0(mem,iy,desloc),0) )   }||            
            updateAddressMem(bv_ireg_plus_d(iy,desloc), res )  ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END	
    END;
    
    
    RLD=
    PRE bv16_ushort(bv_HL) : DATA_R_ADR THEN
        ANY res, acc WHERE res : BYTE & acc : BYTE &
            res =  { 7|->bitget(bv_9HL0,3), 6|->bitget(bv_9HL0,2), 5|->bitget(bv_9HL0,1), 
                4|->bitget(bv_9HL0,0),
                3|->bitget(rgs8(a0),3),   2|->bitget(rgs8(a0),2), 1|->bitget(rgs8(a0),1),
                0|->bitget(rgs8(a0),0)	} &
            acc = rgs8(a0) <+ { 3|->bitget(bv_9HL0,7),   2|->bitget(bv_9HL0,6), 
                1|->bitget(bv_9HL0,5),	0|->bitget(bv_9HL0,4)  }
            
        THEN
            
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC(
                    is_negative(acc), is_zero(acc),0, parity_even_BYTE(acc),
                    0,z_c )   }||            
            updateAddressMem(bv_HL, res ) 
            || pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    RRD=
    PRE bv16_ushort(bv_HL) : DATA_R_ADR THEN
        ANY res, acc WHERE res : BYTE & acc : BYTE &
            res =  { 7|->bitget(rgs8(a0),3),   6|->bitget(rgs8(a0),2), 5|->bitget(rgs8(a0),1),
                4|->bitget(rgs8(a0),0),
                3|->bitget(bv_9HL0,7), 2|->bitget(bv_9HL0,6), 1|->bitget(bv_9HL0,5), 
                0|->bitget(bv_9HL0,4)} &
            acc = rgs8(a0) <+ { 3|->bitget(bv_9HL0,3),   2|->bitget(bv_9HL0,2), 
                1|->bitget(bv_9HL0,1),	0|->bitget(bv_9HL0,0)  }
            
        THEN
            rgs8 := rgs8 <+ { get_new_flag_register_SZ_H_PvNC( is_negative(acc), is_zero(acc),0, parity_even_BYTE(acc), 0 ,z_c )   }||            
            updateAddressMem(bv_HL,res) 
            || pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    /************************************************************************************** 
    ***  			BIT Manipulation  Group
    **************************************************************************************/
    
    BIT_b_rr (bb,rr) =
    PRE bb : 0..7& rr : id_reg_8 THEN
        rgs8 := update_flag_register_SZ_H_PvNC(rgs8, z_s, bit_not( bitget( rgs8(rr),bb) ), 1,z_p,0,z_c)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    BIT_b_9HL0 (bb) =  
    PRE bb : 0..7 THEN
        rgs8 := update_flag_register_SZ_H_PvNC(rgs8, z_s, bit_not( bv_9HL0(bb) ), 1,z_p,0,z_c)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    BIT_b_9IX_d0 (desloc, bb) =  
    PRE bb : 0..7 & desloc : SCHAR THEN
        rgs8 := update_flag_register_SZ_H_PvNC(rgs8, z_s, bit_not( bv_9ireg_plus_d0(mem,ix,desloc)(bb) ), 1,z_p,0,z_c)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    BIT_b_9IY_d0 (desloc, bb) =  
    PRE bb : 0..7 & desloc : SCHAR THEN
        rgs8 := update_flag_register_SZ_H_PvNC(rgs8, z_s, bit_not( bv_9ireg_plus_d0(mem,iy,desloc)(bb) ), 1,z_p,0,z_c)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    SET_b_r(bb,rr)=
    PRE bb  : 0..7 & rr : id_reg_8 THEN
        rgs8(rr):= bitset(rgs8(rr),bb) 	||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    
    SET_b_9HL0(bb)=
    PRE bb  : 0..7 & bv16_ushort(bv_HL) : DATA_R_ADR THEN
        updateAddressMem(bv_HL, bv_set(bv_9HL0,bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    SET_b_9IX_d0(bb,desloc)=
    PRE bb  : 0..7 & desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR THEN
        updateAddressMem(bv_ireg_plus_d(ix,desloc), bv_set(bv_9ireg_plus_d0(mem,ix,desloc),bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    SET_b_9IY_d0(bb,desloc)=
    PRE bb  : 0..7 & desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR THEN
        updateAddressMem(bv_ireg_plus_d(iy,desloc), bv_set(bv_9ireg_plus_d0(mem,iy,desloc),bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    
    RES_b_r(bb,rr)=
    PRE bb  : 0..7 & rr : id_reg_8 THEN
        rgs8(rr):= bv_clear(rgs8(rr),bb) 	 ||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)       
    END;
    
    
    RES_b_9HL0(bb)=
    PRE bb  : 0..7 & bv16_ushort(bv_HL) : DATA_R_ADR THEN
        updateAddressMem(bv_HL, bv_clear(bv_9HL0,bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    RES_b_9IX_d0(bb,desloc)=
    PRE bb  : 0..7 & desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(ix,desloc)) : DATA_R_ADR THEN
        updateAddressMem(bv_ireg_plus_d(ix,desloc), bv_clear(bv_9ireg_plus_d0(mem,ix,desloc),bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    RES_b_9IY_d0(bb,desloc)=
    PRE bb  : 0..7 & desloc : SCHAR & bv16_ushort(bv_ireg_plus_d(iy,desloc)) : DATA_R_ADR THEN
        updateAddressMem(bv_ireg_plus_d(iy,desloc), bv_clear(bv_9ireg_plus_d0(mem,iy,desloc),bb))||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)    
    END;
    
    /************************************************************************************** 
    ***  			JUMP GROUP
    **************************************************************************************/
    
    JP_nn(nn)=
    PRE nn : USHORT THEN
        pc:= nn || r_ := update_refresh_reg(r_)    
    END;
    
    JP_cc_nn(cc,nn)=
    PRE cc : BOOL & nn : USHORT THEN
        IF	cc = TRUE THEN    pc:= nn
        ELSE pc := instruction_next(pc) END  
        || r_ := update_refresh_reg(r_)    
    END;
    
    JR_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        pc := (pc + ee) mod 2**16 || r_ := update_refresh_reg(r_)    
    END;
    
    JR_C_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        IF z_c = 0 THEN		 pc := instruction_next(pc) 
        ELSE pc := (pc + ee) mod 2**16 END
        || r_ := update_refresh_reg(r_)    
    END;
    
    
    JR_NC_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        IF z_c = 1 THEN		 pc := instruction_next(pc) 
        ELSE pc := (pc + ee) mod 2**16 END
        || r_ := update_refresh_reg(r_)    
    END;
    
    JR_Z_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        IF z_z = 0 THEN		 pc := instruction_next(pc) 
        ELSE pc := (pc + ee) mod 2**16 END
        || r_ := update_refresh_reg(r_)    
    END;
    
    JR_NZ_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        IF z_z = 1 THEN		 pc := instruction_next(pc) 
        ELSE pc := (pc + ee) mod 2**16 END
        || r_ := update_refresh_reg(r_)    
    END;
    
    JP_HL=
    BEGIN
        pc := bv16_ushort(bv_HL) || r_ := update_refresh_reg(r_)    
    END;
    
    JP_IX=
    BEGIN
        pc := bv16_ushort( ix)  || r_ := update_refresh_reg(r_)    
    END;
    
    JP_IY=
    BEGIN
        pc :=  bv16_ushort( iy) || r_ := update_refresh_reg(r_)    
    END;
    
    DJNZ_e(ee)=
    PRE ee : SCHAR & ee-2 : SCHAR THEN
        
        rgs8(b0):=	dec_BYTE(rgs8(b0))||
        
        IF is_zero(dec_BYTE(rgs8(b0))) = 1 THEN		 pc := instruction_next(pc)
        ELSE pc := (pc + ee) mod 2**16 END || r_ := update_refresh_reg(r_)    
        
    END;
    
    /************************************************************************************** 
    ***  			CALL and RETURN GROUP
    **************************************************************************************/
    
    CALL_nn (nn) =
    PRE nn : USHORT & bv16_ushort(sp_minus_two) : STACK_R_ADR  &  bv16_ushort(sp) : STACK_R_ADR THEN
        ANY high,low WHERE high : BYTE & low : BYTE & ( high , low ) = bv16_byte(ushort_bv16(pc))
        THEN
            updateStack( { mem( sp_minus_one) |-> high, mem(sp_minus_two) |-> low } ) ||
            sp := sp_minus_two ||
            pc := nn   
        END
    END;
    
    
    CALL_cc_nn (cc,nn) =
    PRE cc : 0..8 & nn : USHORT & bv16_ushort(sp_minus_two) : STACK_R_ADR  &  bv16_ushort(sp) : STACK_R_ADR THEN
        ANY high,low WHERE high : BYTE & low : BYTE &  ( high , low ) = bv16_byte(ushort_bv16(pc)) 
        THEN
            IF cc_get(rgs8,cc) = 1 THEN
                updateStack( { mem( sp_minus_one) |-> high, mem(sp_minus_two) |-> low } ) ||
                sp := sp_minus_two ||
                pc := nn 
            ELSE 
                pc := instruction_next(pc)
            END
            || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    RET = 
    BEGIN
        pc := bv16_ushort(  byte_bv16( mem(sp_plus_one) , bv_9SP0 )) || sp := sp_plus_two || r_ := update_refresh_reg(r_) 
    END;
    
    
    RET_cc(cc) =
    PRE cc : 0..7 THEN
        IF  cc_get(rgs8,cc) = 1 THEN       pc := bv16_ushort(  byte_bv16( mem(sp_plus_one) , bv_9SP0 )) || sp := sp_plus_two 
        ELSE pc := instruction_next(pc) END
        || r_ := update_refresh_reg(r_) 
    END;
    
    
    RETI = 
    BEGIN
        pc := bv16_ushort(  byte_bv16( mem(sp_plus_one) , bv_9SP0 )) || sp := sp_plus_two || r_ := update_refresh_reg(r_) 
    END;
    
    
    RETN = 
    BEGIN
        pc := bv16_ushort(  byte_bv16( mem(sp_plus_one) , bv_9SP0 )) ||
        sp := sp_plus_two || r_ := update_refresh_reg(r_) || iff1:= iff2
    END;
    
    
    RST_p(pp) = 
    PRE pp : 0..7 &  bv16_ushort(sp_minus_two) : STACK_R_ADR  &  bv16_ushort(sp) : STACK_R_ADR  THEN
        ANY pc_l, pc_h WHERE pc_l : BYTE & pc_h : BYTE & bv16_byte(ushort_bv16(pc))= (pc_l,pc_h) 
        THEN 
            updateStack( { mem( sp_minus_one) |-> pc_h, mem(sp_minus_two) |-> pc_l } ) ||
            sp := sp_minus_two || pc := pp*8    || r_ := update_refresh_reg(r_) 
        END
    END
    
    
    
    
    
END

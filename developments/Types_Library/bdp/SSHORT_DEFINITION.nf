Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(SSHORT_DEFINITION))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(SSHORT_DEFINITION))==(Machine(SSHORT_DEFINITION));
  Level(Machine(SSHORT_DEFINITION))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(SSHORT_DEFINITION)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(SSHORT_DEFINITION))==(BV16_DEFINITION,SCHAR_DEFINITION)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(SSHORT_DEFINITION))==(?);
  List_Includes(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(SSHORT_DEFINITION))==(?);
  Context_List_Variables(Machine(SSHORT_DEFINITION))==(?);
  Abstract_List_Variables(Machine(SSHORT_DEFINITION))==(?);
  Local_List_Variables(Machine(SSHORT_DEFINITION))==(?);
  List_Variables(Machine(SSHORT_DEFINITION))==(?);
  External_List_Variables(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?);
  Abstract_List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?);
  External_List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?);
  Expanded_List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?);
  List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?);
  Internal_List_VisibleVariables(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  Gluing_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  Expanded_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  Abstract_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  Context_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  List_Invariant(Machine(SSHORT_DEFINITION))==(btrue)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(SSHORT_DEFINITION))==(btrue);
  Abstract_List_Assertions(Machine(SSHORT_DEFINITION))==(btrue);
  Context_List_Assertions(Machine(SSHORT_DEFINITION))==(BV16_ZERO: BV16 & BV16 <: BIT_VECTOR & BV16_ZERO: BIT_VECTOR & (2**7-1: INTEGER;(-2)**7: INTEGER));
  List_Assertions(Machine(SSHORT_DEFINITION))==((-2)**15: NATURAL;2**15-1: NATURAL;(-2)**15: SSHORT;2**15-1: SSHORT)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(SSHORT_DEFINITION))==(skip);
  Context_List_Initialisation(Machine(SSHORT_DEFINITION))==(skip);
  List_Initialisation(Machine(SSHORT_DEFINITION))==(skip)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(SSHORT_DEFINITION),Machine(BV16_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(SSHORT_DEFINITION),Machine(SCHAR_DEFINITION))==(?)
END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(SSHORT_DEFINITION))==(btrue);
  List_Constraints(Machine(SSHORT_DEFINITION))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(SSHORT_DEFINITION))==(?);
  List_Operations(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListInputX END
&
THEORY ListOutputX END
&
THEORY ListHeaderX END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX END
&
THEORY ListSubstitutionX END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(SSHORT_DEFINITION))==(SSHORT,bv16_sshort,sshort_bv16,schar_sshort,sshort_schar);
  Inherited_List_Constants(Machine(SSHORT_DEFINITION))==(?);
  List_Constants(Machine(SSHORT_DEFINITION))==(SSHORT,bv16_sshort,sshort_bv16,schar_sshort,sshort_schar)
END
&
THEORY ListSetsX IS
  Context_List_Enumerated(Machine(SSHORT_DEFINITION))==(?);
  Context_List_Defered(Machine(SSHORT_DEFINITION))==(?);
  Context_List_Sets(Machine(SSHORT_DEFINITION))==(?);
  List_Valuable_Sets(Machine(SSHORT_DEFINITION))==(?);
  Inherited_List_Enumerated(Machine(SSHORT_DEFINITION))==(?);
  Inherited_List_Defered(Machine(SSHORT_DEFINITION))==(?);
  Inherited_List_Sets(Machine(SSHORT_DEFINITION))==(?);
  List_Enumerated(Machine(SSHORT_DEFINITION))==(?);
  List_Defered(Machine(SSHORT_DEFINITION))==(?);
  List_Sets(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(SSHORT_DEFINITION))==(?);
  Expanded_List_HiddenConstants(Machine(SSHORT_DEFINITION))==(?);
  List_HiddenConstants(Machine(SSHORT_DEFINITION))==(?);
  External_List_HiddenConstants(Machine(SSHORT_DEFINITION))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(SSHORT_DEFINITION))==(btrue);
  Context_List_Properties(Machine(SSHORT_DEFINITION))==(BV16_INDX = 1..16 & REAL_BV16_INDX = 0..16-1 & BV16 = {bt | bt: BIT_VECTOR & bv_size(bt) = 16} & BV16_ZERO = BV16_INDX*{0} & bv16_byte: BV16 --> BYTE*BYTE & bv16_byte = %bv.(bv: BV16 | {0|->bv(8),1|->bv(9),2|->bv(10),3|->bv(11),4|->bv(12),5|->bv(13),6|->bv(14),7|->bv(15)},{0|->bv(0),1|->bv(1),2|->bv(2),3|->bv(3),4|->bv(4),5|->bv(5),6|->bv(6),7|->bv(7)}) & byte_bv16 = bv16_byte~ & bv16_bit_get: BYTE*BV16_INDX --> BIT & byte_bit_get = %(bt,ind).(bt: BYTE & ind: REAL_BYTE_INDEX | bt(ind+1)) & SCHAR = (-2)**7..2**7-1 & byte_schar: BYTE --> SCHAR & byte_schar = %v0.(v0: BYTE | (-2)**7*v0(7)+2**6*v0(6)+2**5*v0(5)+2**4*v0(4)+2**3*v0(3)+2**2*v0(2)+2*v0(1)+v0(0)) & schar_byte: SCHAR --> BYTE & schar_byte = byte_schar~ & uchar_schar: UCHAR --> SCHAR & uchar_schar = %v1.(v1: UCHAR & v1<=2**7-1 | v1) & uchar_schar = %v1.(v1: UCHAR & not(v1<=2**7-1) | v1-UCHAR_MAX+1) & schar_uchar: SCHAR --> UCHAR & schar_uchar = uchar_schar~);
  Inherited_List_Properties(Machine(SSHORT_DEFINITION))==(btrue);
  List_Properties(Machine(SSHORT_DEFINITION))==(SSHORT = (-2)**15..2**15-1 & bv16_sshort: BV16 --> SSHORT & bv16_sshort = %v0.(v0: BV16 | (-2)**15*v0(15)+2**14*v0(14)+2**13*v0(13)+2**12*v0(12)+2**11*v0(11)+2**10*v0(10)+2**9*v0(9)+2**8*v0(8)+2**7*v0(7)+2**6*v0(6)+2**5*v0(5)+2**4*v0(4)+2**3*v0(3)+2**2*v0(2)+2*v0(1)+v0(0)) & sshort_bv16: SSHORT --> BV16 & sshort_bv16 = bv16_sshort~ & schar_sshort: SCHAR*SCHAR --> SSHORT & schar_sshort = %(w1,w2).(w1: SCHAR & w2: SCHAR | bv16_sshort(byte_bv16(schar_byte(w1),schar_byte(w2)))) & sshort_schar: SSHORT --> SCHAR*SCHAR & sshort_schar = schar_sshort~)
END
&
THEORY ListSeenInfoX IS
  Seen_Internal_List_Operations(Machine(SSHORT_DEFINITION),Machine(SCHAR_DEFINITION))==(?);
  Seen_Context_List_Enumerated(Machine(SSHORT_DEFINITION))==(?);
  Seen_Context_List_Invariant(Machine(SSHORT_DEFINITION))==(btrue);
  Seen_Context_List_Assertions(Machine(SSHORT_DEFINITION))==(!bb.(bb: BIT => bit_not(bb) = 1-bb) & bit_not(0) = 1 & bit_not(1) = 0 & !bb.(bb: BIT => bit_not(bit_not(bb)) = bb) & bit_and(0,0) = 0 & bit_and(0,1) = 0 & bit_and(1,0) = 0 & bit_and(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_and(b1,b2) = bit_and(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 1 => bit_and(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 0 => bit_and(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_and(b1,bit_and(b2,b3)) = bit_and(bit_and(b1,b2),b3)) & !b1.(b1: BIT => bit_and(b1,1) = b1) & !b1.(b1: BIT => bit_and(b1,0) = 0) & bit_or(0,0) = 0 & bit_or(0,1) = 1 & bit_or(1,0) = 1 & bit_or(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_or(b1,b2) = bit_or(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 1 => bit_or(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 0 => bit_or(b2,b1) = 0) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 1 => b1 = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 0 => b1 = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_or(b1,bit_or(b2,b3)) = bit_or(bit_or(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = 1) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = bit_or(1,b3)) & !b1.(b1: BIT => bit_or(b1,1) = 1) & !b1.(b1: BIT => bit_or(b1,0) = b1) & !b1.(b1: BIT => bit_or(1,b1) = 1) & !b1.(b1: BIT => bit_or(0,b1) = b1) & bit_xor(0,0) = 0 & bit_xor(0,1) = 1 & bit_xor(1,0) = 1 & bit_xor(1,1) = 0 & !(b1,b2).(b1: BIT & b2: BIT => bit_xor(b1,b2) = bit_xor(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 1 => bit_xor(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 0 => bit_xor(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(bit_xor(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_xor(b1,b2) = 1 => bit_xor(b1,bit_xor(b2,b3)) = 1) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_xor(b1,b2) = 1 => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(1,b3)) & !bb.(bb: BIT => bit_xor(bb,bb) = 0) & bool_to_bit(TRUE) = 1 & bool_to_bit(FALSE) = 0 & !bb.(bb: BIT => bb = 0 or bb = 1) & !bb.(bb: BIT & not(bb = 0) => bb = 1) & !bb.(bb: BIT & not(bb = 1) => bb = 0) & (!bv.(bv: BIT_VECTOR => bv_size(bv_not(bv)) = bv_size(bv));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_not(bv_not(bv)),indx) = bv_get(bv,indx));!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR => bv_size(bv_catenate(v1,v2)) = bv_size(v1)+bv_size(v2));!(bv,low,high).(bv: BIT_VECTOR & low: 0..bv_size(bv)-1 & high: 0..bv_size(bv)-1 & low<=high => bv_size(bv_sub(bv,low,high)) = high-low);!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) => bv_size(bv_and(v1,v2)) = bv_size(v2));!(v1,v2,indx).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) & indx: 0..bv_size(v1)-1 => bv_get(bv_and(v1,v2),indx) = bv_get(bv_and(v2,v1),indx));!(v1,v2,v3,indx).(v1: BIT_VECTOR & v2: BIT_VECTOR & v3: BIT_VECTOR & bv_size(v1) = bv_size(v2) & bv_size(v1) = bv_size(v3) & indx: 0..bv_size(v1)-1 => bv_get(bv_and(v1,bv_and(v2,v3)),indx) = bv_get(bv_and(bv_and(v1,v2),v3),indx));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_and(bv,bv_zero(bv_size(bv))),indx) = bv_get(bv_zero(bv_size(bv)),indx));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_and(bv,bv_one(bv_size(bv))),indx) = bv_get(bv,indx));!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) => bv_size(bv_or(v1,v2)) = bv_size(v1));!(v1,v2,indx).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) & indx: 0..bv_size(v1)-1 => bv_get(bv_or(v1,v2),indx) = bv_get(bv_or(v2,v1),indx));!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) => bv_size(bv_or(v1,v2)) = bv_size(v2));!(v1,v2,v3,indx).(v1: BIT_VECTOR & v2: BIT_VECTOR & v3: BIT_VECTOR & bv_size(v1) = bv_size(v2) & bv_size(v1) = bv_size(v3) & indx: 0..bv_size(v1)-1 => bv_get(bv_or(v1,bv_or(v2,v3)),indx) = bv_get(bv_or(bv_or(v1,v2),v3),indx));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_or(bv,bv_one(bv_size(bv))),indx) = bv_get(bv_one(bv_size(bv)),indx));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_or(bv,bv_zero(bv_size(bv))),indx) = bv_get(bv,indx));!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) => bv_size(bv_xor(v1,v2)) = bv_size(v1));!(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) => bv_size(bv_xor(v1,v2)) = bv_size(v2));!(v1,v2,indx).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) & indx: 0..bv_size(v1)-1 => bv_get(bv_xor(v1,v2),indx) = bv_get(bv_xor(v2,v1),indx));!(bv,indx).(bv: BIT_VECTOR & indx: 0..bv_size(bv)-1 => bv_get(bv_xor(bv,bv),indx) = bv_get(bv_zero(bv_size(bv)),indx))) & !bt.(bt: BYTE => size(bt) = 8) & size(BYTE_ZERO) = 8 & BYTE <: BIT_VECTOR & BYTE_ZERO: BIT_VECTOR & first(BYTE_ZERO) = 0 & 8: NATURAL);
  Seen_Context_List_Properties(Machine(SSHORT_DEFINITION))==(BIT = 0..1 & bit_not: BIT --> BIT & bit_not = %bb.(bb: BIT | 1-bb) & bit_and: BIT*BIT --> BIT & !(b1,b2).(b1: BIT & b2: BIT => bit_and(b1,b2) = 1 <=> (b1 = 1) & b2 = 1) & bit_or: BIT*BIT --> BIT & !(b1,b2).(b1: BIT & b2: BIT => bit_or(b1,b2) = 1 <=> (b1 = 1) or b2 = 1) & bit_xor: BIT*BIT --> BIT & !(b1,b2).(b1: BIT & b2: BIT => bit_xor(b1,b2) = 1 <=> b1/=b2) & bool_to_bit: BOOL --> BIT & bool_to_bit = {TRUE|->1,FALSE|->0} & BIT_VECTOR = seq1(BIT) & bv_size: BIT_VECTOR --> NATURAL1 & bv_size = %bv.(bv: BIT_VECTOR | size(bv)) & bv_size: BIT_VECTOR --> NATURAL1 & bv_size = %bv.(bv: BIT_VECTOR | size(bv)) & bv_catenate: BIT_VECTOR*BIT_VECTOR --> BIT_VECTOR & bv_catenate = %(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR | v1^v2) & bv_index: BIT_VECTOR --> POW(NATURAL) & bv_index = %v1.(v1: BIT_VECTOR | 0..bv_size(v1)-1) & bv_sub: BIT_VECTOR*NATURAL*NATURAL --> BIT_VECTOR & bv_sub = %(bv,low,high).(bv: BIT_VECTOR & low: 0..bv_size(bv)-1 & high: low..bv_size(bv)-1 | %i0.(i0: 1..high-low+1 | bv(i0+low))) & bv_zero: NATURAL1 --> BIT_VECTOR & bv_zero = %sz.(sz: NATURAL1 | (1..sz)*{0}) & bv_one: NATURAL1 --> BIT_VECTOR & bv_one = %sz.(sz: NATURAL1 | (1..sz)*{1}) & bv_not: BIT_VECTOR --> BIT_VECTOR & bv_not = %v1.(v1: BIT_VECTOR | %idx.(idx: 1..bv_size(v1) | bit_not(v1(idx)))) & bv_and: BIT_VECTOR*BIT_VECTOR --> BIT_VECTOR & bv_and = %(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) | %idx.(idx: 1..bv_size(v1) | bit_and(v1(idx),v2(idx)))) & bv_or: BIT_VECTOR*BIT_VECTOR --> BIT_VECTOR & bv_or = %(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) | %idx.(idx: 1..bv_size(v1) | bit_or(v1(idx),v2(idx)))) & bv_xor: BIT_VECTOR*BIT_VECTOR --> BIT_VECTOR & bv_xor = %(v1,v2).(v1: BIT_VECTOR & v2: BIT_VECTOR & bv_size(v1) = bv_size(v2) | %idx.(idx: 1..bv_size(v1) | bit_xor(v1(idx),v2(idx)))) & bv_get: BIT_VECTOR*NATURAL --> BIT & bv_get = %(v1,idx).(v1: BIT_VECTOR & idx: 0..bv_size(v1)-1 | v1(idx+1)) & bv_set: BIT_VECTOR*NATURAL --> BIT_VECTOR & bv_set = %(v1,idx).(v1: BIT_VECTOR & idx: 0..bv_size(v1)-1 | v1<+{idx+1|->1}) & bv_clear: BIT_VECTOR*NATURAL --> BIT_VECTOR & bv_clear = %(v1,idx).(v1: BIT_VECTOR & idx: 0..bv_size(v1)-1 | v1<+{idx+1|->0}) & bv_put: BIT_VECTOR*NATURAL*BIT --> BIT_VECTOR & bv_put = %(v1,idx,bit).(v1: BIT_VECTOR & idx: 0..bv_size(v1)-1 & bit: BIT | v1<+{idx+1|->bit}) & BYTE_INDEX = 1..8 & REAL_BYTE_INDEX = 0..8-1 & BYTE = {bt | bt: BIT_VECTOR & bv_size(bt) = 8} & BYTE_ZERO: BYTE & BYTE_ZERO = BYTE_INDEX*{0} & byte_bit_get: BYTE*REAL_BYTE_INDEX --> BIT & byte_bit_get = %(bt,ind).(bt: BYTE & ind: REAL_BYTE_INDEX | bt(ind+1)) & uchar_byte = byte_uchar~ & uchar_byte: UCHAR --> BYTE & byte_uchar = %v0.(v0: BYTE | 2**7*v0(7)+2**6*v0(6)+2**5*v0(5)+2**4*v0(4)+2**3*v0(3)+2**2*v0(2)+2*v0(1)+v0(0)) & byte_uchar: BYTE --> UCHAR & UCHAR_MIN = 0 & UCHAR_MAX = 2**8 & UCHAR_MIN: INTEGER & UCHAR_MAX: INTEGER & UCHAR = 0..2**8-1);
  Seen_List_Constraints(Machine(SSHORT_DEFINITION))==(btrue);
  Seen_List_Operations(Machine(SSHORT_DEFINITION),Machine(SCHAR_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(SSHORT_DEFINITION),Machine(SCHAR_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(SSHORT_DEFINITION),Machine(BV16_DEFINITION))==(?);
  Seen_List_Operations(Machine(SSHORT_DEFINITION),Machine(BV16_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(SSHORT_DEFINITION),Machine(BV16_DEFINITION))==(btrue)
END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(SSHORT_DEFINITION),?)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(SSHORT_DEFINITION)) == (SSHORT,bv16_sshort,sshort_bv16,schar_sshort,sshort_schar | ? | ? | ? | ? | ? | seen(Machine(BV16_DEFINITION)),seen(Machine(SCHAR_DEFINITION)) | ? | SSHORT_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(SSHORT_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(SSHORT_DEFINITION)) == (SSHORT,bv16_sshort,sshort_bv16,schar_sshort,sshort_schar);
  List_Of_VisibleVar_Ids(Machine(SSHORT_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(SSHORT_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(SCHAR_DEFINITION)) == (SCHAR,byte_schar,schar_byte,uchar_schar,schar_uchar | ? | ? | ? | ? | ? | seen(Machine(BYTE_DEFINITION)),seen(Machine(UCHAR_DEFINITION)) | ? | SCHAR_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(SCHAR_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(SCHAR_DEFINITION)) == (SCHAR,byte_schar,schar_byte,uchar_schar,schar_uchar);
  List_Of_VisibleVar_Ids(Machine(SCHAR_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(SCHAR_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(UCHAR_DEFINITION)) == (UCHAR,UCHAR_MAX,UCHAR_MIN,uchar_byte,byte_uchar | ? | ? | ? | ? | ? | seen(Machine(BYTE_DEFINITION)) | ? | UCHAR_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(UCHAR_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(UCHAR_DEFINITION)) == (UCHAR,UCHAR_MAX,UCHAR_MIN,uchar_byte,byte_uchar);
  List_Of_VisibleVar_Ids(Machine(UCHAR_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(UCHAR_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BYTE_DEFINITION)) == (BYTE,BYTE_INDEX,BYTE_ZERO,REAL_BYTE_INDEX,byte_bit_get | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BIT_VECTOR_DEFINITION)) | ? | BYTE_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BYTE_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BYTE_DEFINITION)) == (BYTE,BYTE_INDEX,BYTE_ZERO,REAL_BYTE_INDEX,byte_bit_get);
  List_Of_VisibleVar_Ids(Machine(BYTE_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BYTE_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BIT_VECTOR_DEFINITION)) == (BIT_VECTOR,bv_catenate,bv_sub,bv_zero,bv_one,bv_size,bv_not,bv_and,bv_or,bv_xor,bv_get,bv_set,bv_clear,bv_put,bv_index | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)) | ? | BIT_VECTOR_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BIT_VECTOR_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BIT_VECTOR_DEFINITION)) == (BIT_VECTOR,bv_catenate,bv_sub,bv_zero,bv_one,bv_size,bv_not,bv_and,bv_or,bv_xor,bv_get,bv_set,bv_clear,bv_put,bv_index);
  List_Of_VisibleVar_Ids(Machine(BIT_VECTOR_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BIT_VECTOR_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BIT_DEFINITION)) == (BIT,bit_not,bit_and,bit_or,bit_xor,bool_to_bit | ? | ? | ? | ? | ? | ? | ? | BIT_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BIT_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BIT_DEFINITION)) == (BIT,bit_not,bit_and,bit_or,bit_xor,bool_to_bit);
  List_Of_VisibleVar_Ids(Machine(BIT_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BIT_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BV16_DEFINITION)) == (BV16_INDX,REAL_BV16_INDX,BV16_ZERO,BV16,bv16_byte,byte_bv16,bv16_bit_get | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BIT_VECTOR_DEFINITION)),seen(Machine(BYTE_DEFINITION)) | ? | BV16_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BV16_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BV16_DEFINITION)) == (BV16_INDX,REAL_BV16_INDX,BV16_ZERO,BV16,bv16_byte,byte_bv16,bv16_bit_get);
  List_Of_VisibleVar_Ids(Machine(BV16_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BV16_DEFINITION)) == (?: ?)
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(SSHORT_DEFINITION)) == (Type(SSHORT) == Cst(SetOf(btype(INTEGER,"[SSHORT","]SSHORT")));Type(bv16_sshort) == Cst(SetOf(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))*btype(INTEGER,"[SSHORT","]SSHORT")));Type(sshort_bv16) == Cst(SetOf(btype(INTEGER,"[SSHORT","]SSHORT")*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))));Type(schar_sshort) == Cst(SetOf(btype(INTEGER,"[SCHAR","]SCHAR")*btype(INTEGER,"[SCHAR","]SCHAR")*btype(INTEGER,"[SSHORT","]SSHORT")));Type(sshort_schar) == Cst(SetOf(btype(INTEGER,"[SSHORT","]SSHORT")*(btype(INTEGER,"[SCHAR","]SCHAR")*btype(INTEGER,"[SCHAR","]SCHAR")))))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  event_b_project == KO;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == OK
END
)

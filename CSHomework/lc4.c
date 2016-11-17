#include "lc4.h"

void clear_signals(control_signals* control) {
	control->pc_mux_ctl = 0;
    control->rs_mux_ctl = 0;
    control->rt_mux_ctl = 0;
    control->rd_mux_ctl = 0;
    control->reg_file_we = 0;
    control->reg_input_mux_ctl = 0;
    control->arith_ctl = 0;
    control->arith_mux_ctl = 0;
    control->logic_ctl = 0;
    control->logic_mux_ctl = 0;
    control->shift_ctl = 0;
    control->const_ctl = 0;
    control->cmp_ctl = 0;
    control->alu_mux_ctl = 0;
    control->nzp_we = 0;
    control->data_we = 0;
}

void reset(machine_state* state) {
	state->PC = 0;
	state->PSR = 0;
	clear_signals(&(state->control));
	memset(state->R, 0, sizeof(state->R));
	memset(state->memory, 0, sizeof(state->memory));
}

void decode(unsigned short int I, control_signals* control)  {
	clear_signals(control);
	if(INST_OP(I) == 0x0) { //BR
		if(INST_11_9(I) == 0x0) {
			control->pc_mux_ctl = 1;
		}
	}
	if(INST_OP(I) == 0x1) { //ARITH
		if(INST_5_3(I) == 0x1) {
			control->arith_ctl = 1;
		}
		if(INST_5_3(I) == 0x2) {
			control->arith_ctl = 2;
		}
		if(INST_5_3(I) == 0x3) {
			control->arith_ctl = 3;
		}
		if(INST_5_3(I) > 0x3) {
			control->arith_mux_ctl = 1;
		}
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0x2) { //CMP
		control->rs_mux_ctl = 2;
		control->pc_mux_ctl = 1;
		control->cmp_ctl = INST_8_7(I);
		control->nzp_we = 1;
		control->alu_mux_ctl = 4;
	}
	if(INST_OP(I) == 0x4) { //JSR/R
		if(!INST_11(I)) {
			control->pc_mux_ctl = 3;
		}
		else {
			control->pc_mux_ctl = 5;
		}
		control->reg_file_we = 1;
		control->reg_input_mux_ctl = 2;
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0x5) { //LOGIC
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		if(INST_5_3(I) == 0x1) {
			control->arith_ctl = 1;
		}
		if(INST_5_3(I) == 0x2) {
			control->arith_ctl = 2;
		}
		if(INST_5_3(I) == 0x3) {
			control->arith_ctl = 3;
		}
		if(INST_5_3(I) > 0x3) {
			control->logic_mux_ctl = 1;
		}
		control->nzp_we = 1;
		control->alu_mux_ctl = 1;
	}
	if(INST_OP(I) == 0x6) { //LDR
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		control->reg_input_mux_ctl = 1;
		control->nzp_we = 1;
		control->arith_mux_ctl = 2;
	}
	if(INST_OP(I) == 0x7) { //STR
		control->pc_mux_ctl = 1;
		control->rt_mux_ctl = 1;
		control->data_we = 1;
		control->arith_mux_ctl = 2;
	}
	if(INST_OP(I) == 0x8) { //RTI
		control->pc_mux_ctl = 3;
		control->rs_mux_ctl = 1;
	}
	if(INST_OP(I) == 0x9) { //CONST
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		control->alu_mux_ctl = 3;
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0xA) { //SHIFT/MOD
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		control->arith_ctl = 4;
		control->shift_ctl = INST_5_4(I);
		if(INST_5_4(I) != 0x3) {
			control->alu_mux_ctl = 2;
		}
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0xC) { //JMP
		if(!INST_11(I)) {
			control->pc_mux_ctl = 3;
		}
		else {
			control->pc_mux_ctl = 2;
		}
	}
	if(INST_OP(I) == 0xD) { //HICONST
		control->pc_mux_ctl = 1;
		control->reg_file_we = 1;
		control->const_ctl = 1;
		control->alu_mux_ctl = 3;
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0xF) { //TRAP
		control->pc_mux_ctl = 4;
		control->rd_mux_ctl = 1;
		control->reg_file_we = 1;
		control->reg_input_mux_ctl = 2;
		control->nzp_we = 1;
	}
}

int update_state(machine_state* state) {
	if(state->PC >= DATA_START) {
		return 1;
	}
	word inst = getData(state, state->PC);
	decode(inst, &(state->control));
	word rs = rs_mux(state);
	word rt = rt_mux(state);
	word loc = rd_mux(state);
	word alu = alu_mux(state, rs, rt);
	word readData = (state->control).reg_input_mux_ctl;
	if(readData == 1 && alu < DATA_START) {
		return 2;
	}
	if(readData == 1 && alu >= OS_START) {
		return 3;
	}
	word regin = reg_input_mux(state, alu);
	if((state->control).reg_file_we) {
		(state->R)[loc] = regin;
		signWord calc = complement2Dec(regin);
		if(calc > 0  && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x1;
		}
		if(calc < 0 && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x4;
		}
		if(calc == 0 && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x2;
		}
	}
	if((state->control).data_we) {
		if(regin < DATA_START) {
			return 2;
		}
		if(regin >= OS_START && !(state->PSR | 0x8000)) {
			return 3;
		}
		(state->memory)[regin] = getRegister(state, rt);
	}
	char* runStr = stringFind(state, rs, rt, loc, inst);
	//printf("%x: %s\n", state->PC, runStr);
	state->PC = pc_mux(state, rs);
	return 0;
}

unsigned short int rd_mux(machine_state* state) {
	word control = (state->control).rd_mux_ctl;
	word inst = getData(state, state->PC);
	if(control == 1) {
		return 0x7;
	}
	if(!control) {
		return INST_11_9(inst);
	}
	return -1;
}


unsigned short int rs_mux(machine_state* state) {
	word control = (state->control).rs_mux_ctl;
	word inst = getData(state, state->PC);
	if(!control) {
		return INST_8_6(inst);
	}
	if(control == 1) {
		return 0x7;
	}
	if(control == 2) {
		return INST_11_9(inst);
	}
	return -1;
}

unsigned short int rt_mux(machine_state* state) {
	word control = (state->control).rt_mux_ctl;
	word inst = getData(state, state->PC);
	if(!control) {
		return INST_2_0(inst);
	}
	if(control == 1) {
		return INST_11_9(inst);
	}
	return -1;
}

unsigned short int alu_mux(machine_state* state, unsigned short int rs_out, unsigned short int rt_out) {
	word control = (state->control).alu_mux_ctl;
	word arith = (state->control).arith_ctl;
	word logic = (state->control).logic_ctl;
	word shift = (state->control).shift_ctl;
	word constant = (state->control).const_ctl;
	word comp = (state->control).cmp_ctl;
	word inst = getData(state, state->PC);
	if(!control) {
		if(!arith) {
			if(!((state->control).arith_mux_ctl)) {
				return dec2Complement(complement2Dec(getRegister(state, rs_out)) + complement2Dec(getRegister(state, rt_out)));
			}
			if((state->control).arith_mux_ctl == 1) {
				return dec2Complement(complement2Dec(getRegister(state, rs_out)) + complement2Dec(sext(UIMM5(inst), 5)));
			}
			if((state->control).arith_mux_ctl == 2) {
				return dec2Complement(complement2Dec(getRegister(state, rs_out)) + complement2Dec(sext(UIMM6(inst), 6)));
			}
		}
		if(arith == 1) {
			return dec2Complement(complement2Dec(getRegister(state, rs_out)) * complement2Dec(getRegister(state, rt_out)));
		}
		if(arith == 2) {
			return dec2Complement(complement2Dec(getRegister(state, rs_out)) - complement2Dec(getRegister(state, rt_out)));
		}
		if(arith == 3) {
			return dec2Complement((signWord) complement2Dec(getRegister(state, rs_out)) / complement2Dec(getRegister(state, rt_out)));
		}
		if(arith == 4) {
			return dec2Complement(complement2Dec(getRegister(state, rs_out)) % complement2Dec(getRegister(state, rt_out)));
		}
	}
	if(control == 1) {
		if(!logic) {
			if(!((state->control).logic_mux_ctl)) {
				return getRegister(state, rs_out) & getRegister(state, rt_out);
			}
			if((state->control).logic_mux_ctl == 1) {
				return getRegister(state, rs_out) & sext(UIMM5(inst), 5);
			}
		}
		if(logic == 1) {
			return ~getRegister(state, rs_out);
		}
		if(logic == 2) {
			return getRegister(state, rs_out) | getRegister(state, rt_out);
		}
		if(logic == 3) {
			return getRegister(state, rs_out) ^ getRegister(state, rt_out);
		}
	}
	if(control == 2) {
		if(!shift) {
			return getRegister(state, rs_out) << UIMM4(inst);
		}
		if(shift == 1) {
			return dec2Complement(complement2Dec(getRegister(state, rs_out)) >> UIMM4(inst));
		}
		if(shift == 2) {
			return getRegister(state, rs_out) >> UIMM4(inst);
		}
	}
	if(control == 3) {
		if(!constant) {
			return sext(UIMM9(inst), 9);
		}
		if(constant == 1) {
			word rd = rd_mux(state);
			return (rd & 0xFF) | (UIMM8(inst) << 8);
		}
	}
	if(control == 4) {
		word calc;
		if(!comp) {
			calc = complement2Dec(getRegister(state, rs_out)) - complement2Dec(getRegister(state, rt_out));
		}
		if(comp == 1) {
			calc = (signWord) getRegister(state, rs_out) - (signWord) getRegister(state, rt_out);
		}
		if(comp == 2) {
			calc = complement2Dec(getRegister(state, rs_out)) - complement2Dec(sext(UIMM7(inst), 7));
		}
		if(comp == 3) {
			calc = (signWord) getRegister(state, rs_out) - (signWord) UIMM7(inst);
		}
		if(calc > 0 && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x1;
		}
		if(calc < 0 && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x4;
		}
		if(calc == 0 && (state->control).nzp_we) {
			state->PSR = (state->PSR & 0xFFF8) | 0x2;
		}
	}
	return 0;
}

unsigned short int reg_input_mux(machine_state* state, unsigned short int alu_out) {
	word control = (state->control).reg_input_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control) {
		return alu_out;
	}
	if(control == 1) {
		return getData(state, alu_out);
	}
	if(control == 2) {
		return (state->PC) + 1;
	}
	return 0;
}

unsigned short int pc_mux(machine_state* state, unsigned short int rs_out) {
	word control = (state->control).rs_mux_ctl;
	word inst = getData(state, state->PC);
	if(!control) {
		if(INST_11_9(inst) | INST_2_0(state->PSR)) {
			return (state->PC) + 1 + complement2Dec(sext(UIMM9(inst), 9));
		}
		else {
			return (state->PC) + 1;
		}
	}
	if(control == 1) {
		return (state->PC) + 1;
	}
	if(control == 2) {
		return (state->PC) + 1 + complement2Dec(sext(UIMM11(inst), 11));
	}
	if(control == 3) {
		state->PSR = state->PSR & 0x7FFF;
		return rs_out;
	}
	if(control == 4) {
		state->PSR = state->PSR | 0x8000;
		return 0x8000 | UIMM8(inst);
	}
	if(control == 5) {
		return ((state->PC) & 0x8000) | (UIMM11(inst) << 4);
	}
	return -1;
}

word sext(word n, int len) {
	if(n > pow(2, len - 1)) {
		word mask = ~((int) pow(2, len) - 1);
		return mask | n;
	}
	else {
		return n;
	}
}

signWord complement2Dec(word n) {
	if(!(n & 0x8000)) {
		return n;
	}
	else {
		return -((~n) + 1);
	}
}

word dec2Complement(signWord n) {
	if(n > 0) {
		return n;
	}
	else {
		return ~((word) (-n) - 1);
	}
}

word getData(machine_state* state, word loc) {
	return (state->memory)[loc];
}

word getRegister(machine_state* state, word loc) {
	return (state->R)[loc];
}

char* stringFind(machine_state* state, int rs_out, int rt_out, int rd_out, word inst) {
	char* ret = (char*) malloc(MAX_STRING);
	if(INST_OP(inst))
		printf("%x\n", INST_OP(inst));
	switch(INST_OP(inst)) {
		case 0x0:
			switch(INST_11_9(inst)) {
				case 0x0:
					sprintf(ret, "NOP");
					break;
				case 0x1:
					sprintf(ret, "BRp");
					break;
				case 0x2:
					sprintf(ret, "BRz");
					break;
				case 0x3:
					sprintf(ret, "BRzp");
					break;
				case 0x4:
					sprintf(ret, "BRn");
					break;
				case 0x5:
					sprintf(ret, "BRnp");
					break;
				case 0x6:
					sprintf(ret, "BRnz");
					break;
				case 0x7:
					sprintf(ret, "BRnzp");
					break;
			}
			break;
		case 0x1:
			switch(INST_5_3(inst)) {
				case 0x0:
					sprintf(ret, "ADD R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				case 0x1:
					sprintf(ret, "MUL R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				case 0x2:
					sprintf(ret, "SUB R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				case 0x3:
					sprintf(ret, "DIV R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				default:
					sprintf(ret, "ADD R%x R%x %x", rd_out, rs_out, complement2Dec(sext(UIMM5(inst), 5)));
					break;
			}
			break;
		case 0x2:
			switch(INST_8_7(inst)) {
				case 0x0:
					sprintf(ret, "CMP R%x R%x", rs_out, rt_out);
					break;
				case 0x1:
					sprintf(ret, "CMPU R%x R%x", rs_out, rt_out);
					break;
				case 0x2:
					sprintf(ret, "CMPI R%x %x", rs_out, complement2Dec(sext(UIMM7(inst), 7)));
					break;
				case 0x3:
					sprintf(ret, "CMPIU R%x %x", rs_out, complement2Dec(UIMM7(inst)));
					break;
			}
			break;
		case 0x4:
			switch(INST_11(inst)) {
				case 0x0:
					sprintf(ret, "JSRR R%x", rs_out);
					break;
				case 0x1:
					sprintf(ret, "JSR");
					break;
			}
			break;
		case 0x5:
			switch(INST_5_3(inst)) {
				case 0x0:
					sprintf(ret, "AND R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				case 0x1:
					sprintf(ret, "NOT R%x R%x", rd_out, rs_out);
					break;
				case 0x2:
					sprintf(ret, "OR R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				case 0x3:
					sprintf(ret, "XOR R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
				default:
					sprintf(ret, "AND R%x R%x %x", rd_out, rs_out, complement2Dec(sext(UIMM5(inst), 5)));
					break;
			}
			break;
		case 0x6:
			sprintf(ret, "LDR R%x R%x %x", rd_out, rs_out, complement2Dec(sext(UIMM6(inst), 6)));
			break;
		case 0x7:
			sprintf(ret, "STR R%x R%x %x", rt_out, rs_out, complement2Dec(sext(UIMM6(inst), 6)));
			break;
		case 0x8:
			sprintf(ret, "RTI");
			break;
		case 0x9:
			sprintf(ret, "HICONST R%x %x", rd_out, complement2Dec(sext(UIMM9(inst), 9)));
			break;
		case 0xA:
			switch(INST_5_4(inst)) {
				case 0x0:
					sprintf(ret, "SLL R%x R%x %x", rd_out, rs_out, complement2Dec(UIMM4(inst)));
					break;
				case 0x1:
					sprintf(ret, "SRA R%x R%x %x", rd_out, rs_out, complement2Dec(UIMM4(inst)));
					break;
				case 0x2:
					sprintf(ret, "SRL R%x R%x %x", rd_out, rs_out, complement2Dec(UIMM4(inst)));
					break;
				case 0x3:
					sprintf(ret, "MOD R%x R%x R%x", rd_out, rs_out, rt_out);
					break;
			}
			break;
		case 0xC:
			switch(INST_11(inst)) {
				case 0x0:
					sprintf(ret, "JMPR R%x", rs_out);
					break;
				case 0x1:
					sprintf(ret, "JMP");
					break;
			}
			break;
		case 0xD:
			sprintf(ret, "HICONST R%x %x", rd_out, complement2Dec(UIMM8(inst)));
			break;
		case 0xF:
			sprintf(ret, "TRAP %x", complement2Dec(UIMM8(inst)));
			break;
		default:
			sprintf(ret, "Unknown Opcode");
	}
	return ret;
}

/*int main() {
	machine_state* m = (machine_state*) malloc(sizeof(machine_state));
	reset(m);
	m->R[0] = 0x2000;
	m->R[1] = 0x0C0F;
	m->memory[0] = 0x1040;
	int test = update_state(m);
	printf("%x\n", m->R[0]);
	free(m);
} */

//CHECK SHIFTS AND FORMATTING OF STORED DATA (IS FULL?)
//PART 3 OF READ ME?
//STR CHECKED AND WORKS, LDR CHECKED AND WORKS, ADD WORKS
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
		if(INST_11_9(I) == 0x0)
			control->pc_mux_ctl = 1
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
		if(!INST_11(I))
			control->pc_mux_ctl = 3;
		else
			control->pc_mux_ctl = 5;
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
		if(INST_5_4(I) != 0x3)
			control->alu_mux_ctl = 2;
		control->nzp_we = 1;
	}
	if(INST_OP(I) == 0xC) { //JMP
		if(!INST_11(I))
			control->pc_mux_ctl = 3;
		else
			control->pc_mux_ctl = 2;
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
	word inst = (state->memory)[state->PC];
	decode(inst, state->control);
	//EXCEPTION CHECK
	word rs = rs_mux(state);
	word rt = rt_mux(state);
	word alu = alu_mux(state, rs, rt);
	word regin = reg_input_mux(state, alu);
	state->PC = pc_mux(state, rs);
}

unsigned short int rs_mux(machine_state* state) {
	word control = (state->control).rs_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control)
		return INST_8_6(inst);
	if(control == 1)
		return R7;
	if(control == 2)
		return INST_11_9(inst);
	return -1;
}

unsigned short int rt_mux(machine_state* state) {
	word control = (state->control).rt_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control)
		return INST_2_0(inst);
	if(control == 1)
		return INST_11_9(inst);
	return -1;
}

//FIX ALL BELOW HERE

unsigned short int alu_mux(machine_state* state, unsigned short int rs_out, unsigned short int rt_out) {
	word control = (state->control).alu_mux_ctl;
	word arith = (state->control).arith_ctl;
	word logic = (state->control).logic_ctl;
	word shift = (state->control).shift_ctl;
	word constant = (state->control).const_ctl;
	word comp = (state->control).cmp_ctl;
	word inst = (state->memory)[state->PC];
	if(!control) {
		if(!arith) {
			if(!arith_mux_ctl)
				return rs_out + rt_out;
			if(arith_mux_ctl == 1)
				return rs_out + sext(UIMM5(inst), 5);
			if(arith_mux_ctl == 2)
				return rs_out + sext(UIMM6(inst), 6);
		}
		if(arith == 1)
			return rs_out * rt_out;
		if(arith == 2)
			return rs_out - rt_out;
		if(arith == 3)
			return (unsigned short int) (rs_out / rt_out);
		if(arith == 4)
			return rs_out % rt_out;
	}
	if(control == 1)
		if(!logic) {
			if(!logic_mux_ctl)
				return rs_out & rt_out;
			if(logic_mux_ctl == 1)
				return rs_out & sext(UIMM5(inst), 5);
		}
		if(logic == 1)
			return ~rs_out;
		if(logic == 2)
			return rs_out | rt_out;
		if(logic == 3)
			return rs_out ^ rt_out;
	if(control == 2)
		//SHIFT
	if(control == 3)
		//CONSTANT
	if(control == 4)
		//COMPARE
	return -1;
}

unsigned short int reg_input_mux(machine_state* state, unsigned short int alu_out) {
	word control = (state->control).reg_input_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control)
		return alu_out;
	if(control == 1)
		return getData(alu_out)
	if(control == 2)
		return (state->PC) + 1;
	return -1;
}

unsigned short int pc_mux(machine_state* state, unsigned short int rs_out) {
	word control = (state->control).rs_mux_ctl;
	word inst = getData(state->PC);
	if(!control)
		//ADD
	if(control == 1)
		return (state->PC) + 1;
	if(control == 2)
		return (state->PC) + 1 + sext(UIMM11(inst), 11);
	if(control == 3)
		state->PSR = state->PSR & 0x7FFF;
		return rs_out;
	if(control == 4) {
		state->PSR = state->PSR | 0x8000;
		return 0x8000 | UIMM8(inst);
	}
	if(control == 5)
		return ((state->PC) & 0x8000) | (UIMM11(inst) << 4)
	return -1;
}

word sext(word n, int len) {
	if(n > pow(2, len - 1))
		word mask = ~(pow(2, len) - 1);
		return mask | n;
	else	
		return n;
}

signWord complement2Dec(word n) {
	if(!(n & 0x8000))
		return n;
	else {
		return -((~n) + 1);
	}
}

word getData(word loc) {
	return (state->memory)[loc];
}
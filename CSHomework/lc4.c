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

unsigned short int alu_mux(machine_state* state, unsigned short int rs_out, unsigned short int rt_out) {
	word control = (state->control).alu_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control) {
		if(!arith_mux_ctl)
			return rs_out + rt_out;
		if(arith_mux_ctl == 1)
			//ADD IMMEDIATE
		if(arith_mux_ctl == 2)
			//ADD IMMEDIATE
	}
	if(control == 1)
		return rs_out * rt_out;
	if(control == 2)
		return rs_out - rt_out;
	if(control == 3)
		return (unsigned short int) (rs_out / rt_out);
	return -1;
}

unsigned short int reg_input_mux(machine_state* state, unsigned short int alu_out) {
	word control = (state->control).reg_input_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control)
		return alu_out;
	if(control == 1)
		return (state->memory)[alu_out]
	if(control == 2)
		return (state->PC) + 1;
	return -1;
}

unsigned short int pc_mux(machine_state* state, unsigned short int rs_out) {
	word control = (state->control).rs_mux_ctl;
	word inst = (state->memory)[state->PC];
	if(!control)
		//ADD
	if(control == 1)
		return (state->PC) + 1;
	if(control == 2)
		//ADD
	if(control == 3)
		return rs_out;
	if(control == 4)
		//ADD
	if(control == 5)
		//ADD
	return -1;
}
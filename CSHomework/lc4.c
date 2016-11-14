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

}

int update_state(machine_state* state) {

}

unsigned short int rs_mux(machine_state* state) {

}

unsigned short int rt_mux(machine_state* state) {

}

unsigned short int alu_mux(machine_state* state, unsigned short int rs_out, unsigned short int rt_out) {

}

unsigned short int reg_input_mux(machine_state* state, unsigned short int alu_out) {

}

unsigned short int pc_mux(machine_state* state, unsigned short int rs_out) {

}
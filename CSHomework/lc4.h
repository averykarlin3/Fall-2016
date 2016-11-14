/*
 * CIS 240 HW 9: LC4 Simulator
 * lc4.h - defines machine state struct and prototypes for related functions
 */

/*
 * Struct representing all 16 control signals.
 */
typedef struct {
    unsigned char pc_mux_ctl;
    unsigned char rs_mux_ctl;
    unsigned char rt_mux_ctl;
    unsigned char rd_mux_ctl;
    unsigned char reg_file_we;
    unsigned char reg_input_mux_ctl;
    unsigned char arith_ctl;
    unsigned char arith_mux_ctl;
    unsigned char logic_ctl;
    unsigned char logic_mux_ctl;
    unsigned char shift_ctl;
    unsigned char const_ctl;
    unsigned char cmp_ctl;
    unsigned char alu_mux_ctl;
    unsigned char nzp_we;
    unsigned char data_we;
} control_signals;

/*
 * Struct representing the complete state of the machine.
 */
typedef struct {
  // Current value of the program counter register
  unsigned short int PC;

  // Processor status register; bit[2]=N, [1]=Z, [0]=P, bit[15]=privilege bit
  unsigned short int PSR;

  // Machine registers - all 8
  unsigned short int R[8];

  // Machine memory - all rows
  unsigned short int memory[65536];

  // Control signals - struct containing all 16
  control_signals control;

} machine_state;

/*
 * Decodes instruction and sets control signals accordingly.
 * Params: instruction to decode and pointer to control signals struct.
 */
void decode(unsigned short int I, control_signals* control);

/*
 * Resets all control signals to 0.
 * Param: pointer to control signals struct.
 */
void clear_signals(control_signals* control);

/*
 * Resets the machine state as PennSim would do.
 * Param: pointer to current machine state.
 */
void reset(machine_state* state);

/*
 * Updates the machine state, simulating a single clock cycle.
 * Returns 0 if update successful, a nonzero error code if unsuccessful.
 * Param: pointer to current machine state.
 */
int update_state(machine_state* state);

/*
 * Returns the current output of the RS mux.
 * Param: pointer to current machine state.
 */
unsigned short int rs_mux(machine_state* state);

/*
 * Returns the current output of the RT mux.
 * Param: pointer to current machine state.
 */
unsigned short int rt_mux(machine_state* state);

/*
 * Returns the current output of the ALU mux.
 * Params: pointer to current machine state, RS mux output, RT mux output.
 */
unsigned short int alu_mux(machine_state* state,
                           unsigned short int rs_out,
                           unsigned short int rt_out);

/*
 * Returns the current output of the register input mux.
 * Params: pointer to current machine state and current ALU mux output.
 */
unsigned short int reg_input_mux(machine_state* state,
                                 unsigned short int alu_out);

/*
 * Returns the current output of the PC mux.
 * Params: current RS mux output and pointer to current machine state.
 */
unsigned short int pc_mux(machine_state* state, unsigned short int rs_out);

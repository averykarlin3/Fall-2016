/*
 * CIS 240 HW 9: LC4 Simulator
 * lc4.h - defines machine state struct and prototypes for related functions
 */

/*
 * Struct representing all 16 control signals.
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

//MACRO COMMANDS TO PARSE LC4 INSTRUCTIONS

#define INST_OP(I) ((I) >> 12)
#define INST_14_10(I) ((I) >> 10 & 0x1F)
#define INST_9_5(I) ((I) >> 5 & 0x1F)
#define INST_4_0(I) ((I) & 0x1F)
#define INST_11_9(I) ((I) >> 9 & 0x7)
#define INST_8_6(I) ((I) >> 6 & 0x7)
#define INST_2_0(I) ((I) & 0x7)
#define INST_8_7(I) ((I) >> 7 & 0x3)
#define INST_11(I) ((I) >> 11 & 0x1)
#define INST_5_3(I) ((I) >> 3 & 0x7)
#define INST_5_4(I) ((I) >> 4 & 0x3)
#define UIMM4(I) ((I) & 0xF)
#define UIMM5(I) ((I) & 0x1F)
#define UIMM6(I) ((I) & 0x3F)
#define UIMM7(I) ((I) & 0x7F)
#define UIMM8(I) ((I) & 0xFF)
#define UIMM9(I) ((I) & 0x1FF)
#define UIMM11(I) ((I) & 0x7FF)

//LC4 MACROS

#define DATA_START 0x2000
#define OS_START 0x8000
#define MAX_STRING 100 //Max command string length

//TRACE MODE OR MILESTONE MODE
#define TRACE_OFF 0

FILE* outbin; //output file
FILE* outpbm; //output image file

typedef unsigned short int word;
typedef short int signWord;

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

word sext(word n, int len);

signWord complement2Dec(word n);

word getData(machine_state* state, word loc);

word getRegister(machine_state* state, word loc);

word dec2Complement(signWord n);

unsigned short int rd_mux(machine_state* state);

char* stringFind(machine_state* state, int rs_out, int rt_out, int rd_out, word inst);

void pictureStore(machine_state* state);
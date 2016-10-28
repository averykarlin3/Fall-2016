/**
 * mc.c
 * CIS240 Fall 2016
 */

#include "lc4libc.h"

/************************************************
 *  DATA STRUCTURES FOR GAME STATE
 ***********************************************/

/** Width and height of lc4 */
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 124

/** Number of cities and launchers in the game */
#define NUM_CITIES 2

/** Number of targets incoming can target (cities + 1 launcher) */
#define NUM_TARGETS NUM_CITIES+1 

/** Number of maximum outgoing and incoming allowed on the screen */
#define MAX_OUTGOING 1
#define MAX_INCOMING 3

/** Number of missiles allowed per round*/
#define MISSILES_PER_ROUND 8

/** The y position of where the cities and launcher are located */
#define GROUND_LEVEL 116

/** The x positions of where the cities and launcher are located */
#define LEFT_CITY_XPOS	20
#define RIGHT_CITY_XPOS 100
#define MISSILE_COMMAND_XPOS 60

/** The squared distance where missiles will contact
 * if it is in the radius */
#define CONTACT_RADIUS 250

/** Delay between GETC_TIMER - default at 10ms */
#define GETC_TIMER_DELAY 10

/** 2D array presenting the cursor */
lc4uint cursorImage[] = {
  0x00,
  0x00,
  0x18,
  0x3C,
  0x3C,
  0x18,
  0x00,
  0x00
};

lc4uint 8Shot[] = {
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF
};

lc4uint 7Shot[] {
0xE7,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF
};

lc4uint 6Shot[] {
0xE7,
0xE7,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF
};

lc4uint 5Shot[] {
0xE7,
0xE7,
0xE7,
0xFF,
0xFF,
0xFF,
0xFF,
0xFF
};

lc4uint 4Shot[] {
0xE7,
0xE7,
0xE7,
0xE7,
0xFF,
0xFF,
0xFF,
0xFF
};

lc4uint 3Shot[] {
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xFF,
0xFF,
0xFF
};

lc4uint 2Shot[] {
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xFF,
0xFF
};

lc4uint 1Shot[] {
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xFF
};

lc4uint 0Shot[] {
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7,
0xE7
};

lc4uint CityImage[] {
0x10,
0x38,
0x38,
0x3C,
0x7C,
0x7C,
0x7E,
0xFF
};

/** Array of targets that the incoming will target */
lc4uint targets[NUM_TARGETS];

/** City struct that consists of the x position and 2D array */
/** representing the city's image */
typedef struct {
  lc4bool isDestroyed;
  lc4uint x = ;
  lc4uint cityImage[8];
}City;

/** Array consisting of cities */
City cities[NUM_CITIES];

/** Missile launcher struct that consists of the number missiles */
/** that the launcher has left, its x position and 2D array */
/** representing the missile launcher's image */
typedef struct {
  lc4bool isDestroyed;
  int missilesLeft;
  int x;
  lc4uint launcherImage[8];
}MissileLauncher;

/** Instance of the MissileLauncher Struct */
MissileLauncher missileLauncher;

/************************************************
 *  Projectile Struct
 *  lc4bool isActive - boolean representing 
 *                     if the projectile 
 *                     is active or not
 ***********************************************/
typedef struct {
  lc4bool isActive;
}Projectile;

/** Array consisting of missiles on the screen */
Projectile outgoing[MAX_OUTGOING];

/** Array consisting of incoming on the screen */
Projectile incoming[MAX_INCOMING];

/** Cursor struct consisting of the cursor's x and y position */
typedef struct{
  int x;
  int y;
}Cursor;

/** Instance of the cursor*/
Cursor cursor;

/***************************************************************
 * Debugging and utility functions
 * DO NOT EDIT
 ***************************************************************/

/************************************************
 *  Printnum - Prints out the value on the lc4
 ***********************************************/
void printnum (int n) {
  int abs_n;
  char str[10], *ptr;

  // Corner case (n == 0)
  if (n == 0) {
    lc4_puts ((lc4uint*)"0");
    return;
  }
 
  abs_n = (n < 0) ? -n : n;

  // Corner case (n == -32768) no corresponding +ve value
  if (abs_n < 0) {
    lc4_puts ((lc4uint*)"-32768");
    return;
  }

  ptr = str + 10; // beyond last character in string

  *(--ptr) = 0; // null termination

  while (abs_n) {
    *(--ptr) = (abs_n % 10) + 48; // generate ascii code for digit
    abs_n /= 10;
  }

  // Handle -ve numbers by adding - sign
  if (n < 0) *(--ptr) = '-';

  lc4_puts((lc4uint*)ptr);
}

void endl () {
  lc4_puts((lc4uint*)"\n");
}

/************************************************
 *  abs - returns the absolute value
 ***********************************************/
int abs(int value)
{
  if(value < 0)
    return -value;
  return value;
}

/************************************************
 *  rand16 - This function returns a random 
 *  number between 0 and 128
 ***********************************************/
int rand16 ()
{
  int lfsr;

  // Advance the lfsr seven times
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();

  // return the last 7 bits
  return (lfsr & 0x7F);
}

/***************************************************************
 * End of Debugging and utility functions
 ***************************************************************/

/************************************************
 * DrawCursor - 
 * Draws the cursor sprite in white 
 ***********************************************/
 void DrawCursor() 
 {
	int x = (*cursor).x;
	int y = (*cursor).y;
	lc4_draw_sprite(x, y, WHITE, cursor_image)
 }

/************************************************
 *  DrawMissileLauncher - 
 *  Draws the missile launcher in white based on 
 *  the number of missiles left
 ***********************************************/
 void DrawMissileLauncher(MissileLauncher m)
 {
 	int x = (*m).x;
	int mLeft = (*m).missilesLeft;
  switch mLeft {
    case 8:
      (*m).launcherImage = 8Shot;
      break;
    case 7:
      (*m).launcherImage = 7Shot;
      break;
    case 6:
      (*m).launcherImage = 6Shot;
      break;
    case 5:
      (*m).launcherImage = 5Shot;
      break;
    case 4:
      (*m).launcherImage = 4Shot;
      break;  
    case 3:
      (*m).launcherImage = 3Shot;
      break;
    case 2:
      (*m).launcherImage = 2Shot;
      break;
    case 1:
      (*m).launcherImage = 1Shot;
      break;
    default:
      (*m).launcherImage = 0Shot;
      break;
    }
    img[8] = (*missileLauncher).launcherImage;
	lc4_draw_sprite(MISSILE_COMMAND_XPOS, GROUND_LEVEL, WHITE, img);
 }

/************************************************
 *  DrawCities - 
 *  Draws the cities in white
 ***********************************************/
 void DrawCities()
 {
  lc4_draw_sprite();
  lc4_draw_sprite();
  
 }

/************************************************
 *  DrawIncoming - 
 *  Draws each incoming 
 ***********************************************/
 void DrawIncoming()
 {
 }

/************************************************
 *  DrawOutgoing
 *  Draws each outgoing missile 
 ***********************************************/
 void DrawOutgoing()
 {
 }

/************************************************
 *  Redraw - 
 *  Assuming that the PennSim is run with double 
 *  buffered mode, (using the launcher -> 
 *  (java -jar PennSim.jar -d))
 *  First, we should clear the video memory buffer 
 *  using lc4_reset_vmem.  Then we draw the scene 
 *  and then swap the video memory buffer using 
 *  lc4_blt_vmem
 ***********************************************/
void Redraw()
{
  lc4_reset_vmem();

  DrawCursor();
  DrawMissileLauncher();
  DrawCities();
  DrawOutgoing();
  DrawIncoming();
  lc4_blt_vmem();
}

/************************************************
 *  Reset - 
 *  Clears the screen
 ***********************************************/
void reset()
{
  lc4_reset_vmem();
  lc4_blt_vmem();
}

/************************************************
 *  ResetGame - 
 *  Resets the game. 
 ***********************************************/

 void ResetGame()
 {
 reset();
 (*cursor).x = SCREEN_WIDTH/2;
 (*cursor).y = SCREEN_HEIGHT - 4;
 }

/************************************************
 *  main - 
 *  Initalize game state by reseting the game state
 *  Loops until the the user loses
 ***********************************************/
 int main ()
 {
  //** Print to screen and initalize game state. */
  lc4_puts ((lc4uint*)"Welcome to Missile Command!\n");

  ResetGame();

  while(1) 
  {
  }

  return 0;
}

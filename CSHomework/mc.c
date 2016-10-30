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

#define SQUARES 10

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

lc4uint VIIIShot[] = {
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF
};

lc4uint VIIShot[] = {
  0xE7,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF
};

lc4uint VIShot[] = {
  0xE7,
  0xE7,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF
};

lc4uint VShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF
};

lc4uint IVShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xFF,
  0xFF,
  0xFF,
  0xFF
};

lc4uint IIIShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xFF,
  0xFF,
  0xFF
};

lc4uint IIShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xFF,
  0xFF
};

lc4uint IShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xFF
};

lc4uint NoShot[] = {
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7,
  0xE7
};

lc4uint LiveCity[] = {
  0x10,
  0x38,
  0x38,
  0x3C,
  0x7C,
  0x7C,
  0x7E,
  0xFF
};

lc4uint DeadCity[] = {
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7E,
  0xFF
};

lc4uint GoneCity[] = {
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00
};

/** Array of targets that the incoming will target */
//lc4uint targets[NUM_TARGETS];

/** City struct that consists of the x position and 2D array */
/** representing the city's image */
typedef struct {
  lc4uint lives;
  lc4uint x;
  lc4uint cityImage[8];
}City;

/** Array consisting of cities */
City cities[NUM_CITIES];

/** Missile launcher struct that consists of the number missiles */
/** that the launcher has left, its x position and 2D array */
/** representing the missile launcher's image */
typedef struct {
  lc4uint lives;
  int missilesLeft;
  int x;
  lc4uint launcherImage[8];
}MissileLauncher;

/** Instance of the MissileLauncher Struct */
MissileLauncher mL;

/************************************************
 *  Projectile Struct
 *  lc4bool isActive - boolean representing 
 *                     if the projectile 
 *                     is active or not
 ***********************************************/
typedef struct {
  lc4bool isActive;
  lc4uint xi;
  lc4uint yi;
  lc4uint x;
  lc4uint y;
  lc4uint xf;
  lc4uint yf;
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
	int x = cursor.x;
	int y = cursor.y;
	lc4_draw_sprite(x, y, WHITE, cursorImage);
 }

/************************************************
 *  DrawMissileLauncher - 
 *  Draws the missile launcher in white based on 
 *  the number of missiles left
 ***********************************************/
 void DrawMissileLauncher()
 {
 	int x = mL.x;
	int mLeft = mL.missilesLeft;
  switch (mLeft) {
    case 8:
      memcpy(VIIIShot, mL.launcherImage, 8);
      break;
    case 7:
      memcpy(VIIShot, mL.launcherImage, 8);
      break;
    case 6:
      memcpy(VIShot, mL.launcherImage, 8);
      break;
    case 5:
      memcpy(VShot, mL.launcherImage, 8);
      break;
    case 4:
      memcpy(IVShot, mL.launcherImage, 8);
      break;  
    case 3:
      memcpy(IIIShot, mL.launcherImage, 8);
      break;
    case 2:
      memcpy(IIShot, mL.launcherImage, 8);
      break;
    case 1:
      memcpy(IShot, mL.launcherImage, 8);
      break;
    default:
      memcpy(NoShot, mL.launcherImage, 8);
      break;
    }
  if(!(mL.lives))
    memcpy(GoneCity, mL.launcherImage, 8);
	lc4_draw_sprite(MISSILE_COMMAND_XPOS, GROUND_LEVEL, WHITE, mL.launcherImage);
 }

/************************************************
 *  DrawCities - 
 *  Draws the cities in white
 ***********************************************/
 void DrawCities()
 {
  int i;
  lc4int xval;
  for(i = 0; i < sizeof(cities); i++) {
    if (!(cities[i].lives))
      memcpy(GoneCity, cities[i].cityImage, 8);
    else {
      if(cities[i].lives == 1)
        memcpy(DeadCity, cities[i].cityImage, 8);
      else
        memcpy(LiveCity, cities[i].cityImage, 8);
    }
    xval = cities[i].x;
    lc4_draw_sprite(xval, GROUND_LEVEL, WHITE, cities[i].cityImage);
  }
 }

/************************************************
 *  DrawIncoming - 
 *  Draws each incoming
 ***********************************************/
 void DrawIncoming()
 {
  int i;
  for(i = 0; i < MAX_INCOMING; i++) {
    lc4uint xi = (incoming[i]).xi;
    lc4uint yi = (incoming[i]).yi;
    lc4uint x = (incoming[i]).x;
    lc4uint y = (incoming[i]).y;
    lc4_draw_line(xi, yi, x, y, RED);
  }
 }

/************************************************
 *  DrawOutgoing
 *  Draws each outgoing missile 
 ***********************************************/
 void DrawOutgoing()
 {
  int i;
  for(i = 0; i < MAX_OUTGOING; i++) {
    lc4uint xi = (outgoing[i]).xi;
    lc4uint yi = (outgoing[i]).yi;
    lc4uint x = (outgoing[i]).x;
    lc4uint y = (outgoing[i]).y;
    lc4_draw_line(xi, yi, x, y, BLUE);
  }
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

 void ResetGame() {
 reset();
 (cursor).x = SCREEN_WIDTH/2;
 (cursor).y = SCREEN_HEIGHT - 4;
 int i;
  for(i = 0; i < NUM_CITIES; i++) {
    (cities[i]).lives = 2;
    (cities[i]).x = rand16();
    memcpy(LiveCity, cities[i].cityImage, 8);
    //targets[i] = cities[i];
  }
  //targets[NUM_TARGETS - 1] = mL;
  (mL).lives = 2;
  (mL).x = 0;
  memcpy(VIIIShot, mL.launcherImage, 8);
  (mL).missilesLeft = MISSILES_PER_ROUND;
 }

void Move(Projectile p) {
  int i = 0;
  for(i = 0; i < SQUARES; i++) {
    int dx = (p).x - (p).xf;
    int dy = (p).y - (p).yf;
    if(abs(dy) >= abs(dx)) {
      if(dy >= 0)
        (p).y--;
      else
        (p).y++;
    }
    else {
      if(dx >= 0)
        (p).x--;
      else
        (p).x++;
    }   
  }
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
  lc4_puts ((lc4uint*)"WASD for Movement, R to Shoot\n");
  ResetGame();
  int destroyedCount = 0;
  while(1) 
  {
    lc4int in = lc4_getc_timer(GETC_TIMER_DELAY);
    switch (in) {
      case 'w':
      (cursor).y++;
      break;
      case 'a':
      (cursor).x--;
      break;
      case 's':
      (cursor).y--;
      break;
      case 'd':
      (cursor).x++;
      break;
      case 'r':
      if(!((mL).missilesLeft))
        break;
      int i;
      for(i = 0; i < MAX_OUTGOING; i++) {
        if(!((outgoing[i]).isActive)) {
          (outgoing[i]).xf = (cursor).x;
          (outgoing[i]).yf = (cursor).y;
          (outgoing[i]).x = (mL).x;
          (outgoing[i]).xi = (mL).x;
          (outgoing[i]).yi = GROUND_LEVEL;
          (outgoing[i]).y = GROUND_LEVEL;
          (outgoing[i]).isActive = 1;
          break;
        }
      }
      break;
    }
    int i;
    int j;
    int dx;
    int dy;
    for(i = 0; i < MAX_INCOMING; i++) {
      for(j = 0; j < MAX_OUTGOING; j++) {
        dx = abs((incoming[i]).x - (outgoing[j]).x);
        dy = abs((incoming[i]).y - (outgoing[j]).y);
        d =  dx*dx + dy*dy;
        if(d < CONTACT_RADIUS) {
          (incoming[i]).isActive = 0;
          (outgoing[j]).isActive = 0;
          destroyedCount++;
        }
      }
      for(int j = 0; j < NUM_TARGETS; j++) {
        if(j == NUM_CITIES)
          dx = abs((incoming[i]).x - (mL.x);
        else
          dx = abs((incoming[i]).x - (cities[j]).x);
        dy = abs((incoming[i]).y - GROUND_LEVEL;
        d =  dx*dx + dy*dy;
        if(d < CONTACT_RADIUS) {
          (incoming[i]).isActive = 0;
          if(j == NUM_CITIES)
            mL.lives--;
          else
            (cities[j]).lives--;
        }
      }
    }
    for(int i = 0; i < MAX_INCOMING; i++) {
      if(!((incoming[i]).isActive)) {
        num = rand16() % 3;
        if (num == NUM_CITIES) {
          (incoming[i]).xf = mL.x;
          (incoming[i]).yf = mL.y;
        }
        else {
          (incoming[i]).xf = (cities[num]).x;
          (incoming[i]).yf = (cities[num]).y;
        }
        xinitial = rand16();
        (incoming[i]).x = xinitial;
        (incoming[i]).xi = xinitial;
        (incoming[i]).yi = 0;
        (incoming[i]).y = 0;
        (incoming[i]).isActive = 1;
      }
    }
    for(int i = 0; i < MAX_INCOMING; i++) {
      Move(incoming[i]);
    }
    for(int i = 0; i < MAX_OUTGOING; i++) {
      Move(outgoing[i]);
    }
    int livesLeft = 0;
    for(int i = 0; i < NUM_TARGETS; i++) {
      if(i == NUM_CITIES)
        livesLeft += mL.lives;
      else
        livesLeft += (cities[i]).lives;
    }
    if(destroyedCount == 8) {
      destroyedCount = 0;
      ResetGame();
    }
    else if(!livesLeft) {
      lc4_puts ((lc4uint*)"Game Over...\n");
      break;
    }
    else {
      Redraw();
    }
  }
  return 0;
}

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

#define SQUARES 1

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
  lc4int x;
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
  lc4int x;
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
  lc4int xi;
  lc4int yi;
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

void copy(lc4uint orig[8], lc4uint cpy[8]) {
  int i;
  for(i = 0; i < 8; i++)
    cpy[i] = orig[i];

}

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
  if (mLeft == 8) {
    copy(VIIIShot, mL.launcherImage);
  }
  else {
    if(mLeft == 7) {
      copy(VIIShot, mL.launcherImage);
    }
    else {
      if(mLeft == 6) {
        copy(VIShot, mL.launcherImage);
      }
      else {
        if(mLeft == 5) {
          copy(VShot, mL.launcherImage);
        }
        else {
          if(mLeft == 4) {
            copy(IVShot, mL.launcherImage);
          }
          else {
            if(mLeft == 3) {
              copy(IIIShot, mL.launcherImage);
            }
            else {
              if(mLeft = 2) {
                copy(IIShot, mL.launcherImage);
              }
              else {
                if(mLeft == 1) {
                  copy(IShot, mL.launcherImage);
                }
                else {
                  copy(NoShot, mL.launcherImage);
                }
              }
            }
          }
        }
      }
    }
  }
  if(!(mL.lives))
    copy(GoneCity, mL.launcherImage);
  lc4_draw_sprite(MISSILE_COMMAND_XPOS, GROUND_LEVEL, GREEN, mL.launcherImage);
}

/************************************************
 *  DrawCities - 
 *  Draws the cities in white
 ***********************************************/
void DrawCities()
{
  int i;
  lc4uint color;
  lc4int xval;
  for(i = 0; i < 2; i++) {
    if (!(cities[i].lives)) {
      copy(GoneCity, cities[i].cityImage);
    }
    else {
      if(cities[i].lives == 1) {
        copy(DeadCity, cities[i].cityImage);
      }
      else {
        copy(LiveCity, cities[i].cityImage);
      }
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
  lc4uint x;
  lc4uint y;
  lc4int xi;
  lc4int yi;
  int i;
  for(i = 0; i < MAX_INCOMING; i++) {
    if(incoming[i].isActive) {
      xi = (incoming[i]).xi;
      yi = (incoming[i]).yi;
      x = (incoming[i]).x;
      y = (incoming[i]).y;
      lc4_draw_line(xi, yi, x, y, RED);
    }
  }
}

/************************************************
 *  DrawOutgoing
 *  Draws each outgoing missile 
 ***********************************************/
void DrawOutgoing()
{
  lc4uint x;
  lc4uint y;
  lc4int xi;
  lc4int yi;
  int i;
  for(i = 0; i < MAX_OUTGOING; i++) {
    if(outgoing[i].isActive) {
      xi = (outgoing[i]).xi;
      yi = (outgoing[i]).yi;
      x = (outgoing[i]).x;
      y = (outgoing[i]).y;
      lc4_draw_line(xi, yi, x, y, BLUE);
    }
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
 int i;
 reset();
 (cursor).x = SCREEN_WIDTH/2;
 (cursor).y = SCREEN_HEIGHT - 4;
 (cities[0]).lives = 2;
 (cities[0]).x = LEFT_CITY_XPOS;
 copy(LiveCity, cities[0].cityImage);
 (cities[1]).lives = 2;
 (cities[1]).x = RIGHT_CITY_XPOS;
 copy(LiveCity, cities[1].cityImage);
 (mL).lives = 2;
 (mL).x = MISSILE_COMMAND_XPOS;
 copy(VIIIShot, mL.launcherImage);
 (mL).missilesLeft = MISSILES_PER_ROUND;
 for(i = 0; i < MAX_OUTGOING; i++) {
  outgoing[i].isActive = 0;
  }
  for(i = 0; i < MAX_INCOMING; i++) {
  incoming[i].isActive = 0;
 }
}

void Move(Projectile* p) {
  int dy;
  int dx;
  int i = 0;
  //lc4_puts((lc4uint*) "NEXT\n");
  for(i = 0; i < SQUARES; i++) {
    dx = p->x - p->xf;
    dy = p->y - p->yf;
    if(abs(dy) >= abs(dx)) {
      if(dy >= 0)
        p->y--;
      else
        p->y++;
    }
    else {
      if(dx >= 0)
        p->x--;
      else
        p->x++;
    }   
  }
}

/************************************************
 *  main - 
 *  Initalize game state by reseting the game state
 *  Loops until the the user loses
 ***********************************************/
int main()
{
  //** Print to screen and initalize game state. */
  int i;
  int j;
  int dx;
  int dy;
  int d;
  int num;
  int livesLeft;
  int xinitial;
  int destroyedCount = 0;
  lc4int in;
  lc4_puts ((lc4uint*)"Welcome to Missile Command!\n");
  lc4_puts ((lc4uint*)"WASD for Movement, R to Shoot\n");
  ResetGame();
  while(1) 
  {
    in = lc4_getc_timer(GETC_TIMER_DELAY);
    if(in == 'w')
      (cursor).y--;
    if(in == 'a')
      (cursor).x--;
    if(in == 's')
      (cursor).y++;
    if(in == 'd')
      (cursor).x++;
    if(in == 'r') {
      if(!((mL).missilesLeft))
        break;
      for(i = 0; i < MAX_OUTGOING; i++) {
        if(!((outgoing[i]).isActive)) {
          (outgoing[i]).xf = (cursor).x;
          (outgoing[i]).yf = (cursor).y;
          (outgoing[i]).x = (mL).x;
          (outgoing[i]).xi = (mL).x;
          (outgoing[i]).yi = GROUND_LEVEL;
          (outgoing[i]).y = GROUND_LEVEL;
          (outgoing[i]).isActive = 1;
          mL.missilesLeft--;
          break;
        }
      }
    }
    for(i = 0; i < MAX_INCOMING; i++) {
      for(j = 0; j < MAX_OUTGOING; j++) {
        if(outgoing[j].isActive) {
          dx = abs((incoming[i]).x - (outgoing[j]).x);
          dy = abs((incoming[i]).y - (outgoing[j]).y);
          d =  dx*dx + dy*dy;
          if(d < CONTACT_RADIUS) {
            (incoming[i]).isActive = 0;
            (outgoing[j]).isActive = 0;
            destroyedCount++;
          }
        }
      }
      for(j = 0; j < NUM_TARGETS; j++) {
        if(j == NUM_CITIES)
          dx = abs((incoming[i]).x - (mL.x));
        else
          dx = abs((incoming[i]).x - (cities[j]).x);
        dy = abs((incoming[i]).y - GROUND_LEVEL);
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
    for(i = 0; i < MAX_INCOMING; i++) {
      if(!((incoming[i]).isActive)) {
        num = rand16() % 3;
        if (num == NUM_CITIES) {
          (incoming[i]).xf = mL.x;
          (incoming[i]).yf = GROUND_LEVEL;
        }
        else {
          (incoming[i]).xf = (cities[num]).x;
          (incoming[i]).yf = GROUND_LEVEL;
        }
        xinitial = rand16();
        (incoming[i]).x = xinitial;
        (incoming[i]).xi = xinitial;
        (incoming[i]).yi = 0;
        (incoming[i]).y = 0;
        (incoming[i]).isActive = 1;
      }
    }
    for(i = 0; i < MAX_INCOMING; i++) {
      Move(&incoming[i]);
    }
    for(i = 0; i < MAX_OUTGOING; i++) {
      Move(&outgoing[i]);
    }
    livesLeft = 0;
    for(i = 0; i < NUM_TARGETS; i++) {
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

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7582*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7582*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

//import processing.opengl.*;
import oscP5.*;
import netP5.*;

//do a world where cells can use a different GoL birth/survival rule than the other cells in their same instance
PFont font;
Grid grid = new Grid( 250, 250 );
Canvas canvas = new Canvas( grid, 500 ); 
Interface ui = new Interface( grid, canvas );

Checkbox[] birthChecks = new Checkbox[9]; 
Checkbox[] surviveChecks = new Checkbox[9];

static int numborn;
static int numdied;
static int population;
static int xborn;
static int yborn;
static int xdied;
static int ydied;

static final int FRAMERATE = 24;

// OSC
OscP5 oscP5;
NetAddress receiver;

void setup(){
  // OSC
  oscP5 = new OscP5(this, 12000); // listen on port 12000
  receiver = new NetAddress("localhost", 8338);
  frameRate(FRAMERATE);
  
  // game
  size( 500, 600, P2D );  
      for( int n = 0; n < 9; n++){
        birthChecks[n] = new Checkbox( n, 530, 10 );     
        surviveChecks[n] = new Checkbox( n, 550, 10 );
    }
    //set initial conway rules
    birthChecks[3].toggle();
    surviveChecks[2].toggle();
    surviveChecks[3].toggle();
    
  canvas.setCellSizeInPixels( 2 );
  grid.randomizeCells( .9);

  noStroke();
  font = loadFont("Consolas-16.vlw");
  textFont(font,16);
  
  // SEND SETUP INFO
  OscMessage center = new OscMessage("/center");
  center.add(width/2); center.add(height/2-50);
  oscP5.send(center, receiver);
  
  OscMessage fr = new OscMessage("/fr");
  fr.add(FRAMERATE);
  oscP5.send(fr, receiver);
}


void draw(){
  
  if( !ui.paused ){    
    canvas.display();   
    grid.determineNextCellStates();  
    grid.updateCellStates();
  }
  
  sendOSC();
  resetGlobals();
  
  ui.display();
}

void sendOSC() {
  OscMessage nb = new OscMessage("/numborn");
  nb.add(numborn);
  oscP5.send(nb, receiver);
  
  OscMessage nd = new OscMessage("/numdied");
  nd.add(numdied);
  oscP5.send(nd, receiver);
  
  OscMessage pop = new OscMessage("/population");
  pop.add(population);
  oscP5.send(pop, receiver);
  
  OscMessage ablx = new OscMessage("/avgbornlocx");
  ablx.add(xborn / (numborn+1));
  oscP5.send(ablx, receiver);
  
  OscMessage ably = new OscMessage("/avgbornlocy");
  ably.add(yborn / (numborn+1));
  oscP5.send(ably, receiver);
  
  OscMessage adlx = new OscMessage("/avgdiedlocx");
  adlx.add(xdied / (numdied+1));
  oscP5.send(adlx, receiver);
  
  OscMessage adly = new OscMessage("/avgdiedlocy");
  adly.add(ydied / (numdied+1));
  oscP5.send(adly, receiver);
}  

void resetGlobals() {
  numborn = 0;
  numdied = 0;
  population = 0;
  xborn = 0;
  yborn = 0;
  xdied = 0;
  ydied = 0;
}


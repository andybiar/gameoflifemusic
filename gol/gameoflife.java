import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class gameoflife extends PApplet {


PImage picture;

Cell[][] grid;
ArrayList cells;



int cellsize = 10;
int cols;
int rows;

int speed = 1;

public void keyPressed(){
 if( keyCode == UP ){
  speed++;
 }
 if( keyCode == DOWN ){
  speed--; 
 }
 
 if( speed > 60 ){
  speed = 60; 
 }
 if( speed < 1 ){
   speed = 1;  
 }
 frameRate(speed);
}

public void setup(){
  size( 500, 500, P2D );
  cols = height/cellsize;
  rows = width/cellsize;  
  grid = new Cell[cols][rows];
  
  for (int i = 0; i < rows; i++ ) {
    for (int j = 0; j < cols; j++ ) {
      grid[i][j] = new Cell(i,j);
      grid[i][j].alive = ( random(0,1) > .5f ) ? true : false;
    }
  }
  frameRate(speed);
  stroke(0);
}


public void draw(){
 
  fill(255);
  rect(0,0,height,width);
  for (int i = 0; i < rows; i++ ) {
    for (int j = 0; j < cols; j++ ) {
      grid[i][j].check();
    }
  }
  
  for (int i = 0; i < rows; i++ ) {
    for (int j = 0; j < cols; j++ ) {
      grid[i][j].apply();
      if( grid[i][j].isAlive() ){
        grid[i][j].render();
      } 
    }
  }
  
  
}



class Cell{
  boolean alive;
  boolean willLive;
  int x;
  int y;
  int sizeX;
  int sizeY;
  Cell( int i, int j ){
    this.x = i;
    this.y = j;
    this.sizeX = width/rows;
    this.sizeY = height/cols;  
  }
  
  public void render(){
    fill(0);
    rect(this.x*cellsize, this.y*cellsize, this.sizeX, this.sizeY);  
  }
  
  public boolean isAlive(){
   return this.alive; 
  }
  
  public void live(){
    this.willLive = true;
  }
  
  public void die(){
    this.willLive = false;  
  }
  
  public void check(){
    
    int neighbors = PApplet.parseInt(northAlive()) + PApplet.parseInt(southAlive()) + PApplet.parseInt(eastAlive()) + PApplet.parseInt(westAlive());
    if( neighbors <= 1 && neighbors >= 1 ){
      this.live();
    }
    else{
      this.die();
    }
    
  }
  
  public void apply(){
    this.alive = this.willLive;  
  }
  
  public boolean northAlive(){
    if( ( this.y - 1 ) > 0 ){
      return grid[ this.x ][ this.y - 1 ].isAlive();
    }
    return false;
  }
  
  public boolean southAlive(){
    if( ( this.y + 1 ) < cols ){
      return grid[ this.x ][ this.y + 1 ].isAlive();
    }
    return false;
  }
    
  public boolean eastAlive(){
    if( ( this.x + 1 ) < rows ){
      return grid[ this.x + 1 ][ this.y ].isAlive();
    }
    return false;
  }
  
  public boolean westAlive(){
    if( ( this.x - 1 ) > 0 ){
      return grid[ this.x - 1 ][ this.y ].isAlive();
    }
    return false;
  }
   
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "gameoflife" });
  }
}

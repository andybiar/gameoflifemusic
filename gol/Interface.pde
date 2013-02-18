class Interface{
  
  boolean paused;
  Grid grid;
  Canvas canvas;
  int speed;
  boolean giveCellLife;
  boolean dragging;
  Cell mouseOverCell;
 
  
  Interface( Grid grid, Canvas canvas ){
    this.grid = grid;  
    this.canvas = canvas;
    this.speed = 60;

    
  }
  
  void checkKeys(){
    if( keyPressed ){
      checkSpeedChange();
      checkPause();
      checkClear();
      checkReset();
    }
  }
 
  void checkMouse(){
    
    
    int i = ( mouseX - ( mouseX % canvas.cellSize ) ) / canvas.cellSize;
    int j = ( mouseY - ( mouseY % canvas.cellSize ) ) / canvas.cellSize;
      
    mouseOverCell = grid.getCell( i, j );
       
    if( mousePressed ){
    
      for( int n = 0; n  < 9; n++){
        birthChecks[n].checkMouse();        
        surviveChecks[n].checkMouse();
      }
      
      if( !dragging ){
        giveCellLife = !mouseOverCell.isAlive();  
      }
      
      if( giveCellLife ){
        mouseOverCell.live();  
      }
      else{
        mouseOverCell.die();
      }
      
      canvas.renderCell( mouseOverCell );
      
    }
    
    

    
  }
  
  void checkClear(){
    if( key == 'c' ){
      grid.killAllCells();
      canvas.display();
    }  
  }
  
  void checkPause(){
   if( key == ' ' ){
    togglePause(); 
   }
  }
  
  void checkReset(){
   if( key == 'r' ){
     grid.randomizeCells(.5); 
   }
  }
  
  void checkSpeedChange(){
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
  
  void togglePause(){
    if( paused == false ){   
      paused = true;
    }
    else{
      paused = false;
    }
  }
  
  void display(){
    fill(235);
    rect( 0, canvas.canvasHeight, width, height );
    fill(0);
    text( "generations per second:" + speed, 20, 595 );
    if( mouseOverCell != null ){
      fill(0);
      text( "# live neighbors: "+str(mouseOverCell.getNumberOfNeighbors()), 300, height - 5 );
    }
    
    if( paused ){
      fill(0);
      text("Paused", 25, height - 80 ); 
    }
    
    
    
    for( int n = 0; n  < 9; n++){
      fill(0);
      text( "Birth", 50, birthChecks[0].y + 10 );
      text( "Survive", 50, surviveChecks[0].y + 10 );
      text( n, birthChecks[n].x,birthChecks[n].y - 5  );
      birthChecks[n].render();        
      surviveChecks[n].render();
    }
  }
}

void keyPressed(){
 ui.checkKeys();
}

void mouseMoved(){
  ui.checkMouse(); 
}

void mousePressed(){
  ui.checkMouse();
}

void mouseReleased(){
  ui.dragging = false;
}

void mouseDragged(){  
  ui.dragging = true;
  ui.checkMouse();
}


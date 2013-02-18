class Cell{
  private boolean alive;
  private boolean liveNext;
  int x;
  int y;
  int sizeX;
  int sizeY;
  Grid grid;
  
  Cell( int i, int j, Grid grid ){
    this.x = i;
    this.y = j;
    this.grid = grid;
    this.alive = false;
  }
  
  Cell(){
    this.alive = false;
  }
  
  void liveNextTurn(){
     this.liveNext = true;
  }
 
  void dieNextTurn(){
    this.liveNext = false;
  } 
  
  void toggle(){
    if( this.isAlive() ){
      this.alive = false;      
    }  
    else{
      this.alive = true;
    }
  }
  
 
  
  boolean isAlive(){
   return this.alive; 
  }
  
  boolean willLive(){
    return this.liveNext;
  }
    
  void live(){
    this.alive = true;
  }
  
  void die(){
    this.alive = false;  
  }
  
  int getNumberOfNeighbors(){
    int neighbors = int(northAlive()) + int(southAlive()) + int(eastAlive()) + int(westAlive()) + int(northWestAlive()) + int(northEastAlive()) + int(southWestAlive()) + int(southEastAlive());
    return neighbors;
  }
  
  void check(){
    int neighbors = getNumberOfNeighbors();
    
    // CASE 1: LIVING CELL LIVES
    if(isAlive() && (surviveChecks[neighbors].isChecked())) {
      this.liveNextTurn();
      population++;
    }
    // CASE 2: DEAD CELL LIVES
    else if (!this.isAlive() && birthChecks[neighbors].isChecked()) {
      this.liveNextTurn();
      population++;
      xborn += this.x;
      yborn += this.y;
      numborn++;
      OscMessage b = new OscMessage("/b");
      b.add(this.x); b.add(this.y);
      oscP5.send(b, receiver);
    }
    // CASE 3: LIVING CELL DIES
    else if (this.isAlive() && !birthChecks[neighbors].isChecked()) { 
      this.dieNextTurn();
      numdied++;
      xdied += this.x;
      ydied += this.y;
      OscMessage d = new OscMessage("/d");
      d.add(this.x); d.add(this.y);
      oscP5.send(d, receiver);
    }
    // CASE 4: DEAD CELL DIES
    else { this.dieNextTurn(); }  
  }
  
  void applyNextState(){
    this.alive = this.liveNext;  
  }
  
  boolean northAlive(){
    return grid.getCell( this.x, this.y - 1 ).isAlive();
  }
  
  boolean southAlive(){
    return grid.getCell( this.x, this.y + 1 ).isAlive();
  }
    
  boolean eastAlive(){
    return grid.getCell( this.x - 1, this.y ).isAlive();
  }
  
  boolean westAlive(){
    return grid.getCell( this.x + 1, this.y ).isAlive();
  }
  
  boolean northWestAlive(){
    return grid.getCell( this.x - 1, this.y - 1 ).isAlive();
  }
  
  boolean southWestAlive(){
    return grid.getCell( this.x - 1, this.y + 1 ).isAlive();
  }
  
  boolean northEastAlive(){
    return grid.getCell( this.x + 1, this.y - 1 ).isAlive();
  }
  
  boolean southEastAlive(){
    return grid.getCell( this.x + 1, this.y + 1 ).isAlive();
  }
   
}


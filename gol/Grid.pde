class Grid{
  
  int columns;
  int rows;
  
  float speed;
  
  Cell[][] cells;
  
  Grid( int columns, int rows ){
      this.columns = columns;
      this.rows = rows;      
      cells = new Cell[columns][rows];
  }
  
  void killAllCells(){       
    for (int i = 0; i < rows; i++ ) {
      for (int j = 0; j < columns; j++ ) {
        cells[i][j].die();
        cells[i][j].dieNextTurn();
      }
    } 
  }

  void randomizeCells( float probability ){   
    for (int i = 0; i < rows; i++ ) {
      for (int j = 0; j < columns; j++ ) {
        cells[i][j] = new Cell(i,j, this);
        cells[i][j].alive = ( random(0,1) > probability ) ? true : false;
      }
    } 
  }
  
  void determineNextCellStates(){
    for (int i = 0; i < rows; i++ ) {
      for (int j = 0; j < columns; j++ ) {
        cells[i][j].check();
      }
    } 
  }
  
  Cell getCell( int i, int j ){
    if( isPointInGrid( i, j ) ){
      return cells[i][j];
    } 
    else{
      return new Cell(i,j,this); 
    }
  }

  void toggleCell( Cell cell ){
      cell.toggle();
      canvas.renderCell( cell );
  }
  
  void updateCellStates(){
    for (int i = 0; i < rows; i++ ) {
      for (int j = 0; j < columns; j++ ) {           
        cells[i][j].applyNextState();
      }
    } 
  }
  
  
  boolean isPointInGrid( int i, int j ){
     if( ( i < rows ) && ( i >= 0 ) && ( j < columns ) && ( j >= 0 ) ){
       return true;
     }
     return false;
  } 
}


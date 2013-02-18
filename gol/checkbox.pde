class Checkbox{

 boolean checked;
 int value;
 public int x, y, size;
 
 Checkbox( int value, int y, int size ){
   this.value = value;
   this.x = 150 + 25 * value;
   this.y = y;
   this.size = size;
 } 
  
 void checkMouse(){
   if(( (mouseX >= this.x) && (mouseX <= (this.x + this.size ))
  &&  (mouseY >= this.y) && (mouseY <= (this.y + this.size) )) 
  && mousePressed ){
   this.toggle(); 
  }
 }
 
 void toggle(){
  this.checked = !this.checked; 
 }
 
 boolean isChecked(){
   return this.checked; 
 }
 
 int getValue(){
  return this.value; 
 }
 
 void render(){
   
   fill( this.checked ? 0 : 255 );
   stroke(0);
  rect( this.x, this.y, this.size, this.size );
 }

}

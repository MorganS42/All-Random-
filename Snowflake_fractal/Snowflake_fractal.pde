int ssize=10;
void setup() {
  fullScreen();  
  background(255);
  snow(width/4,height-width/4,height/2,0);
}

void snow(int x, int y, int size, int ss) {
  noFill();
  triangle(x,y,x+size/2,y-size/1.5,x+size,y);
  if(ss<ssize) {
    //snow();
  }
}
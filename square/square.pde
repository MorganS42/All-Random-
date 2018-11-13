int sqsize=10;
void setup() {
  fullScreen();
  background(255);
  s(width-height,height,height/2,0);
}

void s(int x, int y, int size, int ss) {
  noFill();
  rect(x,y-size,size,size);
  if(ss<sqsize) {
    s(x,y-size,size/2,ss+1);
    s(x+size/2,y-size,size/2,ss+1);
  }
}
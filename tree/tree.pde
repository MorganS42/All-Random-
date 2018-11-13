int[] fib = new int[256];
int x=1;
int y=1;
int oldY;
int l=50;
int t;
int o;
int size=3;
void setup() {
  fullScreen();  
  for(int i=0; i<256; i++) {
    fib[i]=y;
    oldY=y;
    y=x+y;
    x=oldY;
  }
  branch(width/2,height,width/2,0);
}

void draw() {
  //background(255);
}

void branch(int x, int y, int fx, int level) {
  fill(0);
  strokeWeight(10);
  line(x,y,fx,y-l);
  level++;
  y=y-l;
  t=floor(fib[round(level)]/2);
  o=fib[round(level)-1]-t;
  if(level>size) {
     
  }
  else {
    //if(n==fib[round(level)-1]) {
    if(fx>=width/2) {
      if(fx-30>=width/2) {
        branch(fx,y,x-round(random(10,30)),level);
      }
      else {
        branch(fx,y,x+round(random(10,30)),level);
      }
      branch(fx,y,x+round(random(40,100)),level);
    }
    else {
      branch(fx,y,x-round(random(40,100)),level);
      if(fx+30>=width/2) {
        branch(fx,y,x+round(random(10,30)),level);
      }
      else {
        branch(fx,y,x-round(random(10,30)),level);
      }
    }
    //}
  }
}
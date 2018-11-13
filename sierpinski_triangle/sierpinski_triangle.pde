float zoom;
int bx;
int by;
float tsize=8;
void setup() {
  fullScreen();
  //colorMode(HSB, 100);
  zoom=height-1;
  background(255);
  tri(height/3,height-1,zoom,0);
  bx=height/3;
  by=height-1;
}

void draw() {
  if(keyPressed) {
  if(key=='d') {
    bx-=zoom/100;  
  }
  if(key=='a') {
    bx+=zoom/100;  
  }
  if(key=='w') {
    by+=zoom/100;  
  }
  if(key=='s') {
    by-=zoom/100;  
  }
  }
  if(mousePressed) {
    zoom*=1.02;
    tsize*=1.0025; 
  }
  if(key==' ') {
    bx=height/3;
    by=height-1;
    tsize/=1.005;
    zoom/=1.05;
  }
  background(255);
  tri(bx,by,zoom,0);
}


void tri(float x, float y, float size, int ts) {
  //fill((255/tsize)*ts,100,100);
  triangle(x,y,x+size/2,y-size,x+size,y);
  if(ts<tsize && x<width && y>0) {
    tri(x,y,size/2,ts+1);
    tri(x+size/2,y,size/2,ts+1);
    tri(x+size/4,y-size/2,size/2,ts+1);
  }
}
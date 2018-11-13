//float g=9.8;
int sc=1;
Snowflake[] snowArray = new Snowflake[sc];
void setup() {
  fullScreen();
  for(int i=0; i<sc; i++) {
    snowArray[i] = new Snowflake(width/2,height/2,20); //Snowflake(round(random(0,width)),round(random(0,height/2)),20);
  }
}

void draw() {
  background(0);
  for(int i=0; i<sc; i++) {
    snowArray[i].display();  
    snowArray[i].move();  
  }
}

class Snowflake {
  float x;
  float y;
  float speedy=0;
  float speedx=0;
  int size;
  Snowflake() {
    
  }
  Snowflake(int sx, int sy, int ssize) {
    x=sx;
    y=sy;
    size=ssize;
  }
  void display() {
    stroke(255);
    triangle(x,y,x+size/2,y+size,x+size,y);
    line();
  }
  void move() {
    //y+=speedy;
    //x+=speedx;
    speedy=speedy+random(-0.28,0.3);
    speedx=speedx+random(-0.4,0.4);
  }
}
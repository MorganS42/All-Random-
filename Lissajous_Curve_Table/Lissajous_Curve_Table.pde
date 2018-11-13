int amount=4;

float detail=3;

boolean showLines=true;

Curve[][] curves=new Curve[amount][amount];
Dot[] dots = new Dot[amount*2];

void setup() {
  size(800,800);
  
  colorMode(HSB);
  
  for(int i=0; i<amount; i++) {
    float radius=width/(amount+1)/2;
    float cxx=(radius*2)*(i+1.5);
    float cyy=radius;
    radius/=1.1;
    dots[i] = new Dot(cxx,cyy,i+1,radius);  
  }
  for(int i=amount; i<amount*2; i++) {
    float radius=height/(amount+1)/2;
    float cxx=radius;
    float cyy=(radius*2)*((i-amount)+1.5);
    radius/=1.1;
    dots[i] = new Dot(cxx,cyy,i-amount+1,radius);  
  }
  
  for(int i=0; i<amount; i++) {
    for(int o=0; o<amount; o++) {
      curves[i][o]=new Curve();
    }
  }
}

void draw() {
  background(0);
  for(int i=0; i<amount*2; i++) {
    dots[i].update();
    dots[i].dr();
    stroke(200);
    strokeWeight(2);
    if(showLines) {
      if(i<amount) {
        line(dots[i].x+dots[i].cx,dots[i].y+dots[i].cy,dots[i].x+dots[i].cx,height);  
      }
      else {
        line(dots[i].x+dots[i].cx,dots[i].y+dots[i].cy,width,dots[i].y+dots[i].cy);  
      }
    }
  }
  
  for(int i=0; i<amount; i++) {
    for(int o=0; o<amount; o++) {
      if(!(curves[i][o].path.contains(new PVector(dots[i].x+dots[i].cx,dots[o+amount].y+dots[o+amount].cy)))) {
        curves[i][o].setX(dots[i].x+dots[i].cx);
        curves[i][o].setY(dots[o+amount].y+dots[o+amount].cy);
        curves[i][o].addPoint();
        float h=((i+1)*(255/(amount+1))+(o+1)*(255/(amount+1)))/2-10;
        float s=255;
        float b=255;
        stroke(h,s,b);
        //stroke(255);
        curves[i][o].dr();
      }
    }
  }
}

class Curve {
  ArrayList<PVector> path;
  PVector current;
  Curve() {
    path=new ArrayList<PVector>();  
    current=new PVector();
  }
  
  void setX(float x) {
    current.x=x;  
  }
  
  void setY(float y) {
    current.y=y;  
  }
    
  void addPoint() {
    path.add(current);
    current=new PVector();
  }
  
  void dr() {
    strokeWeight(2);
    noFill();
    beginShape();
    for(PVector v: path) {
      vertex(v.x,v.y);   
    }
    endShape();
  }
}

class Dot {
  float cx;
  float cy;
  float s;
  float r;
  float d;
  float a=0;
  float x;
  float y;
  int mode=0;
  float i;
  Dot(float xx, float yy, float speed, float rad) {
    cx=xx;
    cy=yy;
    x=-rad;
    y=-rad;
    s=speed;
    r=rad;
    d=r*2;
  }
  void update() {
    i=s/detail;
    switch(mode) {
      case 0:
        x+=i;
        if(x>=r) {
          x=r;
          mode++;
        }
      break;
      case 1:
        y+=i;
        if(y>=r) {
          y=r;
          mode++;
        }
      break;
      case 2:
        x-=i;
        if(x<=-r) {
          x=-r;
          mode++;
        }
      break;
      case 3:
        y-=i;
        if(y<=-r) {
          y=-r;
          mode=0;
        }
      break;
    }
    a+=i;
  }
  void dr() {
    noFill();
    stroke(255);
    strokeWeight(1);
    ellipse(cx,cy,d,d);
    strokeWeight(5);
    point(cx+x,cy+y);
  }
}
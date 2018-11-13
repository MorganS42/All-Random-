float g=1;
float ng=1;

float ne=0.8;

float gl;

float af=0.8;

boolean random=false;

float cs=80;

int checks=50;

float lx;
float ly;

boolean sort=false;

boolean click=false;

boolean dl=false;

ArrayList<Ball> balls = new ArrayList<Ball>(); 
ArrayList<Line> lines = new ArrayList<Line>(); 
void setup() {
  fullScreen();
  gl=height;
  for(float x=cs/2; x<width; x+=cs) {
      //balls.add(new Ball((pow((x-width/2)/22,2)),height*1.35-x,50,cs,balls.size(),1));  
  }
}

void draw() {
  background(255);
  if(dl) {
    stroke(255,0,0);
    line(lx,ly,mouseX,mouseY);
  }
  
  if(mousePressed) {
    if(!click) {
      if(mouseButton==LEFT) {
        if(random) {
          balls.add(new Ball(mouseX,mouseY,50,random(10,100),balls.size(),random(0,1)));  
        }
        else {
          balls.add(new Ball(mouseX,mouseY,50,cs,balls.size(),ne));    
        }
      }
      else if(mouseButton==RIGHT) {
        if(dl) {
          lines.add(new Line(lx,ly,mouseX,mouseY));      
        }
        else {
          lx=mouseX;
          ly=mouseY;
        }
        dl=!dl;  
      }
    }
    click=true;
  }
  else {
    click=false;  
  }
  
  if(key=='z') {
    lines.add(new Line(lx,ly,mouseX,mouseY));
    lx=mouseX;
    ly=mouseY;
  }
  
  
  if(key=='f') {
    g=0;
  }
  if(key=='g') {
    g=ng;
  }
  
  if(key=='c') {
    balls.add(new Ball(mouseX,mouseY,50,cs,balls.size(),ne));    
  }
  
  if(keyPressed && key==' ') {
    sort=true;  
  }
  
  for(Ball ball : balls) {
    ball.d();  
    for(int i=0; i<checks; i++) {
      ball.u();
    }
  }
  
  for(Line line : lines) {
    line.d();
  }
}

class Ball {
  float x;
  float y;
  float xv=0;
  float yv;
  float xa;
  float ya;
  float m; //Mass (grams)
  float d;
  float r;
  float el;
  int id;
  float mo;
  float fo;
  
  
  float tx;
  float ty;
  float time=0;
  boolean done=false;
  
  Ball(float xx, float yy, float mass, float size, int idd, float e) {
    x=xx;
    y=yy;
    m=mass;
    d=size;
    r=d/2;
    id=idd;
    el=e;
  }
  
  void d() {
    stroke(0);
    fill((float(id)/float(balls.size()))*255);
    ellipse(x,y,d,d);
    
    stroke(255-(float(id)/float(balls.size()))*255);
    
    line(x-r/2,y+r/4,x-r/2,y);
    line(x+r/2,y+r/4,x+r/2,y);
    
    stroke(0);    
    fill(255-(float(id)/float(balls.size()))*255);
    arc(x,y+r/2,d/3,d/3,0,PI);
  }
  
  void u() {
    r=d/2;
    //xa = -xv * af;
    //ya = -yv * af;
    
    xv+=xa/checks;
    yv+=ya/checks;
    x+=xv/checks;
    y+=yv/checks;
   
    if(sort) {
      tx=id*d+r;
      ty=height-((id*d)%height);
      if(round(x)==round(tx)) {
        done=true;  
      }
      else {
        done = false;
        time=0;
      }
      
      if(!done) {
        time+=3;
        if(x>tx) {
          x-=((x-tx)/42+time)/checks;  
        }
        else {
          x+=((tx-x)/42+time)/checks;  
        }
        
        if(y>ty) {
          y-=time/checks;
          yv+=((y-ty)/42+time)/checks;
        }        
      }
    }
   
   
    for(Ball ball : balls) {
      if(!(ball.id==id)) {
        if(pow((ball.x-x),2)+pow((y-ball.y),2)<=pow((r+ball.r),2)) {
          float tdis = sqrt(pow((ball.x-x),2)+pow((ball.y-y),2));
          float tol = (tdis-r-ball.r)/2;
          
          x -= (tol*(x-ball.x)/tdis)/1;
          y -= (tol*(y-ball.y)/tdis)/1;
          ball.x += (tol*(x-ball.x)/tdis)/1;
          ball.y += (tol*(y-ball.y)/tdis)/1;
          
          
          
          
          float nx = (ball.x-x)/tdis;
          float ny = (ball.y-y)/tdis;
          
          float tax=-ny;
          float tay=nx;
          
          float dpt1 = xv * tax + yv * tay;
          float dpt2 = ball.xv * tax + ball.yv * tay;
          
          //xv = tx*dpt1;
          //yv = ty*dpt1;
          //ball.xv = tx*dpt2;
          //ball.yv = ty*dpt2;
        }
      }
    }
    
    for(Line line : lines) {
      float angle=atan((line.y2-line.y1)/(line.x2-line.x1));
      float a=sin(angle)*r;
      float b=cos(angle)*r;
   //   float intersectx = x - cos(angle)*sin(angle)*(line.y2-y-tan(angle)*(line.x2-x));
      
      float tx=x-a;
      float ty=y+b;
      
      if((ty>=tan(angle)*(x-line.x1-a)+line.y1)&&tx>line.x1&&tx<line.x2) {
        if(ty-r<=tan(angle)*(x-line.x1-a)+line.y1) {
          yv=-g;
          y--;
          
          xv+=angle;
        }
        else if(ty-d<=tan(angle)*(x-line.x1-a)+line.y1) {
          y++;  
        }
      }
    }
   
    if(y+r>gl) {
      yv=-yv*el;
      if(yv>-g*3.1) {
        yv=0;  
      }
      y=gl-r;
    }
    else {
      yv+=g/checks;
    }
    
    if(x-r<0) {
      xv=-xv*el;
      x=r;
    }
    
    if(x+r>width) {
      xv=-xv*el;
      x=width-r;
    }
  }
}

int sgn(float x) {
  if(x<0) {
    return -1;  
  }
  else {
    return 1;
  }
}

class Line {
  float x1;
  float y1;
  float x2;
  float y2;
  
  Line(float x, float y, float xx, float yy) {
    if(x<xx) {
      x1=x;
      y1=y;
      x2=xx;
      y2=yy;
    }
    else {
      x1=xx;
      y1=yy;
      x2=x;
      y2=y;  
    }
  }
  
  void d() {
    stroke(0);
    line(x1,y1,x2,y2);
  }
}
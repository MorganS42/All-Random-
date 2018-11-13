int s1 = round(random(1,9));
int s2 = round(random(1,9));
int s3 = round(random(1,9));
int s4 = round(random(1,9));
int s5 = round(random(1,9));
int size=20;
int gl;
int rx;
int ry;
boolean right=false;
float g = 0.98;
float speedX;
float maxX=1;
float speedY;
boolean jump;
int a;

void setup() {
  fullScreen();
  gl = height/2+height/3;
  rx= width/2;
  ry= height/2;
}

void draw() {
  background(255);
  move();
  rock(rx,ry-(size-s1)/2);
  fill(0);
  stroke(0);
  rect(0,gl,width,gl);
}

void rock(int x, int y) {
  fill(80);
  noStroke();
  ellipse(x,y,size+s1,size-s1);
  ellipse(x+s2,y-s5,size-s2,size-s3);
  ellipse(x,y-s4,size-s4,size-s5);
}

void move() {
  rx+=round(speedX);
  ry+=round(speedY);
  if(ry<gl) {
    speedY+=g;  
  }
  else {
    speedY = -(speedY/5);
  }
  if(ry>gl) {
    ry--;  
  }
  if(right) {
    if(speedX>maxX) {
      speedX+=0.1;
    }
    else {
      speedX-=0.08;  
    }
  }
  else {
    if(speedX<-maxX) {
      speedX-=0.1;
    }
    else {
      speedX+=0.08;  
    }
  }
  if(round(random(5))==1) {
    right=!right;    
  }
  if(rx>(width-size*7) || rx<size*7) {
    jump(10);
    right=!right;
  }
  if(rx>=width-size*1) {
    right=false;
    speedX=-speedX/2;    
  }
  if(rx<=size*1) {
    right=true;
    speedX=-speedX/2;    
  }
}

void jump(int l) {
  if(ry>=gl) {
    jump=false;    
  }
  if(jump==false) {
    a++;
    if(a>l) {
      jump=true;
      a=0;
    }
    speedY-=g+0.7;
  }
}
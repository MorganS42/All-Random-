int sc=0;
float g=9.78;
float b=0.8; //bounciness 
boolean a = false;
boolean mouseHelp = false;
slope[] slopeArray = new slope[256];
marble[] marbleArray = new marble[1];


void setup() {
  fullScreen();
  marbleArray[0] = new marble();
  frameRate(25);
}

void draw() {
   background(255);
   
   for(int i=0; i<sc; i++) {
     slopeArray[0].display();
   }
   
   marbleArray[0].display();
   marbleArray[0].move();
   marbleArray[0].collision();
   
      
   if (mousePressed && (mouseButton==LEFT) && !mouseHelp) {
     sc++;
     slopeArray[sc-1] = new slope();
     print(sc);
     mouseHelp = true;
     slopeArray[sc-1].x1=mouseX;
     slopeArray[sc-1].y1=mouseY;
   }
   if(mousePressed &&  (mouseButton==LEFT) && mouseHelp) {
     slopeArray[sc-1].x2=mouseX;
     slopeArray[sc-1].y2=mouseY;
   }
   if(mousePressed && (mouseButton==RIGHT) && mouseHelp) {
     mouseHelp=false;
   }
}

class slope {
  float ydiff, xdiff, mdiff;
  int x1;
  int y1;
  int x2;
  int y2;
  
  slope() {
    
  }
  
  void display() {
    ydiff = y2-y1;
    xdiff = x2-x1;
    mdiff = x2-marbleArray[0].mx;
    fill(0);
    line(x1,y1,x2,y2);
  }
}

class marble {
  int mx;
  int my;
  float xSpeed;
  float ySpeed;
  float mb; //bounciness
  int size;
   
  marble() {
    size=20;
  }
  
  void display() {
    fill(100);
    ellipse(mx,my,size,size);
  }
  
  void move() {
    mx=mx+round(xSpeed);
    my=my+round(ySpeed);
    if(keyPressed) {
      mx=mouseX;
      my=mouseY;
      mb=0.9;
      ySpeed=0;
      xSpeed=0;
    }
  }
  
  void collision() {
  for(int i=0; i<sc; i++) { 
    if(slopeArray[i].x1<slopeArray[i].x2) {
      if(mx<slopeArray[i].x2 && mx>slopeArray[i].x1) {
        a=true;
      }
      else {
        a=false; 
      }
    }
    else {
      if(mx>slopeArray[i].x2 && mx<slopeArray[i].x1) {
        a=true;
      }
      else {
        a=false; 
      }
    }
    
    if((slopeArray[i].x2-slopeArray[i].x1)*(slopeArray[i].x2-mx)==0) {
       
    }
    else {
      println(mx,my + round(size/2), slopeArray[i].x1, slopeArray[i].y1,slopeArray[i].x2, slopeArray[i].y2, slopeArray[i].ydiff, slopeArray[i].xdiff, slopeArray[i].mdiff, slopeArray[i].ydiff/slopeArray[i].xdiff*slopeArray[i].mdiff);
      if(my+round(size/2)<(slopeArray[i].y2-round(slopeArray[i].ydiff/slopeArray[i].xdiff*slopeArray[i].mdiff))) {
         ySpeed=ySpeed+g/frameRate;
      
      // ((slopeArray[i].y2-slopeArray[i].y1)/(slopeArray[i].x2-slopeArray[i].x1)*(slopeArray[i].x2-mx)))) 
      }
      else {
        if(a) {
          while(!(my+round(size/2)<(slopeArray[i].y2-round(slopeArray[i].ydiff/slopeArray[i].xdiff*slopeArray[i].mdiff)))) {
            my=my-1;
          }
          xSpeed=xSpeed+ySpeed*mb*b*sin(atan(slopeArray[i].ydiff/slopeArray[i].xdiff));
          ySpeed=0-ySpeed*mb*b*cos(atan(slopeArray[i].ydiff/slopeArray[i].xdiff));
        }
      }
    }
    }
  }
  }
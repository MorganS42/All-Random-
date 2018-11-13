boba[] bobaArray = new boba[2048];
int bobaCount = 10;

void setup() {
  fullScreen();
  frameRate(10);
  for(int i=0; i<2048; i++) {
    bobaArray[i] = new boba(round(random(width)),round(random(height))); 
  }
}

void draw() {
  background(255);
  for(int i=0; i<bobaCount; i++) {
    bobaArray[i].display();
    bobaArray[i].ai();
  }
}

class boba {
  float x;
  float y;
  int size = round(random(8,25));
  int ca=round(random(255));
  int cb=round(random(255));
  int cc=round(random(255));
  int id;
  int speed;
  boolean wtb=false;
  
  boba() {
    
  }
  
  boba(int bx, int by) {
    x=bx;
    y=by;
    id=round(random(2048));
  }
  
  void display() {
    fill(ca,cb,cc);
    ellipse(x,y,size,size);
  }
  
  void ai() {

    
    speed=ceil(size/(random(4,6)));
    
    for(int i=0; i<2048; i++) {
      if(id==bobaArray[i].id) {
        id=round(random(2048));
      }
    }
    
    for(int i=0; i<bobaCount; i++) {
      if(x>width-size) {
        x--; 
      }
      if(x<size) {
        x++; 
      }
      if(y>height-size) {
        y--; 
      }
      if(y<size) {
        y++; 
      }
      if(wtb==true) {
        if(bobaArray[i].wtb==true && !(bobaArray[i].id==id)) {
            if(bobaArray[i].x>x) {
              x+=speed; 
            }
            else  {
              x-=speed; 
            }
            
            if(bobaArray[i].y>y) {
              y+=speed; 
            }
            else  {
              y-=speed; 
            }
            
            if(bobaArray[i].x<x+size/2 && bobaArray[i].x>x-size/2 && bobaArray[i].y<y+size/2 && bobaArray[i].y>y-size/2) {
              bobaCount++;
              size=size-10;
              bobaArray[i].size-=10;
              bobaArray[bobaCount].ca-=(bobaArray[i].ca+ca)/2;
              bobaArray[bobaCount].cb-=(bobaArray[i].cb+cb)/2;
              bobaArray[bobaCount].cc-=(bobaArray[i].cc+cc)/2;
              wtb=false;
              bobaArray[i].wtb=false;
            }
        }
      }
    else {
      if(round(random(10))==1 && size>20) {
        wtb=true; 
      }
      if(size<20) {
        wtb=false; 
      }
      if(bobaArray[i].x<x+size/2 && bobaArray[i].x>x-size/2 && bobaArray[i].y<y+size/2 && bobaArray[i].y>y-size/2) {
        if(bobaArray[i].size<size) {
          size++;
        }
        if(bobaArray[i].size>size) {
          size--; 
        }
      }
    
      if(bobaArray[i].size<size) {
        //while(!(bobaArray[i].x<x+size/2 && bobaArray[i].x>x-size/2 && bobaArray[i].y<y+size/2 && bobaArray[i].y>y-size/2)) { //int a=0; a<dist(bobaArray[i].x,bobaArray[i].y,x,y); a++
          if(bobaArray[i].x>x) {
            x+=speed; 
          }
          else {
            x-=speed;
          }
          if(bobaArray[i].y>y) {
            y+=speed; 
          }
          else {
            y-=speed;
          }
        //}
      }
      else {
          if(bobaArray[i].x>x) {
            x-=speed; 
          }
          else {
            x+=speed;
          }
          if(bobaArray[i].y>y) {
            y-=speed; 
          }
          else {
            y+=speed;
          }
      }
      
    }
  }
}
}
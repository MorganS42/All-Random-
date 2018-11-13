int groundY = 500;
int mc = 0; //mc = mouseCount
boolean right = true;
cat[] catArray = new cat[1]; 
mouse[] mouseArray = new mouse[1];

void setup() {
  noFill();
  size(1000,600);
  catArray[0] = new cat(width/2,groundY, 20);
  mouseArray[0] = new mouse(width/2,groundY, 20);
}

void draw() {
   background(255);
   fill(0);
   rect(0,groundY,width,height);
   catArray[0].display();
   catArray[0].AI();
   catArray[0].move();
   if(mc>0) {
     for(int i=0;i<mc;i++) {
       //print(mouseArray[i]);

       //print(mc);
       //mouseArray[i].move();
     }
   }
   
   if(keyPressed) {
     if(key==' ') {
       mc++;
       
       mouseArray = new mouse[mc];
       mouseArray[0] = new mouse(mouseX,mouseY,5);
       //print(mouseArray[1]);
     }
   }
}

class cat {
  int x;
  float xSpeed = 0;
  int y;
  float ySpeed = 0;
  int size;
  
  cat () {
    
  }
  
  cat (int cx, int cy, int csize) {
    x = cx;
    y = cy;
    size=csize;
  }
  
  void display() {
    fill(100);
    rect(x-size,y-size,size/10,size); 
    rect(x+size,y-size,size/10,size); 
    rect(x-size,y-size*2,size*2.1,size);
    if(right==true) {
      ellipse(x+size*1.6,y-size*2.5,size*1.4,size*1.4);
    }
    else {
      ellipse(x-size*1.6,y-size*2.5,size*1.4,size*1.4);
    }
  }
  
  void AI () {
    if(mouseX>x && mouseX<x+size*2.1 && mouseY>y-size*2 && mouseY<y+size) {
      ySpeed=ySpeed-4;
      if(round(random(1,2))==1) {
        xSpeed=xSpeed+6;
        right=true;
      }
      else {
        xSpeed=xSpeed-6;
        right=false;
      }
    }
    
    //if(==true) {
      
    //}
    
    if(mousePressed) {
      x=mouseX;
      y=mouseY;
    }
  }
  
  void move() {
    x=round(x+xSpeed);
    y=round(y+ySpeed);
    if(y<groundY) {
      ySpeed=ySpeed+1; 
    }
    else {
      y=groundY;
      ySpeed=0-ySpeed/1.2; 
    }
    
    if(!(mouseX>x && mouseX<x+size*2.1 && mouseY>y-size*2 && mouseY<y+size)) {
      xSpeed=xSpeed/1.2;
    }
    
    if(x<0+size || x>width-size*2.4) {
       xSpeed=0-xSpeed;
    }
  }
}

class mouse {
  int x;
  int y;
  int size;
  int xSpeed;
  int ySpeed;
  mouse() {
    
  }
  
  mouse(int mx, int my, int msize) {
    x=mx;
    y=my;
    size=msize;
    this.AI();
    this.display();
  }
  void display() {
    fill(200);
    ellipse(x,y,size,size);
  }
  
  void AI() {
    
  }
}
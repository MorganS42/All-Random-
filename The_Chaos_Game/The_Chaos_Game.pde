int sides=3;
int vps = 3;
float ms = 7.8;
float q=1;
int size=200;
float[] xs = new float[sides*fact(vps)];
float[] ys = new float[sides*fact(vps)];
ArrayList<Point> p = new ArrayList<Point>();
int s=0;

int r;
int oldr;
int oor;

float x;
float y;

float tx;
float ty;

int et = 0;

void setup() {  
  fullScreen();  
  background(0);
  
  su();
}

void draw() {
  //background(0);
  for(Point po : p) {
    po.display();
    if(keyPressed && key=='q') {
      po.fun();
    }
  }
  
  if(mousePressed) {
    background(0);
    p = new ArrayList<Point>();
    size=round(size*1.2);
    su();
  }
  

  
  if(keyPressed) {
    if(key=='w') {
      ty+=ms;
      p = new ArrayList<Point>();
      background(0);
    }
    
    if(key=='a') {
      tx+=ms;
      p = new ArrayList<Point>();
      background(0);
    }
    
    if(key=='s') {
      ty-=ms;
      p = new ArrayList<Point>();
      background(0);
    }
    
    if(key=='d') {
      tx-=ms;
      p = new ArrayList<Point>();
      background(0);
    }
    
    if(key==' ') {
      q*=5;  
    }
  }
  
  for(int i=0; i<size*q; i++) {
    r=floor(random(sides*vps));
    switch(et) {
      case 0:
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      case 1:
        if(r==oldr) {
          r++;
          if(r>=sides) {
            r=oldr-1;  
          }
        }
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      case 2:
        if(r==oldr+2 || r==oldr-2) {
          r++;
          if(r>=sides) {
            r-=2;  
          }
        }
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      case 3:
        oor=oldr;
        oldr=r;
        x=(x+xs[r]*2)/3;
        y=(y+ys[r]*2)/3;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      case 4:
        if(r==oldr+1 || r==oldr-1) {
          r++;
          if(r>=sides) {
            r=oldr-1;  
          }
        }
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      case 5:
        if(r==oldr-1 || (r==3 && oldr==0)) {
          r++; 
          if(r>=sides) {
            r-=2;
          }
        }
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;
      /*case 6:
        if() {
          r++; 
          if(r>=sides) {
            r-=2;
          }
        }
        oor=oldr;
        oldr=r;
         
      break;
      case 7:
        if() {
          r++; 
          if(r>=sides) {
            r-=2;
          }
        }
        oor=oldr;
        oldr=r;
        x=(x+xs[r])/2;
        y=(y+ys[r])/2;
        p.add(new Point(round(x+tx),round(y+ty)));
      break;*/
    }
  }
}

int fact(int n) {
 if (n <= 1) {
   return 1;
 }
 else {
   return n * fact(n-1);
 }
} 

void su() {
  x=width/2;
  y=height/2;
  
  s=0;
  float angle = TWO_PI / sides;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = width/2 + cos(a) * size;
    float sy = height/2 + sin(a) * size;
    stroke(0);
    xs[s]=sx;
    ys[s]=sy;
    s++;
    if(s>=sides) {
      s=0;  
    }
  }
  
  for(int i=1; i<vps; i++) {
    for(int a=1; a<sides*i; a++) {
      xs[sides*i+a-1]=(xs[sides*(i-1)+a-1]+xs[sides*(i-1)+a])/2;
      ys[sides*i+a-1]=(ys[sides*(i-1)+a-1]+ys[sides*(i-1)+a])/2;  
    }
    xs[sides*(i+1)-1]=(xs[sides*(i)-1]+xs[0])/2;
    ys[sides*(i+1)-1]=(ys[sides*(i)-1]+ys[0])/2;  
  }
  
  for(int i=0; i<sides*vps; i++) {
    ellipse(xs[i],ys[i],10,10);
  }  
}

class Point {
  int x;
  int y;
  
  Point(int xl,int yl) {
    x=xl; 
    y=yl;
  }
  
  void fun() {
    if(x>mouseX) {
      tx--;
      x--;
    }
    if(x<mouseX) {
      tx++;
      x++;
    }
    if(y>mouseY) {
      ty--;
      y--;
    }
    if(y<mouseY) {
      ty++;
      y++;
    }
  }  
  void display() {
    stroke(100,0,180);
    point(x,y);    
  }
}
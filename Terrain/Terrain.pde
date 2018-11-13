int cols,rows;
int scale=20;
int w=5000;
int h=1200;
float[][] ter;
float flyingY=0;
float flyingX=0;
boolean stroke=false;
boolean water;

int tlh=50;           //tlh = tree likelihood.   Defualt=50

int wl=0;          //wl = water level.        Defualt=-150
int wlh=-wl+450;      //wlh = water liklihood.   Defualt=600 || -wl+450
int ml=500;           //ml = mountain level.     Defualt=500
int mlh=300;          //mlh = mountain liklihood.Defualt=300

void setup() {
  fullScreen(P3D,1);
  cols=w/scale;
  rows=h/scale;
  ter=new float[cols][rows];
  float yoff=0;
  for(int y=0; y<rows; y++) {
    float xoff=0;
    for(int x=0; x<cols; x++) {
      ter[x][y] = map(noise(xoff,yoff),0,1,wlh,ml);
      if(ter[x][y]>-150 && round(random(tlh))==1) {
        
      }
      else {
        
      }
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  //colorMode(HSB);
}

void draw() {
  switch(key) {
    case CODED:
      switch(keyCode) { 
        case UP: 
          flyingY -= 0.03;
          break;
        case DOWN:
          flyingY += 0.03;
          break;
        case RIGHT: 
          flyingX += 0.03;
          break;
        case LEFT:
          flyingX -= 0.03;
          break;
    }
    break;
    case 'w':
      flyingY -= 0.3;
      break;
    case 's':
      flyingY += 0.3;
      break;
    case 'a':
      flyingX -= 0.3;
      break;
    case 'd':
      flyingX += 0.3;
      break;
  }
  if(mousePressed) {
    //ter[][]+=200;  
  }
  if(keyPressed && keyCode==SHIFT) {
    scale++;
  }
  if(keyPressed && key==' ') {
    scale--;
  }
  if(keyPressed && key=='n') {
    stroke=true;  
  }
  if(keyPressed && key=='m') {
    stroke=false;  
  }
  
  
  
  float yoff=flyingY;
  for(int y=0; y<rows;) {
    float xoff=flyingX;
    for(int x=0; x<cols;) {
      ter[x][y] = map(noise(xoff,yoff),0,1,-700,500);
      xoff += 0.1;
      x++;
    }
    yoff += 0.1;
    y++;
  }
  
  if(stroke) {
    stroke(255);  
  }
  else {
    noStroke();
  }
  background(150,150,255);
  
  translate(w/2,h/2+300);
  rotateX(PI/3);
  translate(-w,-h/2);
  for(int y=0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for(int x=0; x<cols; x++) {
      water=false;
      //if(ter[x][y]==1) {
      //  fill(255,0,0);  
      //}
      //else {
        if(ter[x][y]>ml-mlh) {
          fill(255);  
        }
        else {
          if(ter[x][y]>ml-(mlh*1.5)) {
            fill(200-ter[x][y]);  
          }
          else {
            if(ter[x][y]>ml-(mlh*1.5)-40) {
              fill(0,100-ter[x][y],0);
            }
            else {
              if(ter[x][y]>wl+30) {
                fill(255,255,0);  
              }
              else {
                water=true;
                fill(0,0,255+ter[x][y]/2.5);
              }
            }
          }
        }
      //}
      if(water) {
        vertex(x*scale,y*scale,wl);
        vertex(x*scale,(y+1)*scale,wl);
      }
      else {
        vertex(x*scale,y*scale,ter[x][y]);
        vertex(x*scale,(y+1)*scale,ter[x][y+1]);
      }
    }
    endShape();
  }
}
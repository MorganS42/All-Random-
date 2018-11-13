float t = 1;
float e = 1;
float d = 25;
float rcx;
float ellx;
float elly;
boolean debug = false;
boolean cdebug = true;
float g = 0.3;
float v = 0;
float v2 = 0.5;
int groundy = height-80;
float rcy = random(0,groundy-40);
float rcs = random(20,40);
int gvar;
int myvar; 
int carrots = round(random(5,60));
int food = 20;
float[] carrotX = new float[carrots];
float[] carrotY = new float[carrots];
float[] carrotSize = new float[carrots];

int rabbits = round(random(1,food/2.5));
float[] rabbitX = new float[rabbits];
float[] rabbitY = new float[rabbits];
float[] rabbitSize = new float[rabbits];


public class Carrots {
    float cx;
    float cy;
    float cs;
    Carrots() {
    }
    Carrots(x,y) {
      x = cx;
      y = cy;
      cs = random(20,40);
    }
    fill(240,134,8);
    rect(cx,cy,cs,cs*2.5,7);
    fill(37,209,52);
    ellipse(cx+(cs)/2,(cy-(cs/2))+(cs/3),cs*1.5,cs*1.5);
}

public class Rabbits {
  float rx;
  float ry;
  float rs;
  int rhealth;
  int rdamage;
  float rvy = 0;
  float rvx = 0;
  Rabbits() {
  }
  Rabbits(x,y) {
    x = cx;
    y = cy;
    rs = random(20,50);
    rhealth = round (random((cs/3)-5,cs/3));
    rdamage = round (random((cs/3)-5,(cs/3)+5));
  }
  noFill();
  ellipse(rx,ry,rs,rs);
  fill(0);
  ellipse((rx+rs/8),ry,rs/8,rs/8);
  ellipse((rx-rs/8),ry,rs/8,rs/8);
  void update() {
    if (elly > ry+10) {
      rjump(); 
    }
    
    
    if (ellx > rx) {
      rx = rx + size/3; 
    }
    else {
      rx = rx - size/3 
    }
    
    if (((rx-(size/2)) < ellx && ((rx+(size/2)) > ellx)   //finish if for y nad add in {}
    
    rvy = rvy + g;
    ry = ry + rvy;
    if (ry-rs < groundy) {
      rBounce();
    }
  }
  void rjump () {
    rvy = -(rs/5);
  }
  void rBounce() {
    rvy = (-rvy);
    rvy = rvy+v2;
  }
}

void setup () {
  size(1000,800);
  PFont f = createFont("Arial",16,true);
  textFont(f,16);   
  for(int i=0; i<carrots; i=i+1) {
    carrotX[i] = random(0,width);
    carrotY[i] = random(0,height-groundy-100);
    carrotSize[i] = random(20,40);
  }
  for(int i=0; i<rabbits; i=i+1) {
    rabbitX[i] = random(0,width);
    rabbitY[i] = random(height-groundy-random(60,80),height-groundy-50);
    rabbitSize[i] = random(20,40);
  }
}

void draw() {
  background(255);
  fill(0); 
  int groundy = height-80;
  rect(0,groundy+20,width,height-groundy);
  int x = width/2;
  int y = height/8;
  int radius = 75;
  stroke(0);
    if (debug == true)
  {
    t = mouseX-x;
    e = mouseY-y;
    debug = false;
  }
  
  fill(0);
  textFont(f,16);
  text ("Food: "+ food,20,20);
  
  if (round(random(1,50))==1) {
    food = food - 1;
  }
    if (round(random(1,2000)) == 1) {
      int carrots = round(random(20,80));
      for(int i=0; i<carrots; i=i+1) {
        carrotX[i] = random(0,width);
        carrotY[i] = random(0,groundy-100);
        carrotSize[i] = random(20,40);
      }
  
  }
  
  if(food<0) {
    PFont f = createFont("Arial",100,true);
    textFont(f,100); 
    fill(0);
    text("YOU LOSE!!!",(width/2)-280,height/2);
    stop(); 
  }
  if(food>100) {
    PFont f = createFont("Arial",100,true);
    textFont(f,100); 
    fill(0);
    text("YOU WIN!!!",(width/2)-280,height/2);
  }
  
  
    ellx = x+t;
    elly = y+e;
  for (int i=0; i<300; i+=radius - 12){
    if (food>50) {
      fill(240,134,8);
    }
    else {
    noFill();
    }
    if (!(food<20)) {
      ellipse(ellx,elly+i,round(radius*(food/20)),radius);
    }
    else {
      ellipse(ellx,elly+i,radius-15,radius);
    }
    if (i>0) {
       for(int z=0;z<3;z++) {
          Button(ellx, (elly+i)-(radius/4)+(z*(radius/4)), 10);
       }
    }
    radius+= d;
  }
  fill(0);
    if (!(food<20)) {
       ellipse((ellx+radius/8*(food/20)),elly,radius/8,radius/8);
       ellipse((ellx-radius/8*(food/20)),elly,radius/8,radius/8);
    }
    else {
       ellipse((ellx+radius/8),elly,radius/15,radius/15);
       ellipse((ellx-radius/8),elly,radius/15,radius/15);
    }

  
  for(int i=0; i<carrots; i=i+1) {
    if (!(carrotX[i] == 0 && carrotY[i] == 0)) {
      carrot(carrotX[i], carrotY[i],carrotSize[i]);
    }
  }
  
  for(int d=0; d<rabbits; d=d+1) {
    rabbit(rabbitX[d],rabbitY[d],rabbitSize[d]);
  }

      
  if (mouseX>=x+t && ellx !=width-65) {  
    if (keyPressed) {
      if (key == ' ') {
          t = t+(width/400)+10;     
      }
    }
    else {
      t= t+(width/400);
    }
  }
  
  
  else if (mouseX<=x+t && ellx !=65) {
    if (keyPressed) {
      if (key == ' ') {
          t = t-(width/400)-10;     
      }
    }
    else {
      t = t-(width/400); 
    }
  }
  
  else if (mouseX==x+t) {
    ellx = mouseX;
  }
  
  
  if (mouseX<=x+t && ellx <= 65 || mouseX>=x+t && ellx >= width-65) {
    t = -t; 
  }

  gvar = groundy;
  myvar = radius;
  if (elly+(radius + (4*d)) >= groundy) {
    bounce();
  }
  else {   
    v = v+g;
  }
  e = e+v;
  
  if (elly+(myvar + (4*d))>gvar +20) {
    e = -((height/2-groundy)-40);
    v = 0;
  }
  
  for (int b=0; b<carrots; b=b+1) {
    if (ellx >= carrotX[b] && ellx <= carrotSize[b]+carrotX[b] && elly >= carrotY[b] && elly <= carrotSize[b]*2.5+carrotX[b]) {
        carrotX[b] = 0;
        println("aaaaaaaaaaaaaaaaaaa" + carrotSize[b]);
        carrotY[b] = 0;
        if (round(random(1,10))==1) {
          food = food + round(random(3,10));
        }
        else {
          food = food + 1; 
        }
    }
  }
}

/*void mousePressed() {
  debug = true;
}
void Button(float bx, float by, float bsize) {
  fill(150);
  ellipse(bx,by, bsize, bsize);
  fill(255);
  ellipse(bx+bsize/5,by,bsize/4,bsize/4);
  ellipse(bx-bsize/5,by,bsize/4,bsize/4);
}*/

void bounce() { //<>//
  v = (-v);
  v = v+v2;
}
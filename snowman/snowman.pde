int t = 1;
int d = 25;
void setup () {
  size(400,400);
}
//Use t as RATE OF CHANGE, not additive constant
void draw() {
  background(255);
  int x = width/2;
  int y = height/8;
  int radius = width/5;
  stroke(0);
  fill(0);
  ellipse(x+t+radius/4,y,radius/6,radius/6);
  ellipse(x+t-radius/4,y,radius/6,radius/6);
  for (int i=0; i<height - height/4; i+=radius - 12){
    noFill();
    ellipse(x+t,y+i,radius,radius);
    if (i>0) { //<>//
       for(int z=0;z<3;z++) { //<>//
          Button(x+t, (y+i)-(radius/4)+(z*(radius/4)), 10); //PROBLEM IN THE Y COORDINATE STATEMENT //<>//
       }
    }
    radius+= d;
  }
  t +=1;
  if (x+t==width) {  
    t= -t;
  }
   delay(10);
}

void Button(float bx, float by, float size) {
  fill(150);
  ellipse(bx,by, size, size);
  fill(255);
  ellipse(bx+size/5,by,size/4,size/4);
  ellipse(bx-size/5,by,size/4,size/4);
}
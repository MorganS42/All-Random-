float t = 1;
float e = 1;
float d = 25;
float ellx;
float elly;
boolean debug = false;
float g = 0.3;
float v = 0;
float v2 = 0.5;

void setup () {
  size(800,800);
}

//Use t as RATE OF CHANGE, not additive constant
void draw() {
  background(255);
  int groundy = height-50;
  fill(0);
  rect(0,groundy,width,height-groundy);
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
    ellx = x+t;
    elly = y+e;
  ellipse(ellx+radius/4,elly,radius/6,radius/6);
  ellipse(ellx-radius/4,elly,radius/6,radius/6);
  for (int i=0; i<300; i+=radius - 12){
    noFill();
    ellipse(ellx,elly+i,radius,radius);
    if (i>0) {
       for(int z=0;z<3;z++) {
          Button(ellx, (elly+i)-(radius/4)+(z*(radius/4)), 10);
       }
    }
    radius+= d;
  }

  if (mouseX>=x+t && ellx !=width-65) {  
    t= t+(height/400); //problem with line 35 and 38 to do with stopping snowman.
  }
  else if (mouseX<=x+t && ellx !=65) {
    t = t-(height/400); 
  }
  else if (mouseX==x+t) {
    ellx = mouseX;
  }

/*  if (mouseY>=y+e+(radius/2) && elly != 490) {  
    e= e+(width/400);
  }
  else if (mouseY<=y+e+(radius/2) && elly !=40) {
    e = e-(width/400); 
  }
   else if (mouseY==y+e) {
    elly = mouseY;
  }
  */

  if (elly+(radius + (4*d)) >= groundy) {
    bounce();
    if (elly >= groundy) { //<>//
      println("we died");
    }
  }
  else {   
    v = v+g;
  }
    e = e+v;
 
 // println(elly);
 
}

void mousePressed() {
  debug = true;
}
void Button(float bx, float by, float size) {
  fill(150);
  ellipse(bx,by, size, size);
  fill(255);
  ellipse(bx+size/5,by,size/4,size/4);
  ellipse(bx-size/5,by,size/4,size/4);
}

void bounce() { //<>//
 // println("aaaaaaaaaaa");
  v = (-v); //<>//
  v = v+v2; //<>//
  v2 = v2+0.5;
}
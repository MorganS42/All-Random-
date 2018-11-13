float curvex=1;
float curvey=1;
void setup() {
  fullScreen();
  background(255);
}
void draw() {
  curvex=mouseX/10;
  curvey=mouseY/100;
  background(255);
  for(int i=0; i<height; i+=10) {
    //stroke(random(255),random(255),random(255));
    line(0,i*curvey,i*curvex,height);
  }  
}
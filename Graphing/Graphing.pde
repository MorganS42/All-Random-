float ox=4242;
float oy=42;

float zoom=100;
float a=2;
void setup() {
  fullScreen();
}

void draw() {
  ox=width/2;
  oy=height/2;
  background(255);
  strokeWeight(1);
  line(width/2,0,width/2,height);
  line(0,height/2,width,height/2);
  for(float x=-width/2; x<width/2; x+=1/a) {
    for(float y=-height/2; y<height/2; y+=1/a) {
      if(round(sin(x/zoom)+cos(y/zoom))==1) { //if(y/zoom==pow(x/zoom,x/zoom)) { //if(round(pow(y/zoom,2)+2*pow(x/zoom,2))==256) {//if(pow(x/zoom,2)+pow(y/zoom,2)==4) {
        strokeWeight(1);
        point(x+width/2,height-(y+height/2));
        if(!(ox==4242 && oy==42)) {
          //line(x+width/2,height-(y+height/2),ox,height-oy);    
        }
        ox=x+width/2;
        oy=y+height/2;
      }
    }
  }
}

int fact(int num){
   if (num == 1){
      return 1;
   } 
   else {
      return num*fact(num - 1);
   }
}
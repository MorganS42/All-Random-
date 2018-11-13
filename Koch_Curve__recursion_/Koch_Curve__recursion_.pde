int amount = 2;
float count;
void setup() {
  fullScreen();
  background(0);
  l(new PVector(0,height/2),new PVector(width,height/2));
}

void draw() {
    
}

void l(PVector start, PVector end) {
  stroke(255);
  line(start.x,start.y,end.x,end.y);
  
  count+=0.25;
  
  PVector a=new PVector((end.x)/3,end.y);
  PVector b=new PVector((a.x)*2,end.y);
  PVector c=new PVector((end.x)/2,end.y-10);
  
  if(count<amount) {
    l(start,a);
    l(a,c);
    l(c,b);
    l(b,end);
  }
}
int y=106;
int a;
int b;
void setup() {
  size(1060,170); 
  background(255);
}
void draw() {
  for(int i=0; i<17; i++) {
    for(int z=y; z<106+y; z++) {
      a=floor(i/17);
      b=-17*floor(z)-(floor(i)%17);
      if(1/2<floor((pow(a*2,b))%2)) {
        fill(0);
        rect(z,i,10,10); 
      }
    }
  }
}
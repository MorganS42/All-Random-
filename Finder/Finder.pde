int s=6;
float gs[][] = new float[s+6][s+6];
float na[][] = new float[s+6][s+6];

void setup() {
  size(1000,1000);
  for(int x=0; x<s; x++) {
    for(int y=0; y<s; y++) {
      gs[x][y]=random(1);
    }
  }
}

void draw() {
  background(255);
  for(int x=3; x<s+3; x++) {
    for(int y=3; y<s+3; y++) {
      fill(gs[x][y]*255,gs[x][y]*255,gs[x][y]*255);
      rect(x*(width/s),y*(width/s),width/s,width/s);
      fill(0);
      ellipse(x*(width/s)+width/s/2,y*(width/s)+width/s/2,donut(x,y)*2,donut(x,y)*2);
    }    
  }    
}

float donut(int a,int b) {
  float s=0;
  for(int x=a-2; x<a+3; x++) {
    for(int y=b-2; y<b+3; y++) {
      if(((x==a-1 || x==a || x==a+1) && y==b-1) || ((x==a-1 || x==a+1) && y==b) || ((x==a-1 || x==a || x==a+1) && y==b+1)) {
        s+=gs[x][y];    
      }
      else if(x==a && y==b) {
        s+=-gs[x][y];  
      }
      else if(!((x==a-2 && y==b-2) || (x==a-2 && y==b+2) || (x==a+2 && y==b-2) || (x==a+2 && y==b+2))) {
        s+=-gs[x][y];  
      }
    }
  }
  return s;
}
int vert=7;
int[] xpoints = {0,40,40,70,50,30,0};
int[] ypoints = {20,0,20,50,70,50,50};
int[][] points = new int[256][2];
int[][] p = new int[256][2];
int[] g = new int[vert];
void setup() {
  fullScreen();
  for(int i=0; i<vert; i++) {
    int[] t = {xpoints[i],ypoints[i]};
    if(i==0) {
      points[i][0]=xpoints[i];
      points[i][1]=ypoints[i];
    }
    else {
      points[i][0]=xpoints[i]+points[i-1][0];
      points[i][1]=ypoints[i]+points[i-1][1];
    }
    p[i]=t;
  }
}

void draw() {
  translate(width/2,height/2);
  for(int i=0; i<vert; i++) {
    fill(0);
    line(p[i+1][0],p[i+1][1],p[i][0],p[i][1]);
  }
  for(int i=0; i<vert; i++) {
    
  }
}
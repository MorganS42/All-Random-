int s=5;

int a[][];
int ta[][];

void setup() {
  fullScreen(); //size(800,800);
  a=new int[width/s][height/s];
  ta=new int[width/s][height/s];
  
  for(int x=0; x<width/s; x++) {
    for(int y=0; y<height/s; y++) {
      a[x][y]=0;
      //a[x][y]=round(random(1));
    }
  }
  
  for(int i=0; i<width/s; i+=5) {
    dp(1,i,5);
  }
  //dp(0,5,5);
}

void draw() {
  background(255);
  noStroke();
  for(int x=0; x<width/s; x++) {
    for(int y=0; y<height/s; y++) {
      if(a[x][y]==0) {
        fill(0);
      }
      else {
        fill(255);
      }
      rect(x*(s),y*(s),s,s);  
    }    
  }
  for(int g=0; g<1; g++) {
    generate();
    for(int i=0; i<width/s; i++) {
      for(int j=0; j<height/s; j++) {
        a[i][j]=ta[i][j];  
      }
    }
  }
}

void generate() {
  for(int x=1; x<width/s-1; x++) {
    for(int y=1; y<height/s-1; y++) {
      
      int n=0;
      for(int q=-1; q<2; q++) {
        for(int w=-1; w<2; w++) {
          n+=a[q+x][w+y];  
        }
      }
      n-=a[x][y];
      
      if(n==3) {
        ta[x][y]=1;  
      }
      else if(n>3) {
        ta[x][y]=0;
      }
      else if(n<2) {
        ta[x][y]=0;
      }
      else {
        ta[x][y]=a[x][y];  
      }
    }
  }   
}

void dp(int n,int x,int y) {
  switch(n) {
    case 0:
      a[x][y]=1;
      a[x+1][y]=1;
      a[x-1][y]=1;
    break;
    
    case 1:
      a[x][y]=1;
      
      a[x+1][y-2]=1;
      a[x+1][y]=1;
      
      a[x+2][y-1]=1;
      a[x+2][y]=1;
    break;
    
    case 2:
      
  }
}
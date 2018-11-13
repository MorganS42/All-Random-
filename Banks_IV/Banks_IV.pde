int s=18;
int step=0;

int arr[][]=new int[s][s];
int tarray[][]=new int[s][s];

void setup() {
  size(800,800);
  frameRate(1);
  for(int x=0; x<s; x++) {
    for(int y=0; y<s; y++) {
      arr[x][y]=2;
      tarray[x][y]=2;
    }
  }
  dp(0,2,5);
  dp(0,3,5);
  dp(0,4,5);
  dp(0,5,5);
  dp(0,6,5);
  dp(0,7,5);
  dp(0,8,5);
  dp(0,9,5);
  dp(0,10,5);
  arr[4][4]=0;
  arr[3][5]=0;
}

void draw() {
  step++;
  println(step);
  background(255);
  for(int i=0; i<s; i++) {
    for(int j=0; j<s; j++) {
      if(arr[i][j]==0) {
        fill(255);
      }
      else if(arr[i][j]==1) {
        fill(0);
      }
      else {
        fill(100);  
      }
      rect(i*(width/s),j*(width/s),width/s,width/s);  
    }    
  }
  generate();
  for(int i=0; i<s; i++) {
    for(int j=0; j<s; j++) {
      arr[i][j]=tarray[i][j];  
    }
  }
}

void generate() {
  for(int x=1; x<s-1; x++) {
    for(int y=1; y<s-1; y++) {
      if(arr[x][y]==1 && ((arr[x][y-1]==1 && arr[x+1][y]==1 && arr[x][y+1]==0 && arr[x-1][y]==0) || (arr[x][y-1]==0 && arr[x+1][y]==1 && arr[x][y+1]==1 && arr[x-1][y]==0) || (arr[x][y-1]==0 && arr[x+1][y]==0 && arr[x][y+1]==1 && arr[x-1][y]==1) || (arr[x][y-1]==1 && arr[x+1][y]==0 && arr[x][y+1]==0 && arr[x-1][y]==1))) {
        tarray[x][y]=0;  
      }
      else if(arr[x][y]==0 && ((arr[x][y-1]==0 && arr[x+1][y]==1 && arr[x][y+1]==1 && arr[x-1][y]==1) || (arr[x][y-1]==1 && arr[x+1][y]==0 && arr[x][y+1]==1 && arr[x-1][y]==1) || (arr[x][y-1]==1 && arr[x+1][y]==1 && arr[x][y+1]==0 && arr[x-1][y]==1) || (arr[x][y-1]==1 && arr[x+1][y]==1 && arr[x][y+1]==1 && arr[x-1][y]==0))) {
        tarray[x][y]=1;  
      }
      else if(arr[x][y]==0 && arr[x][y-1]==1 && arr[x+1][y]==1 && arr[x][y+1]==1 && arr[x-1][y]==1) {
        tarray[x][y]=1;  
      }
      else {
        tarray[x][y]=arr[x][y];  
      }
    }
  }   
}

void dp(int n,int x,int y) {
  switch(n) {
    case 0:
      arr[x][y]=1;
      arr[x][y+1]=1;
      arr[x][y-1]=1;
      arr[x][y+2]=0;
      arr[x][y-2]=0;
    break;
  }
}
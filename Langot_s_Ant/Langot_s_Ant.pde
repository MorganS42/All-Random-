int size=2;
int grid[][];
int step;
int pat=2;
int n=0;
boolean hex = true;
Ant[] ants;
void setup() {
  size(1000,1000);
  grid=new int[width/size][height/size];
  ants=new Ant[2048];
  ants[0]=new Ant(width/size/2,height/size/2,1);
  n++;
  for(int i=0; i<width/size; i++) {
    for(int j=0; j<height/size; j++) {
      if(j==height/size/2 && i>width/size/4 && i<width/size/2) {
        grid[i][j]=0;
      }
      else {
        grid[i][j]=0;
      }
    }  
  }
  //ants[1]=new Ant(width/size/2,height/size/2);
  background(100);
  
  noStroke();
  /*for(int x=0; x<width/size; x++) {
    for(int y=0; y<height/size; y++) {
      switch(pat) {
        case 2:
          switch(grid[x][y]) {
            case 0:
              fill(100);
            break;
            
            case 1:
              fill(0);
            break;
          }
        break;
      }
      
      rect(x*size,y*size,size,size);
    }  
  }*/
}

void draw() {
  noStroke();
  for(int i=0; i<100; i++) {
    step++;
    println(step);
    
    for(int a=0; a<n; a++) {
      switch(pat) {
        
        case 0:
          switch(grid[ants[a].x][ants[a].y]) {
            case 0:
              grid[ants[a].x][ants[a].y]=1;
              ants[a].dir--;
              fill(255);
            break;
            case 1:
              grid[ants[a].x][ants[a].y]=2;
              ants[a].dir--;
              fill(0);
            break;
            case 2:
              grid[ants[a].x][ants[a].y]=3;
              ants[a].dir++;
              fill(255,0,0);
            break;
            case 3:
              grid[ants[a].x][ants[a].y]=4;
              ants[a].dir++;
              fill(100,0,0);
            break;
            case 4:
              grid[ants[a].x][ants[a].y]=5;
              ants[a].dir++;
              fill(0,255,0);
            break;
            case 5:
              grid[ants[a].x][ants[a].y]=6;
              ants[a].dir--;
              fill(0,100,0);
            break;
            case 6:
              grid[ants[a].x][ants[a].y]=7;
              ants[a].dir++;
              fill(0,0,255);
            break;
            case 7:
              grid[ants[a].x][ants[a].y]=8;
              ants[a].dir++;
              fill(0,0,100);
            break;
            case 8:
              grid[ants[a].x][ants[a].y]=9;
              ants[a].dir++;
              fill(255,255,0);
            break;
            case 9:
              grid[ants[a].x][ants[a].y]=10;
              ants[a].dir--;
              fill(255,0,255);
            break;
            case 10:
              grid[ants[a].x][ants[a].y]=11;
              ants[a].dir--;
              fill(0,255,255);
            break;
            case 11:
              grid[ants[a].x][ants[a].y]=0;
              ants[a].dir--;
              fill(100,0,100);
            break;
          }
        break;
        
        case 1:
          switch(grid[ants[a].x][ants[a].y]) {
            case 0:
              grid[ants[a].x][ants[a].y]=1;
              ants[a].dir++;
              fill(255);
            break;
            case 1:
              grid[ants[a].x][ants[a].y]=2;
              ants[a].dir++;
              fill(0);
            break;
            case 2:
              grid[ants[a].x][ants[a].y]=3;
              ants[a].dir--;
              fill(255,0,0);
            break;
            case 3:
              grid[ants[a].x][ants[a].y]=4;
              ants[a].dir--;
              fill(100,0,0);
            break;
            case 4:
              grid[ants[a].x][ants[a].y]=5;
              ants[a].dir--;
              fill(0,255,0);
            break;
            case 5:
              grid[ants[a].x][ants[a].y]=6;
              ants[a].dir++;
              fill(0,100,0);
            break;
            case 6:
              grid[ants[a].x][ants[a].y]=7;
              ants[a].dir--;
              fill(0,0,255);
            break;
            case 7:
              grid[ants[a].x][ants[a].y]=8;
              ants[a].dir++;
              fill(0,0,100);
            break;
            case 8:
              grid[ants[a].x][ants[a].y]=9;
              ants[a].dir--;
              fill(255,255,0);
            break;
            case 9:
              grid[ants[a].x][ants[a].y]=10;
              ants[a].dir++;
              fill(255,0,255);
            break;
            case 10:
              grid[ants[a].x][ants[a].y]=11;
              ants[a].dir++;
              fill(0,255,255);
            break;
            case 11:
              grid[ants[a].x][ants[a].y]=0;
              ants[a].dir--;
              fill(100,0,100);
            break;
          }
        break;
        
        case 2:
          switch(grid[ants[a].x][ants[a].y]) {
            case 0:
              grid[ants[a].x][ants[a].y]=1;
              ants[a].dir++;
              fill(255);
            break;
            case 1:
              grid[ants[a].x][ants[a].y]=0;
              ants[a].dir--;
              fill(0);
            break;
          }
        break;
          
        case 3:
          switch(grid[ants[a].x][ants[a].y]) {
            case 0:
              grid[ants[a].x][ants[a].y]=1;
              ants[a].dir--;
              fill(255);
            break;
            case 1:
              grid[ants[a].x][ants[a].y]=2;
              ants[a].dir--;
              fill(0);
            break;
            case 2:
              grid[ants[a].x][ants[a].y]=3;
              ants[a].dir--;
              fill(255,0,0);
            break;
            case 3:
              grid[ants[a].x][ants[a].y]=0;
              ants[a].dir++;
              fill(0,0,255);
            break;
          }
        break;
        
        case 4:
          switch(grid[ants[a].x][ants[a].y]) {
            case 0:
              grid[ants[a].x][ants[a].y]=1;
              ants[a].dir--;
              fill(255);
            break;
            case 1:
              grid[ants[a].x][ants[a].y]=2;
              ants[a].dir++;
              fill(0);
            break;
            case 2:
              grid[ants[a].x][ants[a].y]=3;
              ants[a].dir-=2;
              fill(255,0,0);
            break;
            case 3:
              grid[ants[a].x][ants[a].y]=4;
              ants[a].dir++;
              fill(0,0,255);
            break;
            case 4:
              grid[ants[a].x][ants[a].y]=5;
              ants[a].dir+=2;
              fill(255,0,255);
            break;
            case 5:
              grid[ants[a].x][ants[a].y]=0;
              ants[a].dir--;
              fill(0,255,0);
            break;
          }
        break;
      }
      
      rect(ants[a].x*size,ants[a].y*size,size,size);
      if(ants[a].dir>3) {
        ants[a].dir-=4;
      }
      if(ants[a].dir<0) {
        ants[a].dir+=4;
      }
      switch(ants[a].dir) {
        case 0:
          ants[a].x++;
        break;
        case 1:
          ants[a].y--;
        break;
        case 2:
          ants[a].x--;
        break;
        case 3:
          ants[a].y++;
        break;
      }
      if(ants[a].x>width/size-1) {
        ants[a].x=0;  
      }
      if(ants[a].x<0) {
        ants[a].x=width/size-1;
      }
      if(ants[a].y>height/size-1) {
        ants[a].y=0;  
      }
      if(ants[a].y<0) {
        ants[a].y=height/size-1;
      }
      
    }
  }
}

class Ant {
  int x;
  int y;
  int dir;
  Ant(int xx,int yy,int d) {
    x=xx;
    y=yy;
    dir=d;
  }
}

void mouseClicked() {
  ants[n]=new Ant(mouseX/size,mouseY/size,1);
  n++;
}
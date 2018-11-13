int size=5;
int grid[][];
int step;
int pat=2;
String rule="110001000111";
int n=0;
boolean hex = true;
Ant[] ants;
void setup() {
  size(1000,1000);
  grid=new int[width/size][height/size];
  ants=new Ant[2048];
  ants[0]=new Ant(width/size/2,height/size/2,1,rule);
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
  //frameRate(2);
  background(100);
  
  noStroke();
}

void draw() {
  noStroke();
  for(int i=0; i<100; i++) {
    step++;
    println(step);
    
    for(int a=0; a<n; a++) {
      int p=grid[ants[a].x][ants[a].y];
      int r=ants[a].pat.charAt(p);
      int l=ants[a].pat.length();
      switch(r) {
      case '0':
        ants[a].dir--;
      break;
      case '1':
        ants[a].dir++;
      break;
    }
    
    if(p<l/4) {
      fill(255/(l-1)*(p*4));    
    }
    else if(p<l/2) {
      fill(255/(l-1)*(p*2),0,0);  
    }
    else if(p<l/4*3) {
      fill(0,255/(l-1)*(p*1.25),0);  
    }
    else if(p<l) {
      fill(0,0,255/(l-1)*(p));  
    }
    
    //fill(255/(ants[a].pat.length()-1)*grid[ants[a].x][ants[a].y]);
    
    grid[ants[a].x][ants[a].y]++;
    if(grid[ants[a].x][ants[a].y]>ants[a].pat.length()-1) {
      grid[ants[a].x][ants[a].y]=0;  
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
  String pat;
  Ant(int xx,int yy,int d,String p) {
    x=xx;
    y=yy;
    dir=d;
    pat=p;
  }
}

void mouseClicked() {
  ants[n]=new Ant(mouseX/size,mouseY/size,1,rule);
  n++;
}
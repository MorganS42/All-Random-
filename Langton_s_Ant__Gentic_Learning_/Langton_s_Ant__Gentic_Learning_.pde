int size=2;
int grid[][];
int step;

int pop=100;
int rl=15;
int sl=5000;

boolean hex = true;
Ant[] ants;
void setup() {
  size(1000,1000);
  grid=new int[width/size][height/size];
  ants=new Ant[pop];
  background(100); 
  noStroke();
  
  for(int i=0; i<1; i++) {
    ng();
    //da(0);
    da(pop-1);
  }
}

void bs(Ant array[]) { 
  int i;
  Ant j;
 
  for (i=0;i<array.length-1;i++) { 
    if (array[i].fitness > array[i+1].fitness) {  
      j = array[i]; 
      array[i] = array[i+1]; 
      array[i+1] = j; 
    } 
  } 
}

void ng() {
  fil();
  
  for(int a=0; a<pop; a++) {
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
    
    ants[a].fitness=score(a);
  }
  
  bs(ants);
}

void fil() {
  for(int a=0; a<pop; a++) {
    ants[a]=new Ant(width/size/2,height/size/2,1,pa());  
  }
}

String pa() {
  String p="";
  for(int i=0; i<rl; i++) {
    p+=round(random(0,1));      
  }
  return p;
}

void draw() {
  noStroke();
    
}

class Ant {
  int x;
  int y;
  int dir;
  String pat;
  float fitness=0;
  Ant(int xx,int yy,int d,String p) {
    x=xx;
    y=yy;
    dir=d;
    pat=p;
  }
}

void da(int a) {
  for(int i=0; i<sl; i++) {
    switch(ants[a].pat.charAt(grid[ants[a].x][ants[a].y])) {
      case '0':
        ants[a].dir--;
      break;
      case '1':
        ants[a].dir++;
      break;
    }
    
    fill(255/(ants[a].pat.length()-1)*grid[ants[a].x][ants[a].y]);
    
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

int score(int a) {
  for(int i=0; i<sl; i++) {
    switch(ants[a].pat.charAt(grid[ants[a].x][ants[a].y])) {
      case '0':
        ants[a].dir--;
      break;
      case '1':
        ants[a].dir++;
      break;
    }
    
    grid[ants[a].x][ants[a].y]++;
    if(grid[ants[a].x][ants[a].y]>ants[a].pat.length()-1) {
      grid[ants[a].x][ants[a].y]=0;  
    }
    
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
  
  return ants[a].x;
}
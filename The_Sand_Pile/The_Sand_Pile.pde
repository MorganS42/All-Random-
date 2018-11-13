int scale=20;
int w=500;
int h=120;

boolean d3 = false;

int[][] p;
int pat = 5;
int cp = 1;
int s = 101;
int mts = 4;//Minimum topple size
void setup() {
  size(1010,1010,P3D);
  //fullScreen(P3D);
  //background(0);
  p = new int[s][s];
  for(int x=0; x<s; x++) {
    for(int y=0; y<s; y++) {
      switch(pat) {
        case 0:
          p[x][y]=0;
          p[s/2][s/2]=1000;
        break;
        case 1:
          if((x+y)%2==1) {
            p[x][y]=-4;
          }
          else {
            p[x][y]=10;
          }
          //p[s/2][s/2]=10000;
        break;
        case 2:
          p[x][y]=3;
          p[s/2][s/2]=10000;
        break;
        case 3:
          if(x>y) {
            p[x][y]=4;
          }
          else {
            p[x][y]=3;
          }
        break;
        case 4:
          if(x==y || s-x-1==y) {
            p[x][y]=100;
          }
          else {
            p[x][y]=5;
          }
        break;
        case 5:
          p[x][y]=0;
        break;
      }
    }
  }
}

void draw() {
  background(255);
  
  if(keyPressed) {
    if(key=='w') {
      for(int x=0; x<s; x++) {
        int temp=p[x][s-1];
        for(int i=s-1; i>0; i--) {
          p[x][i]=p[x][i-1];
        }
        p[x][0]=temp;
      }
    }
    if(key=='s') {
      for(int x=0; x<s; x++) {
        int temp=p[x][0];
        for(int i=0; i<s-1; i++) {
          p[x][i]=p[x][i+1];
        }
        p[x][s-1]=temp;
      }
    }
    if(key=='d') {
      for(int y=0; y<s; y++) {
        int temp=p[0][y];
        for(int i=0; i<s-1; i++) {
          p[i][y]=p[i+1][y];
        }
        p[s-1][y]=temp;
      }
    }
    if(key=='a') {
      for(int y=0; y<s; y++) {
        int temp=p[s-1][y];
        for(int i=s-1; i>0; i--) {
          p[i][y]=p[i-1][y];
        }
        p[0][y]=temp;
      }
    }
  }
  
  if(mousePressed) {
    p[mouseX/(width/s)][mouseY/(height/s)]+=100;  
  }
  println(p[s/2][s/2]);
  
  for(int i=0; i<1; i++) {
    
    if(d3) {
      
      translate(300,600);
      rotateX(PI/(mouseY/(height/20)));
      rotateY(-PI/(mouseX/(width/20)));
      translate(-900,-1400);
      for(int y=0; y<s-1; y++) {
        beginShape(TRIANGLE_STRIP);
        for(int x=0; x<s; x++) {
          stroke(p[x][y]*50,p[x][y]*35,0);
          fill(p[x][y]*50,p[x][y]*35,0);
          vertex(x*scale,y*scale,p[x][y]*10);
          vertex(x*scale,(y+1)*scale,p[x][y+1]*10);
          if(p[x][y]>=mts) {
            topple(x,y);
          }
        }
        endShape();
      }
    
    }
    
    else {
      for(int x=0; x<s; x++) {
        for(int y=0; y<s; y++) {
          switch(cp) {
            case 0:
              stroke(p[x][y]*50,p[x][y]*35,0);
              fill(p[x][y]*50,p[x][y]*35,0);
            break;
            case 1:
              stroke(0,p[x][y]*50,p[x][y]*35);
              fill(0,p[x][y]*50,p[x][y]*35);
            break;
            case 2:
              stroke(p[x][y]*50,0,0);
              fill(p[x][y]*50,0,0);
            break;
            case 3:
              stroke(0,p[x][y]*35,0);
              fill(0,p[x][y]*35,0);
            break;
            case 4:
              stroke(0,0,p[x][y]*35);
              fill(0,0,p[x][y]*35);
            break;
            case 5:
              stroke(p[x][y]*50,0,p[x][y]*35);
              fill(p[x][y]*50,0,p[x][y]*35);
            break;
            case 6:
              stroke(p[x][y]*40,0,p[x][y]*70);
              fill(p[x][y]*40,0,p[x][y]*70);
            break;
          }
          if(p[x][y]>=mts) {
            topple(x,y);
          }
          if(p[x][y]%1==0) {
            rect(x*(width/s),y*(height/s),width/s,height/s);
          }
        }
      }
    }
  }
}

void topple(int x, int y) {
  p[x][y]-=4;
  if(x+1<s) {
    p[x+1][y]++;
  }
  if(x-1>-1) {
    p[x-1][y]++;
  }
  if(y+1<s) {
    p[x][y+1]++;
  }
  if(y-1>-1) {
    p[x][y-1]++;
  }
}
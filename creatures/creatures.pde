int w=256;
int h=256;

creature[] creatureArray = new creature[w*h];

void setup() {
  size(256,256);
  for(int i=0; i<w*h; i++) {
     creatureArray[i] = new creature();
  }
}

void draw() {
  background(0);
  for(int i=0; i<w*h; i++) {
    creatureArray[i].everything(); 
  }
}

class creature {
  int type = round(random(1,3));
  int x=round(random(0,w));
  int y=round(random(0,h));
  int health=100;
  int size=1;
  
  creature() {
    
  }
  
  void everything() {
     for(int i=0; i<w*h; i++) { 
       if(creatureArray[i].x==x && creatureArray[i].y==y && creatureArray[i].type==type++) {
         if(health==1) {
           type++;
         }
         else {
           health--; 
         }
       }
     }
     switch(type) {
       case 1: 
         stroke(255,0,0);
         fill(255,0,0);
         x=x+round(random(-size,size));
         y=y+round(random(-size,size));
         break;
       case 2:
         stroke(0,255,0);
         fill(0,255,0);
         x=x+round(random(-size,size));
         y=y+round(random(-size,size));
         break;
       case 3:
         stroke(0,0,255);
         fill(0,0,255);
         x=x+round(random(-size,size));
         y=y+round(random(-size,size));
         break;
     }
     ellipse(x,y,size,size);
  }
}
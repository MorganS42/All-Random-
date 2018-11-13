boolean rs = true;

String seed = "0 180 10 10"; //8 digits

boolean up=true;
int step=0;
int cv=0;
IntList log;
int j = 10;
int speed=500;
int limit=1800;

float h;

void setup() {
  if(rs) {
    seed=str(round(random(0,1)));
    
    seed+=str(round(random(0,4)));
    seed+=str(round(random(0,9)));
    seed+=str(round(random(0,9)));
    
    seed+=str(round(random(0,1)));
    seed+=str(round(random(0,9)));
    
    seed+=str(round(random(0,9)));
    
    seed+=str(round(random(0,9)));
    seed+=str(round(random(0,9)));
  }
  
  up=boolean(seed.charAt(0));
  
  limit=(seed.charAt(1)*100+seed.charAt(2)*10+seed.charAt(3))*10;
  
  j=seed.charAt(4)*10+seed.charAt(5);
  
  //step=seed.charAt(6);
  
  log = new IntList();
  fullScreen();
  colorMode(HSB, 360,100,100);
  background(0);
}

void draw() {
  for(int i=0; i<speed; i++) {
    if(step<limit) {
      log.append(cv);
      step+=j;
      cv-=step;
      if(log.hasValue(cv) || cv<0) {
        cv+=step*2;      
      }
      noFill();
      h=(((float(cv)/width)*360)%360);
      stroke(h,100,100);
      arc(((log.get(log.size()-1)+cv)/2),height/2,step,step,0+PI*int(up),PI+PI*int(up));
      //arc(((log.get(log.size()-1)+cv)/2)%width,floor((log.get(log.size()-1)+cv)/2/width),step/floor((log.get(log.size()-1)+cv)/2/width+1),step/floor((log.get(log.size()-1)+cv)/2/width+1),0+PI*int(up),PI+PI*int(up));
      up=!up;  
    }
  }
}
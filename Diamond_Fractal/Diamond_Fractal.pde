ArrayList<Square> sq;

void setup() {
  fullScreen();
  background(0);
  sq = new ArrayList<Square>();
  float siz = 500;
  PVector p = new PVector(width/2-siz/2,height/2-siz/2);
  sq.add(new Square(p,siz,true));
}

void draw() {
  for(Square s : sq) {
    s.display();  
  }
  if(round(random(500))==1) {
    background(0);
    generate();
  }
}

void generate() {
  ArrayList next = new ArrayList<Square>();
  float ns; 
  
  for(Square s : sq) {
    if(s.dia()) {
      ns=s.siz()/3;
      
      next.add(new Square(new PVector(    s.loc().x  +ns*2    ,s.loc().y  +ns        ),ns,false));
      next.add(new Square(new PVector(    s.loc().x         ,s.loc().y  +ns        ),ns,false));
      next.add(new Square(new PVector(    s.loc().x  +ns    ,s.loc().y             ),ns,false));
      next.add(new Square(new PVector(    s.loc().x  +ns       ,s.loc().y  +ns*2           ),ns,false));  
    }
    else {
      ns=s.siz()/2;
      
      next.add(new Square(new PVector(    s.loc().x  +ns    ,s.loc().y  +ns        ),ns,true));
      next.add(new Square(new PVector(    s.loc().x         ,s.loc().y  +ns        ),ns,true));
      next.add(new Square(new PVector(    s.loc().x  +ns    ,s.loc().y             ),ns,true));
      next.add(new Square(new PVector(    s.loc().x         ,s.loc().y             ),ns,true));  
    }
  }
  sq=next;
}

class Square {
  PVector loc;
  float size;
  boolean diamond;
  
  Square(PVector pos, float s, boolean dia) {
    loc=pos;
    size=s;
    diamond=dia;
  }
  
  void display() {
    fill(80,0,190);
    if(diamond) {
      quad(loc.x+size/2,loc.y,loc.x+size,loc.y+size/2,loc.x+size/2,loc.y+size,loc.x,loc.y+size/2);
    }
    else {
      rect(loc.x,loc.y,size,size);  
    }
  }
  
  PVector loc() {
    return loc;    
  }
  boolean dia() {
    return diamond;
  }
  float siz() {
    return size;    
  }
}
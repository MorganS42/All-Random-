ArrayList<Line> lines;

void setup() {
  fullScreen();
  lines = new ArrayList<Line>();
  PVector s = new PVector(0,height-50);
  PVector e = new PVector(width,height-50);
  lines.add(new Line(s,e));
}

void draw() {
  background(255);
  for(Line l : lines) {
    l.display();  
  }
}

void keyPressed() {
  if(key == ' ') {
    generate();
  }
}

void generate() {
  ArrayList next = new ArrayList<Line>();
  for(Line l : lines) {
    PVector a = l.A();
    PVector b = l.B();  
    PVector c = l.C();  
    PVector d = l.D();  
    PVector e = l.E();  
    
    next.add(new Line(a,b));
    next.add(new Line(b,c));
    next.add(new Line(c,d));
    next.add(new Line(d,e));
  }
  lines=next;
}

class Line {
  
  PVector start;
  PVector end;
  
  Line(PVector a, PVector b) {
    start=a;
    end=b;
  }
  
  void display() {
    stroke(0);
    line(start.x,start.y,end.x,end.y);
  }
  
  PVector A() {
    return start;  
  }
  
  PVector B() {
    PVector v = PVector.sub(end,start);
    v.div(3);
    v.add(start);
    return v;
    
  }
  
  PVector C() {
    PVector a = start;
    
    PVector v = PVector.sub(end, start);
    
    v.div(3);
    a.add(v);
    
    v.rotate(-radians(60));
    a.add(v);
    
    return a;
  }
  
  PVector D() {
    PVector v = PVector.sub(end,start);
    v.mult(2/3.0);
    v.add(start);
    return v;
  }
  
  PVector E() {
    return end;  
  }
}
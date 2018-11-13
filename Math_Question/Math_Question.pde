float goal=5/12;
String o1="*";
String o2="+";

String[] sn = {"1/2","1/3","1/4","1/5"};

float[] n = new float[sn.length];

float v;

void setup() {
  
  for(int i=0; i<sn.length; i++) {
    float t1=int(sn[i].charAt(0))-48;
    float t2=int(sn[i].charAt(2))-48;
    n[i]=t1/t2;
  }
}

void draw() {
  println("");
  println("");
  println("");
  println("");
  
  for(int a=0; a<4; a++) {
    for(int b=0; b<4; b++) {
      for(int c=0; c<4; c++) {
        if(!(a==c || a==b || b==c)) {
          if((o2=="*" || o2=="/") && (o1=="+" || o1=="-")) {
            switch(o2) {
              case "*":
                v=n[b]*n[c];
              break;
              case "/":
                v=n[b]/n[c];
              break;
            }
            
            switch(o1) {
              case "+":
                v+=n[a];
              break;
              case "-":
                v=a-v;
              break;
            }    
          }
          else {
            switch(o1) {
              case "+":
                v=n[a]+n[b];
              break;
              case "-":
                v=n[a]-n[b];
              break;
              case "*":
                v=n[a]*n[b];
              break;
              case "/":
                v=n[a]/n[b];
              break;
            }
            
            switch(o2) {
              case "+":
                v+=n[c];
              break;
              case "-":
                v-=n[c];
              break;
              case "*":
                v*=n[c];
              break;
              case "/":
                v/=n[c];
              break;
            }
          }
          
          if(round(v*1000)==round(goal*1000)) {
            println(sn[a]+", "+sn[b]+", "+sn[c]);  
          }
        }
      }
    }
  }
}
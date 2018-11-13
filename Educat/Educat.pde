int level=1;
int score=0;
int n1;
int n2;
boolean correct=false;

textBox[] textBoxArray = new textBox[1];
String question;
int answer;
String input;
boolean newQ = true;
boolean space = false;

void setup() {
  fullScreen();
  textBoxArray[0] = new textBox(width/2-500,height/2,1000);
}

void draw() {
   print(key+"/");
   background(255);
   textSize(128);
   fill(0);
   
   if(keyPressed && key==' ') {
     space=true; 
   }
   else {
     space=false; 
   }
   
   if(newQ) {
     newQ=false;
     n1=round(random(1,level+5));
     n2=round(random(1,level+5));
     question=n1+"*"+n2;
     answer=n1*n2;
   }
   if(correct) {
     text("correct!",width/2-200,200);
     while(!space) {
        print("in the while loop");
     }
     newQ=true;
   }
   else {
     text(question,width/2.25,200); 
   }
   textBoxArray[0].display();
   textBoxArray[0].typing();
}

class textBox {
  int x;
  int y;
  int size;
  String text = "";
  boolean textHelp=false;
  textBox() {
    
  }
  textBox(int tx,int ty,int tsize) {
    x=tx;
    y=ty;
    size=tsize;
  }
  void display() {
    fill(0);
    rect(x,y,size,size/5);
    fill(220);
    rect(x+5,y+5,size-10,size/5-10);
  }
  
  
  void typing() {
    if(keyPressed==true && textHelp==false) {
      textHelp=true;
      if(key==BACKSPACE) {
        text="";
      }
      else {
        if(key==ENTER || key==RETURN) {
          input=text;
          text="";
          if(Integer.parseInt(input)==answer) {
            correct=true;
          }
        }
        else {
          text=text+key;
        }
      }
    }
    else {
      if(!keyPressed) {
        textHelp=false;
      }
    }
    
    textSize(size/8);
    fill(0);
    text(text, x+size/16, y+size/8);
  }
}
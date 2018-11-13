boolean keyHelp=false;
int age=19;
int qn;
String quest;
int answer;
int p1;
int p2;
int p3;
int wrong;
int correct;
int score;
boolean aq=true;
boolean quiz=false;
int prize=0;
textbox[] textboxArray = new textbox[1];
void setup() {
  fullScreen();
  textboxArray[0] = new textbox(width/2-250,height/2,500,100);
  nq();
}

void draw() {
  colorMode(RGB);
  switch(prize) {
    case 1:
      background(0,0,200);
      break;
    case 0:
      background(255);
      break;
    case 2:
      background(255,255,0);
      break;
    case 3:
      background(255,0,0);
      break;
    case 4:
      background(0,255,255);
      break;
    case 5:
      background(150,0,200);
      break;
    case 6:
      for(float y=0; y<height; y++) {
        for(float x=0; x<width; x++) {
          colorMode(HSB);
          fill(x/width*255, y/height*255, (x+y)/width*255);
          point(x,y);
        }
      }
      break;
  }
  textSize(20);
  text("Age: "+age,50,50);
  text("Score: "+score,50,150);
  if(aq) {
    textSize(20);
    text("Question:"+qn,50,100);
    textSize(20);
    fill(0);
    text(quest,width/2-220,300);
    textboxArray[0].display();
  }
  if(quiz) {
    textSize(20);
    text("Question: "+qn+"/"+(age*5),50,100);
    textSize(20);
    fill(0);
    text(quest,width/2-220,300);
    textboxArray[0].display();
  }
  if((!aq) && (!quiz)) {
    if(score>4*age) {
      prize=1;
    }
    if(score>4.5*age && age>6) {
      prize=2;
    }
    if(score>4.7*age && age>9) {
      prize=3;
    }
    if(score>4.8*age && age>13) {
      prize=4;
    }
    if(score>4.8*age && age>15) {
      prize=5;
    }
    if(score>age-1 && age>18) {
      prize=6;
    }
    fill(100);
    rect(width/2-500,height/2,480,200);  
    rect(width/2+20,height/2,480,200); 
    textSize(128);
    fill(0);
    text("Quiz",width/2-400,height/2+150);
    textSize(100);
    text("Age Quiz",width/2+40,height/2+150);
    if(mousePressed && mouseX>width/2-500 && mouseX<width/2-20 && mouseY>height/2 && mouseY<height/2+200) {
      score=0;
      quiz=true;  
      correct=0;
      wrong=0;
    }
    if(mousePressed && mouseX>width/2+20 && mouseX<width/2+500 && mouseY>height/2 && mouseY<height/2+200) {
      aq=true;  
      if(age>5) {
        age=age-2;  
      }
      else {
        age=4;  
      }
      qn=1;
    }
  }
}

void keyReleased() {
  textboxArray[0].KEYPRESSED(); 
}

public class textbox {
   public int X = 0, Y = 0, H = 35, W = 200;
   public int TEXTSIZE = 64;
   
   // COLORS
   public color Background = color(140, 140, 140);
   public color Foreground = color(0, 0, 0);
   public color BackgroundSelected = color(160, 160, 160);
   public color Border = color(30, 30, 30);
   
   public boolean BorderEnable = true;
   public int BorderWeight = 1;
   
   public String Text = "";
   public int TextLength = 0;

   private boolean selected = false;
   
   textbox() {
      
   }
   
   textbox(int x, int y, int w, int h) {
      X = x; Y = y; W = w; H = h;
   }
   
   void display() {
      if (selected) {
         fill(BackgroundSelected);
      } else {
         fill(Background);
      }
      
      if (BorderEnable) {
         strokeWeight(BorderWeight);
         stroke(Border);
      } else {
         noStroke();
      }
      
      rect(X, Y, W, H);
      
      fill(Foreground);
      textSize(TEXTSIZE);
      text(Text, X + (textWidth("a") / 2), Y + TEXTSIZE);
   }
   
   boolean KEYPRESSED() {
         if (keyCode == BACKSPACE) {
            BACKSPACE();
         } else if (keyCode == ' ') {
            addText(' ');
         } else if (keyCode == ENTER) {
            if(int(Text)==answer) {
              if(aq) {
                nq();
                Text="";
                TextLength=0;
              }
              else {
                nqq();
                Text="";
                TextLength=0;
                correct++;
              }
            }
            else {
              if(aq) {
                qn=0;
                aq=false;
                Text="";
                TextLength=0;
              }
              else {
                wrong++;
                nqq();
                Text="";
                TextLength=0;
              }
            }
         } else {
            boolean isKeyCapitalLetter = (key >= 'A' && key <= 'Z');
            boolean isKeySmallLetter = (key >= 'a' && key <= 'z');
            boolean isKeyNumber = (key >= '-' && key <= '9');
      
            if (isKeyNumber) { //|| isKeySmallLetter || isKeyCapitalLetter) {
               addText(key);
            }
         }
      
      return false;
   }
   
   private void addText(char text) {
      if (textWidth(Text + text) < W) {
         Text += text;
         TextLength++;
      }
   }
   
   private void BACKSPACE() {
      if (TextLength - 1 >= 0) {
         Text = Text.substring(0, TextLength - 1);
         TextLength--;
      }
   }
}

void nq() {
  qn++;
  switch(age) {
    case 4:
      p1=round(random(qn/4))+1;
      p2=1;
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>9) {
        age++;
        qn=1;
      }
      break;
    case 5:
      p1=round(random(qn/4))+1;
      p2=round(random(qn/4))+1;
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>14) {
        age++;
        qn=1;
      }
      break;
    case 6:
      p1=round(random(qn));
      p2=round(random(qn));
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
    case 7:
      p1=round(random(qn));
      p2=round(random(qn));
      if(round(random(1,2))==1) {
        quest=(p1*2)+"+"+(p2*2);
        answer=p1*2+p2*2;
      }
      else {
        if(p1>p2) {
          quest=p1+"-"+p2;
          answer=p1-p2;
        }
        else {
          quest=p2+"-"+p1;
          answer=p2-p1;
        }
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
    case 8:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          quest=(p1*3)+"+"+(p2*3);
          answer=p1*3+p2*3;
          break;
        case 2:
          if(p1>p2) {
            quest=(p1*2)+"-"+(p2*2);
            answer=p1*2-p2*2;
          }
          else {
            quest=(p2*2)+"-"+(p1*2);
            answer=p2*2-p1*2;
          }
          break;
        case 3:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
      }
      if(qn>11) {
        age++;
        qn=1;
      }
      break;
    case 9:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          quest=(p1*3)+"+"+(p2*3);
          answer=p1*3+p2*3;
          break;
        case 2:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 3:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
      }
      if(qn>14) {
        age++;
        qn=1;
      }
      break;
    case 10:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 2:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 3:
          p1=round(random(1,qn/2));
          p2=p1*round(random(1,qn/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 11:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,2))) {
        case 1:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 2:
          p1=round(random(1,qn/2));
          p2=p1*round(random(1,qn/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 12:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 2:
          p1=round(random(1,qn/2));
          p2=p1*round(random(1,qn/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 3:
          p1=round(random(1,qn/3));
          p2=round(random(1,qn/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        }
        if(qn>19) {
          age++;
          qn=1;
        }
        break;
      case 13:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,4))) {
        case 1:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 2:
          p1=round(random(1,qn/2));
          p2=p1*round(random(1,qn/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 3:
          p1=round(random(1,qn/3));
          p2=round(random(1,qn/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 4:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        }
        if(qn>19) {
          age++;
          qn=1;
        }
        break;
      case 14:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          p1=round(random(1,qn/4));
          p2=round(random(1,qn/4));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=10;
          p3=round(random(qn/3));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p2 + ")";
          answer=p3;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 15:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          p1=round(random(1,qn/4));
          p2=round(random(1,qn/4));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn/4));
          p3=round(random(1,qn/2));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 16:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,3))) {
        case 1:
          p1=round(random(1,qn/3));
          p2=round(random(1,qn/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn/4));
          p3=round(random(1,qn/2));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 17:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,4))) {
        case 1:
          p1=round(random(1,qn/3));
          p2=round(random(1,qn/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn/4));
          p3=round(random(1,qn/2));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
        case 4:
          p1=round(random(qn/5));
          quest="cube root" + pow(p1,3);
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 18:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,4))) {
        case 1:
          p1=round(random(1,qn/3));
          p2=round(random(1,qn/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn/4));
          p3=round(random(1,qn/2));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
        case 4:
          p1=round(random(qn/4));
          quest="cube root" + pow(p1,3);
          answer=p1;
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
      case 19:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,5))) {
        case 1:
          p1=round(random(1,qn/2));
          p2=round(random(1,qn/2));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn/4));
          p3=round(random(1,qn/2));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
        case 4:
          p1=round(random(qn/5));
          quest="4th root" + pow(p1,4);
          answer=p1;
          break;
        case 5:
          p1=round(random(qn/4));
          quest="cube root" + pow(p1,3);
          answer=p1;
          break;
      }
      if(qn>19) {
        age+=81;
        qn=1;
      }
      break;
      case 100:
      p1=round(random(qn));
      p2=round(random(qn));
      switch(round(random(1,5))) {
        case 1:
          p1=round(random(1,qn));
          p2=round(random(1,qn));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn))*round(random(qn));
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=round(random(1,qn));
          p3=round(random(1,qn));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p1 + ", " + p2 + ")";
          answer=p3;
          break;
        case 4:
          p1=round(random(qn));
          p2=round(random(qn));
          quest=p2+"th root" + pow(p1,p2);
          break;
        case 5:
          p1=round(random(qn));
          quest="cube root" + pow(p1,3);
          break;
      }
      if(qn>19) {
        age++;
        qn=1;
      }
      break;
  }
}




void nqq() {
  qn++;
  switch(age) {
    case 4:
      p1=round(random(20/4))+1;
      p2=1;
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 5:
      p1=round(random(20/4))+1;
      p2=round(random(20/4))+1;
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 6: 
      p1=round(random(20));
      p2=round(random(20));
      quest=p1+"+"+p2;
      answer=p1+p2;
      if(qn>19) {
        quiz=false;
      }
      break;
    case 7:
      p1=round(random(20));
      p2=round(random(20));
      if(round(random(1,2))==1) {
        quest=(p1*2)+"+"+(p2*2);
        answer=p1*2+p2*2;
      }
      else {
        if(p1>p2) {
          quest=p1+"-"+p2;
          answer=p1-p2;
        }
        else {
          quest=p2+"-"+p1;
          answer=p2-p1;
        }
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 8:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,3))) {
        case 1:
          quest=(p1*3)+"+"+(p2*3);
          answer=p1*3+p2*3;
          break;
        case 2:
          if(p1>p2) {
            quest=(p1*2)+"-"+(p2*2);
            answer=p1*2-p2*2;
          }
          else {
            quest=(p2*2)+"-"+(p1*2);
            answer=p2*2-p1*2;
          }
          break;
        case 3:
          p1=round(random(20/1.8));
          p2=round(random(20/1.8));
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 9:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,3))) {
        case 1:
          quest=(p1*3)+"+"+(p2*3);
          answer=p1*3+p2*3;
          break;
        case 2:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 3:
          p1=round(random(20/1.5));
          p2=round(random(20/1.5));
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 10:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,4))) {
        case 1:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 2:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 3:
          p1=round(random(1,20/2));
          p2=p1*round(random(1,20/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 4:
          quest=(p1*2)+"+"+(p2*2);
          answer=p1*2+p2*2;      
          break;
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 11:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,4))) {
        case 1:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 2:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 3:
          p1=round(random(1,20/2));
          p2=p1*round(random(1,20/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 4:
          quest=(p1*2)+"+"+(p2*2);
          answer=p1*2+p2*2;      
          break;
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    case 12:
      p1=round(random(20));
      p2=round(random(qn));
      switch(round(random(1,5))) {
        case 1:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 2:
          p1=round(random(1,20/2));
          p2=p1*round(random(1,20/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 3:
          p1=round(random(1,20/3));
          p2=round(random(1,20/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 4:
          quest=(p1*2)+"+"+(p2*2);
          answer=p1*2+p2*2;      
          break;
        case 5:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        }
        if(qn>age*5-1) {
          quiz=false;
        }
        break;
      case 13:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,6))) {
        case 1:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 2:
          p1=round(random(1,20/2));
          p2=p1*round(random(1,20/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
        case 3:
          p1=round(random(1,20/3));
          p2=round(random(1,20/3));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 4:
          p1=round(random(20/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 5:
          quest=(p1*2)+"+"+(p2*2);
          answer=p1*2+p2*2;      
          break;
        case 6:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        }
        if(qn>age*5-1) {
          quiz=false;
        }
        break;
      case 14:
      p1=round(random(20));
      p2=round(random(20));
      switch(round(random(1,7))) {
        case 1:
          p1=round(random(1,20/4));
          p2=round(random(1,20/4));
          quest=p2+"^"+p1;
          answer=round(pow(p2,p1));
          break;
        case 2:
          p1=round(random(qn/1.5));
          p1=p1*p1;
          quest="sqrt " + p1;
          answer=round(sqrt(p1));
          break;
        case 3:
          p1=10;
          p3=round(random(20/3));
          p2=round(pow(p1,p3));
          quest="log" + "(" + p2 + ")";
          answer=p3;
          break;
        case 4:
          quest=(p1*2)+"+"+(p2*2);
          answer=p1*2+p2*2;      
          break;
        case 5:
          quest=(p1*2)+"-"+(p2*2);
          answer=p1*2-p2*2;      
          break;
        case 6:
          quest=p1+"*"+p2;
          answer=p1*p2;
          break;
        case 7:
          p1=round(random(1,20/2));
          p2=p1*round(random(1,20/2));
          quest=p2+"/"+p1;
          answer=p2/p1;
          break;
      }
      if(qn>age*5-1) {
        quiz=false;
      }
      break;
    //case 15:
      
  }
  if(quiz==false) {
    score=correct-wrong; 
  }
}
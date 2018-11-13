int value = 0;
int randomValue;
int score = 0;
int AIscore = 0;
boolean AIturn = false;
int goal = 42;
void setup() {
  size(1000,600); 
}

void draw() {
background(255);
textSize(32);
fill(0);
text("Score: " + score, 10, 30);
text("AI Score:" + AIscore, width-170, 30);
text("Roll? y/n", (width/2)-50, height/2);

if (AIturn == true) {
    if (AIscore < (goal-6)) {
      background(255);
      randomValue = round(random(1,6));
      fill(0);
      text("AI rolled and got a " + randomValue, width/2-100, height/2);
      text("Score: " + score, 10, 30);
      text("AI Score:" + AIscore, width-170, 30);
      AIscore = AIscore+randomValue;
    }
    else {
      if(score>AIscore) {
        if(round(random(1,2)) == 1) {
          background(255);
          randomValue = round(random(1,6));
          text("AI rolled and got a " + randomValue, width/2-100, height/2);
          AIscore = AIscore+randomValue;
          fill(0);
          text("Score: " + score, 10, 30);
          text("AI Score:" + AIscore, width-170, 30);
          wait(2);
        }
        else {
          background(255);
          text("AI didn't roll", width/2-100, height/2);
          text("Score: " + score, 10, 30);
          text("AI Score:" + AIscore, width-170, 30);
          wait(2);
        }
      }
      else {
        background(255);
        text("AI didn't roll", width/2-100, height/2);
        text("Score: " + score, 10, 30);
        text("AI Score:" + AIscore, width-170, 30);
        wait(2);
      }
    }
    AIturn = false;
}

if (score==goal) {
 background(255);
 text("YOU WIN!", width-80, height/2);
 stop(); 
}

if (keyPressed) {
    if (key == 'y') {
      randomValue = round(random(1,6));
      score = score + randomValue;
      textSize(32);
      background(255);
      fill(0);
      text("You rolled a " + randomValue, width/2-100, height/2-70); 
      text("Score: " + score, 30, 30);
      text("AI Score: " + AIscore, width-170, 30);
      text("AI's turn",(width/2)-60, height/2);
      wait(2);
      AIturn = true;
    }
    if (key == 'n') {
      background(255);
      text("Score: " + score, 10, 30);
      text("AI Score: " + AIscore, width-170, 30);
      text("AI's turn",(width/2)-60, height/2);
      wait(2);
      AIturn = true;
    }
}
}

void keyPressed() {
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
}

void wait(int x) {
  int waitHelp1= millis();
  while(millis()< waitHelp1+(x*1000)) {
    x=x*123;
    x=x/123;
  }
}
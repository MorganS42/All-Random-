int outputSize = 20;
int inputSize = 4; //The amount of digits used in the input array
int ops = 5; //Number of operations ect (+,-,*,/) +=0 -=1 *=2
int[] input = {2,0,1,8}; //numbers used to generate all the number up to the outputsize
String[] output = new String[outputSize]; //The final formula for calculating the numbers
int[][] work = new int[round(pow(ops,inputSize-1))][inputSize-1]; //the thing the computer uses for calculating the whole thing
int x=0;
int t=0;
int top=-1;
int oldtop=ops+1;
int answer;
String out;

void setup() {   
    for(int b=0; b<inputSize-1; b++) { //it's inputsize-1 becuase there would be inputsize -1 amount of operators used in each eqaution\
      x=round(ops*ops/pow(ops,b));
      for(int c=0; c<pow(ops,inputSize-1); c++) { 
        work[c][b] = ceil(c/x) % ops; 
      }
    }
    
    for(int n=0; n<round(pow(ops,inputSize-1)); n++) {
      for(int a=0; a<inputSize-1; a++) {
      oldtop=t;
      t=-1;
      for(int i=0; i<inputSize-1; i++) { 
        switch(work[n][i]) {
          case 0:
            if(0>top && 0<oldtop) {
              top=0;
              t=i;
            }
            break;
          case 1:
            if(0>top && 0<oldtop) {
              top=1;
              t=i;
            }
            break;
          case 2:
            if(2>top && 2<oldtop) {
              top=2;
              t=i;
            }
            break;
          case 3:
            if(2>top && 2<oldtop) {
              top=3;
              t=i;
            }
            break;
          case 4:
            if(4>top && 4<oldtop) {
              top=4;
              t=i;
            }
            break;
        }
      }
      }
      answer=input[t];
      out=""+input[0];
      
        
        switch(work[n][t]) {
          case 0:
            answer+=input[t+1];
            out=out+"+"+input[t+1];
            break;
          case 1:
            answer-=input[t+1];
            out=out+"-"+input[t+1];
            break;
          case 2:
            answer*=input[t+1];
            out=out+"*"+input[t+1];
            break;
          case 3:
            if(input[t+1]==0) {
              answer=42424242;
            }
            else {
              answer/=input[t+1];
            }  
            out=out+"/"+input[t+1];
            break;
          case 4:
            answer^=input[t+1];
            out=out+"^"+input[t+1];
            break;
      }
      if(answer<=outputSize && answer>=0) {
        //print(answer);
        output[answer] = answer+". "+out+"= "+answer;  
      }
    }
    
    for(int i=0; i<outputSize; i++) {
      print(output[i]);
      println();
    }
}
ArrayList<String> validwords = new ArrayList<String>();
String[] words;

String letters = "abcd";
String[] test = new String[fact(letters.length())];

void setup() {
  println("Starting");
  words=loadStrings("dictionary.dic");
  for (int r=0; r<words.length; r++) {
    validwords.add(words[r]);       
  }
  println("Step 1 Complete");
  comb(letters.length(),0);
  println("Step 2 Complete");
  print(test);
}

void draw() {
      
}

int fact(int num){
   if (num == 1){
      return 1;
   } 
   else {
      return num*fact(num - 1);
   }
}

void comb(int l,int s) {
  for(int a=0; a<l; a++) {
    for(int i=0; i<fact(l)/4; i++) {
      test[s+a*(fact(l)/4)+i]+=letters.charAt(a);
    }
    comb(l-1,a*(fact(l)/4));
  }  
}
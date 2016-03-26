class Letters{
  char [] to_char;
  PFont text;
  
  
  
  
  //Letter CONSTRUCTOR: Takes in the string
 Letters(String word){
   to_char = word.toCharArray();
   text = loadFont("Baskerville-48.vlw");
 }//End of constructor


void draw_lines(){
     int x = 40;
   for (int i=0;i<to_char.length;i++) {
    stroke(0);
    strokeWeight(2);
    line(x,500,x+50,500);
    x+=75;
   }
}
boolean check_letter(char example){
  for (int i = 0; i<to_char.length;i++){ //scans letters of the actual word
    if(example == to_char[i]){
      return true;
    }

  }
  return false;
}

void draw_letter(char example){
   int x = 50;
   if (word_right) {
   for (int i=0;i<to_char.length;i++) {
    // System.out.println(example);
    // System.out.println(to_char[i]);
     if(example == to_char[i]){
       //System.out.println("hahahahah");
        fill(184,92,245);
     textFont(text, 42);
     text(example, x, 490);
      word_length--;
      System.out.println(word_length);
   }
    x+=75;
   
   }
   word_right = false;
   }
  
 // if(example)
  

}//end 



}//letters class

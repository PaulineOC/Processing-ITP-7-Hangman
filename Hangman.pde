import processing.serial.*;

Serial myPort;



int pos_X = 125;
int pos_Y = 125;
float size = 1.25;
int person_width = (int)(40*size);
int person_height = (int)((65*size) + (65*size) + (35*size));

//Typing for guessing: 
String typing = "";
char saved;
char [] temporary;
//Object:
Letters set;


//Game stages: 
//Set word:
boolean reset = false;
boolean start;
PFont font;
String set_word = "";
String final_word = "";
int word_length =0;

//Guess word:
boolean guess;
boolean background_on;
int lose_x;
int lose_y;
boolean increment_lose;
int total_lose = 10;
boolean word_right = false;
//Winner
boolean win;

void setup() {
  size(800, 600);
  start = true;
  guess = false;
  win = false;
  font = loadFont("Baskerville-48.vlw");
  lose_x = 400;
  lose_y=200;
  
  //Processing - ARDUINO
  printArray(Serial.list());
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  
}//End of setup

void draw() {
  if (start) {
    if (reset) {
      background(150, 150, 255);
      reset = false;
    }
    background(150, 150, 255);
    textFont(font, 32);
    fill(255);
    text("Type in the word (10 letters or less) that someone will guess.\n Press Enter to begin the game", 20, 50);
    text(set_word, 100, 400);
  }

  else if (guess) {
    if (background_on) {
      background(255);
      background_on = false;
    }
    textFont(font, 28);
    fill(184, 92, 245);
    text("Only the first character will be guessed.\n Press Enter to guess:  "+typing, 300, 550);
    //Hangman's stand
    fill(121, 63, 13);
    rect(40, 40, 150, 20); // top beam
    rect(40, 60, 30, person_height+60); // stand
    rect(40, person_height+120, 150, 30);//base
    fill(0);
    ellipse(53, 50, 7, 8);
    
    
    //ROPE
    stroke(245, 222, 179);
    strokeWeight(4);
    line(150, 60, 150, 100);

    set.draw_lines();
    if (set.check_letter(saved)) {
      set.draw_letter(saved);

    }
    else {
      if (increment_lose) {
        fill(184, 92, 245);
        text(saved, lose_x, lose_y);
        lose_x+=30;
        increment_lose = false;
        total_lose --;
        if (lose_x > 700) {
          lose_x = 400;
          lose_y+= 50;
        }
      }
    }
    losing();
    if (word_length == 0) {
      guess = false;
      textFont(font, 30);
      text("You've won! \n Press 1 to reset the game & play again.", 200, 350);
      myPort.write(1);
  
      
    }
  }//end of guess

  else if (win) {
  }
}//End of Draw


void keyPressed() {
  if (start) {
    if (key == '\n' ) {
      final_word = set_word;
      set = new Letters(final_word);
      word_length = final_word.length();
      System.out.println("start "+word_length);
      start = false;
      background_on = true;
      guess = true;
    } 
    else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      set_word = set_word + key;
    }
  }

  else if (guess) {
    if (key == '\n' ) {
     
      word_right = true;
      temporary = typing.toCharArray();
      saved = temporary[0];
      increment_lose = true;
      strokeWeight(0);
      stroke(255);
      typing = "";
      fill(255);
      rect(540, 560, 100, 30);
      // A String can be cleared by setting it equal to ""

    } 
    else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
    if (key == '1') {
      start = true;
      reset = true;
      guess = false;
      set_word = "";
      final_word = "";
      total_lose = 9;
      word_length =0;
      myPort.write(3);
      typing = "";
    }
  }
  
  else if(word_length == 0){
    if (key == '1') {
      start = true;
      reset = true;
      guess = false;
      set_word = "";
      final_word = "";
      total_lose = 9;
      myPort.write(3);
      typing = "";
    }
  }
  //end of guess
}//End of key pressed

void losing() {//DONT FORGET YOU'RE COUNTING DOWN!
  strokeWeight(2);
  stroke(0, 0, 0);
  switch(total_lose) {
  case 0: 
    textFont(font, 30);
    fill(255, 0, 0);
    text("You have lost!\n Press '1' to reset the game", 200, 350);
    myPort.write(2);
    break;
  case 1:
    strokeWeight(1);
    line(145, 130, 155, 135);
    line(155, 130, 145, 135);
    break;
  case 2:
    strokeWeight(1);
    line(155, 115, 160, 120);
    line(160, 115, 155, 120);
    break;
  case 3:
    strokeWeight(1);
    line(140, 115, 145, 120);
    line(145, 115, 140, 120);
    break;
  case 4:
    line( pos_X+20*size, pos_Y+70*size, pos_X+40*size, pos_Y+130*size) ; // right leg 
    break;
  case 5:
    line( pos_X+20*size, pos_Y+70*size, pos_X, pos_Y+130*size) ; //Left leg
    break;
  case 6:     
    line( pos_X+20*size, pos_Y+30*size, pos_X+40*size, pos_Y+70*size) ; // right arm 
    break;
  case 7:
    line( pos_X+20*size, pos_Y+30*size, pos_X, pos_Y+70*size) ; // left arm
    break;
  case 8: 
    line(pos_X+20*size, pos_Y+(16.4*size), pos_X+20*size, pos_Y+70*size); // Body
    break;
  case 9: 
    fill(255, 0, 100); // head fill
    ellipse(pos_X+20*size, pos_Y, 40*size, 35*size) ; // head
    break;
  }//end of switch :P
}


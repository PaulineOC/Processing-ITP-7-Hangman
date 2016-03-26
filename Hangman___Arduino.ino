int input2=0;
void setup() {
  Serial.begin(9600);     
  pinMode(7, OUTPUT); //WIN
  pinMode(3, OUTPUT); //LOSE
}
  
 
void loop()
{
  
  if (Serial.available() > 0){
     Serial.println("input1");
     int input = Serial.read(); 
     Serial.println("input");
     //this waits for byte from Processing
     if(input == 1){
       input2=1;
       }
     else if(input == 2){
       input2=2;
     }
     else if(input == 3){
       input2=3;
     }
  }//Actual variable
  if(input2 == 1){
       digitalWrite(7, HIGH);
       Serial.println("i");
       }
     else if(input2 == 2){
       digitalWrite(3, HIGH);
     }
     else if(input2 == 3){
       digitalWrite(7, LOW);
       digitalWrite(3, LOW);
    }
}

int AnalogPin0 = 14; 
int AnalogPin1 = 15;
int AnalogPin2 = 16;
int AnalogPin3 = 17;
int AnalogPin4 = 18;
int AnalogPin5 = 19;

int state1, state2, state3, state4, state5 = 0;
int potVal;

void setup() {
  
  pinMode(14, INPUT_PULLUP);
  pinMode(15, INPUT_PULLUP);
  pinMode(16, INPUT_PULLUP);
   pinMode(17, INPUT_PULLUP);
    pinMode(18, INPUT_PULLUP);
      
 Serial.begin(9600); 
 
}

void loop() {
  
  
   potVal = analogRead(AnalogPin5);
    potVal = map(potVal, 0, 1023, 0, 10);
  state1 = digitalRead(AnalogPin0);
  state2 = digitalRead(AnalogPin1);
  
   state3 = digitalRead(AnalogPin2);
   state4 = digitalRead(AnalogPin3);
   state5 = digitalRead(AnalogPin4);
   
    

  
  Serial.print(state1, DEC); 
  Serial.print(","); // seperate string
  Serial.print(state2, DEC);
  Serial.print(",");
  Serial.print(state3, DEC);
  Serial.print(",");
  Serial.print(state4, DEC);
  Serial.print(",");
  Serial.print(state5, DEC);
  Serial.print(",");
  Serial.print(potVal, DEC);
  Serial.println();
  
}

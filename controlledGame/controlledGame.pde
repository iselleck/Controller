import processing.serial.*;

  
int end = 10;
String serial;
Serial port;
 
 
 float maxdist = 200;
String left, right, up, down, fire;
 
public PVector playerPos;
PVector direction; 
int speed;
PImage img;

float radius;

// shooting 
ArrayList<Bullet> bullets;
final float bulletSpeed = 4.2;
final int fireRate = 200;
int lastFired = millis();
boolean hit = false;

 void setup(){
   port = new Serial(this, Serial.list()[0], 9600);
   serial = port.readStringUntil(end);
   //serial = null;
   
   size(500, 500);
   background(0);
   noStroke();
   bullets = new ArrayList();
   drawDots(50);
   spawnAsteroids();
   img = loadImage("gameBack.jpg");
   img.loadPixels();
   loadPixels();
  playerPos = new PVector(width/2, height/2);
  direction = new PVector(1,0);
  speed = 4;
 }
 
 void draw(){
  
    while (port.available() > 0) { 
    serial = port.readStringUntil(end);
  }
    if (serial != null) { 
      
      String[] a = split(serial, ',');  
      //println(a[0]); 
     // println(a[1]);
        //println(a[2]);
      left = a[0];
      right = a[1];
       up = a[2];
        down = a[3];
         fire = a[4];
        
       
    }
    
/*    
     if(lightVal != null){
         if(lightVal.equals("Dark") == true){
           radius = 50;
         }
         if(lightVal.equals("Dim") == true){
           radius = 100;
         }
         if(lightVal.equals("Light") == true){
         radius = 150;
       }
         if(lightVal.equals("Bright") == true){
           radius = 200;
         }
         if(lightVal.equals("Very bright") == true){
           radius = 250;
         }
       } 
*/


    if(left != null){
    if(left.equals("0") == true){
      direction.x = -1;
      direction.y = 0;
    }
    }
    

    if(right != null){
    if(right.equals("0") == true){
      direction.x = 1;
      direction.y = 0;
    }
    }
    if(up != null){
    if(up.equals("0") == true){
      direction.x = 0;
      direction.y = -1;
    }
    }
    
    if(down != null){
    if(down.equals("0") == true){
      direction.x = 0;
      direction.y = 1;
    }
    }
    
    if(fire != null){
    if(fire.equals("0") == true){
fire();
    }
    }
   
  
 
   
   for(int x = 0; x < img.width; x++){
     for(int y = 0; y < img.height; y++){
       int loc = x + y * img.width;
       
       float r, g ,b; 
       r = red(img.pixels[loc]);
       
       
     
       
       float d = dist (x, y, width/2, height/2);
       float adjustbrightness = 255 * (maxdist - d)/maxdist;
       r += adjustbrightness;
       r = constrain(r,0,255);
       color c = color(r);
       pixels[y*width+x] = c;
     }
   } 
   
   
   updatePixels();
   
   drawBullets();
  //  drawDots(10);
  
    playerPos.x += speed * direction.x; 
    playerPos.y += speed * direction.y; 
    if(playerPos.x > width){
      playerPos.x = 0;
    }
       if(playerPos.x < 0){
          playerPos.x = width;
    }
       if(playerPos.y > height){
          playerPos.y = 0;
    }
       if(playerPos.y < 0){
          playerPos.y = height;
    }
    
    
   fill(0,0,150);
   noStroke();
   rect(playerPos.x, playerPos.y, 25,25);

 }
 

 
 void drawDots(int stars){
   for(int i = 0; i < stars; i++){
     fill(255);
     ellipse(random(width), random(height),5,5);
   }
   
 }
 
void spawnAsteroids(){
  for(int i = 0; i < 10; i++){
    fill(0);
    stroke(255);
    ellipse(10, 10, 50, 50);   
  }
}

void mousePressed(){
  fire();
}

void fire(){
  if(fireRate <= millis() - lastFired){
    lastFired = millis();
    float xSpeed, ySpeed;
    float angle = update(mouseX, mouseY);
    
     xSpeed = direction.x;
      ySpeed = direction.y;
      xSpeed*= bulletSpeed;
      ySpeed*= bulletSpeed;
      
       
        ySpeed=0;
      bullets.add ( new Bullet(
      playerPos.x, playerPos.y,
      xSpeed, ySpeed,
      5 ));
    } 
    
  }
  
  float update(int mx, int my){
    float angle = atan2(float(my)-(playerPos.y), float(mx)-(playerPos.x));
  return angle;
  }


void drawBullets(){
  
  for (Bullet currentBullet : bullets ) {     
    currentBullet.move();
    currentBullet.display();
  }
  
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet currentBullet = bullets.get(i);
    if (currentBullet.finished()) {
      bullets.remove(i);
    }
  }
}
 
void keyPressed(){  
    if(key == 'w' || key == 'W' || keyCode == UP){
     direction.y = -1;
     direction.x = 0;
    }
    
    if(key == 'a' || key == 'A' || keyCode == LEFT){
      direction.y = 0;
     direction.x = -1;
    }
    
    if(key == 's' || key == 'S' || keyCode == DOWN){
       direction.y = 1;
     direction.x = 0;
    }
    
    if(key == 'd' || key == 'D' || keyCode == RIGHT){
      direction.y = 0;
     direction.x = 1;
    }  
}
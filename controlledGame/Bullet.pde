class Bullet {
  
  float x, y, speedX, speedY, w ;
  float life = 255;
  
  Bullet(float tempX, float tempY,
  float tempSpeedX, float tempSpeedY,
  float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speedX = tempSpeedX; 
    speedY = tempSpeedY;
  }
  
  void move() {
    
    x = x + speedX;
    y = y + speedY;

    if (x<4)
      life=-1;
    if (y<4)
      life=-1;
    if (x>width-4)
      life=-1;
    if (y>width-4)
      life=-1;
    // blue rect
    if (x>=100 && y>=100 && x<=140 && y<=140) {  
      life=-1;
      hit=true;
    }
   
    if (life==-1) {
      //      explode () ;
    }
  } 
  
  boolean finished() {
   
    if (life < 0) {
      return true;
    }
    else {
      return false;
    }
  }
  void display() {
    
    fill(244, 2, 2);
    noStroke();
   
    ellipse(x, y, w, w);
  }
} 
class Circles
{ 
  float dx, dy, size, speed;
  PVector pos;
  
  Circles()
  {        
    speed = 3;    
    newCircles();
  }

  void render()
  {  
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }

  void move()
  {
    pos.x += dx;
    pos.y += dy;
  }

  void newCircles()
  {
    pos = new PVector(width / 2, height / 2);
    dx = random(-speed, speed);
    dy = random(-speed, speed);
    size = random(5, 20);
  }
}

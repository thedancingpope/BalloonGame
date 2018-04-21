class Circles
{ 
  float dx, dy, size;
  PVector pos;
  
  Circles()
  {           
    pos = newCircles();
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

  PVector newCircles()
  {
    int speed = 3;    
    dx = random(-speed, speed);
    dy = random(-speed, speed);
    size = random(5, 20);
    return new PVector(width / 2, height / 2);
  }
}

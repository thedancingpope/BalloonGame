class Circles
{ 
  float x, y, dx, dy, size, speed;

  Circles()
  {        
    speed = 3;    
    newCircles();
  }

  void renderCircles()
  {  
    noStroke();
    ellipse(x, y, size, size);
  }

  void moveCircles()
  {
    x += dx;
    y += dy;
  }

  void newCircles()
  {
    x = width / 2;
    y = height / 2;
    dx = random(-speed, speed);
    dy = random(-speed, speed);
    size = random(5, 20);
  }
}
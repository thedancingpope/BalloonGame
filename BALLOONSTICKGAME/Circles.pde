class Circles extends GameObjectAbstract
{ 
  float dx, dy, size;

  Circles()
  {           
    int speed = 3;    
    dx = random(-speed, speed);
    dy = random(-speed, speed);
    size = random(5, 20);
    pos = new PVector(width / 2, height / 2);
  }

  void render()
  {    
    ellipse(pos.x, pos.y, size, size);
  }

  void move()
  {
    pos.x += dx;
    pos.y += dy;
  }
}

class Circles extends GameObjectAbstract
{ 
  float size;

  Circles()
  { 
    int speed = 2;    
    pos = new PVector(width / 2, height / 2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-speed, speed), random(-speed, speed));
    size = random(5, 10);
  }

  void move()
  {
    velocity.add(acceleration);
    pos.add(velocity);
    acceleration.mult(0.1);
  }
}

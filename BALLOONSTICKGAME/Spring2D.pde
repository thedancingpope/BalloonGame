class Spring2D extends GameObjectAbstract
{      
  float addX, addY;

  Spring2D(float _x, float _y) 
  {
    pos = new PVector(_x, _y);
  }

  void move(float targetX, float targetY) 
  {
    float mass = 2.0;
    float stiffness = 0.2;
    float damping = 0.5;
    float forceX = (targetX - pos.x) * stiffness;
    float ax = forceX / mass;

    addX = damping * (addX + ax);
    pos.x += addX;

    float forceY = (targetY - pos.y) * stiffness;

    forceY += 9f;

    float ay = forceY / mass;

    addY = damping * (addY + ay);
    pos.y += addY;
  }
}

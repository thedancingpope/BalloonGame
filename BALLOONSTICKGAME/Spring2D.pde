class Spring2D 
{      
  float x, y, addX, addY;
  
  Spring2D(float _x, float _y) 
  {
    x = _x;
    y = _y;
  }

  void move(float targetX, float targetY) 
  {
    float mass = 2.0;
    float stiffness = 0.2;
    float damping = 0.5;
    float forceX = (targetX - x) * stiffness;
    float ax = forceX / mass;

    addX = damping * (addX + ax);
    x += addX;

    float forceY = (targetY - y) * stiffness;

    forceY += 9f;

    float ay = forceY / mass;

    addY = damping * (addY + ay);
    y += addY;
  }

  void render(float _x, float _y, float _z) 
  {
    pushMatrix();
    strokeWeight(3);
    line(x, y, _z, _x, _y, _z);
    popMatrix();
  }
}
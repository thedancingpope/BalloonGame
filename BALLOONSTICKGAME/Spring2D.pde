class Spring2D 
  {      
    float vx, vy; // The x- and y-axis velocities
    float springX, springY; // The x- and y-coordinates
    float gravity = 9.0;
    float mass = 2.0;
    float radius = 30;
    float stiffness = 0.2;
    float damping = 0.5;

    Spring2D(float xpos, float ypos) 
      {
        springX = xpos;
        springY = ypos;     
      }

    void update(float targetX, float targetY) 
      {
        float forceX = (targetX - springX) * stiffness;
        float ax = forceX / mass;
        
        vx = damping * (vx + ax);
        springX += vx;
        
        float forceY = (targetY - springY) * stiffness;
        
        forceY += gravity;
        
        float ay = forceY / mass;
        
        vy = damping * (vy + ay);
        springY += vy;
      }

    void display(float nx, float ny) 
      {
        pushMatrix();
          strokeWeight(3);
          line(springX, springY, nx, ny);
        popMatrix();
      }
  }
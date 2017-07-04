class PowerUp 
  {
    float PowerX;
    float PowerY;
    int speed;
  
    PowerUp()
      {
        PowerX = random(width);
        PowerY = 0;
        speed = 10;
      }
  
    void ActualPowerUp()
      {
        pushMatrix();
          fill(150);
          ambient(150, 150, 0); 
          noStroke();
          translate(PowerX, PowerY);
            pushMatrix();              //draws the nucleus
              rotateY(frameCount*.1);
              translate(10, -20, -10);
                sphere(20);                  
                translate(-18, 0);
                  fill(212, 114, 114);
                  sphere(20);
                  translate(0, 17, 17);
                    fill(150);
                    sphere(20);
                    translate(18, 0);
                      fill(212, 114, 114);
                      sphere(20);
            popMatrix();  
            pushMatrix();              //draws the electron
              fill(0);              
              translate(10, -12, 0);
                rotateX(1);
                rotateY(-1);
                translate(0, sin(frameCount*.2)*-120, cos(frameCount*.2)*120);
                  sphere(5);
            popMatrix();      
            pushMatrix();                //draws the electron
              translate(-10, -12, 0);
                rotateX(1);
                rotateY(1);
                translate(0, sin(frameCount*.2)*-120, cos(frameCount*.2)*120);
                  sphere(5);
            popMatrix();
        popMatrix();
      }    
  
    void PowerMove()
      { 
        PowerY += speed;                            // auto movement of the power up
        
        if (PowerY >= height + 800)
          {
            PowerY = -500;
            PowerX = random(width*2.5);
          }
      }
    
    void PowerGrab() 
      {
         //Play sound
         //Send indicator to BadGuys to cause BadGuy to drop y value.
         
         if(PowerY >= 500 && PowerY <= 700)
           {
             if(map(PowerX, 0, 1000, -500, 500) >= balX && map(PowerX, 0, 1000, -500, 500) <= balX + 180)
               gotPowerUp = true;         
           } 
         else 
           gotPowerUp = false;         
      }
  }
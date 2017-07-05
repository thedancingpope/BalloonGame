class PowerUp 
  {
     float PowerY = 0;
     float electronSpeed = 0.7f;
     float nucleusSpin = 0.4f;
    
     int speed = 7;     
     int PowerX;
    
     color protonColor = color(22, 128, 130);
     color neutronColor = color(23, 84, 55);
  
     PowerUp()
       {
          PowerX = -250;
       }
  
     void ActualPowerUp()
       {
          pushMatrix();
            translate(width/2, 0, 25);
            ambient(150, 150, 150);         
            noStroke();
            translate(PowerX/2, PowerY);
              scale(.4);
              pushMatrix();              //draws the nucleus
                rotateY(frameCount * nucleusSpin);
                translate(10, -20, -10);
                  drawNucleus(neutronColor);           
                  translate(-18, 0);
                    drawNucleus(protonColor);  
                    translate(0, 17, 17);
                      drawNucleus(neutronColor); 
                      translate(18, 0);
                        drawNucleus(protonColor); 
              popMatrix();  
              drawElectron(-1, 10);
              drawElectron(1, -10);              
          popMatrix();
       }    
     
    void drawNucleus(color nucleusColor)
      {
         pushMatrix(); 
           fill(nucleusColor);  
           sphere(20);
         popMatrix();
      }
  
    void drawElectron(int dir, int x)
      {
         pushMatrix();              //draws the electron                            
           translate(x, -12);
             rotateX(1);
             rotateY(dir);
             translate(0, sin(frameCount*electronSpeed) * -120, cos(frameCount*electronSpeed) * 120);
               fill(0);
               sphere(5);
         popMatrix();    
      }
    
    void PowerMove()
      { 
         PowerY += speed;                            // auto movement of the power up
         if (PowerY >= height + 30)
           {
              PowerY = -450;
              PowerX = int(random(-500, 500));
           }
      }
    
    void PowerGrab() 
      {
         int balloonTolerance = 78;
         if(PowerY >= 180 && PowerY <= 300)
           {
              if(PowerX >= (balX - balloonTolerance) && PowerX <= balX + balloonTolerance)
                gotPowerUp = true;         
           } 
         else 
           gotPowerUp = false;         
      }
  }
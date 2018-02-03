class PowerUp 
{  
  float x, y;

  color protonColor = color(22, 128, 130);
  color neutronColor = color(23, 84, 55);

  PowerUp()
  {
    newPosition();
  }

  void render()
  {
    pushMatrix();
    ambient(150, 150, 150);         
    noStroke();
    translate((width / 2) + x, y, 25);
    pushMatrix(); 
    rotateY(frameCount * .3f);
    translate(5, -10, -5);
    drawNucleus(neutronColor);           
    translate(-9, 0);
    drawNucleus(protonColor);  
    translate(0, 9, 9);
    drawNucleus(neutronColor); 
    translate(9, 0);
    drawNucleus(protonColor); 
    popMatrix();  
    drawElectron(-1);
    drawElectron(1);              
    popMatrix();
  }    

  void drawNucleus(color nucleusColor)
  {
    pushMatrix(); 
    fill(nucleusColor);  
    sphere(8);
    popMatrix();
  }

  void drawElectron(int dir)
  {
    float electronSpeed = 0.5f;
    int inc = 60;

    pushMatrix();        
    rotateX(1);
    rotateY(dir);
    translate(0, sin(frameCount * electronSpeed) * -inc, cos(frameCount * electronSpeed) * inc);
    fill(0);
    sphere(2);
    popMatrix();
  }

  void move()
  { 
    y += 7;
    if (y >= height + 30)
      newPosition();
  }

  void newPosition()
  {
    y = -400;
    x = int(random(-250, 250));
  }

  boolean getPowerUp() 
  {
    int balloonTolerance = 35;
    if (y >= 180 && y <= 320)
    {
      if (x >= ((balX / 2) - balloonTolerance) && x <= ((balX / 2) + balloonTolerance))
        return true;
    }
    return false;
  }
}
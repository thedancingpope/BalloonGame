class PowerUp 
{  
  PVector pos;
  color protonColor = color(22, 128, 130);
  color neutronColor = color(23, 84, 55);

  PowerUp()
  {
    pos = newPosition();
  }

  void render()
  {
    pushMatrix();
    noLights();
    noStroke();
    translate(pos.x + (width / 2), pos.y, 25);
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
    pos.y += 10;
    if(pos.y >= height)
       pos = newPosition();
  }

  PVector newPosition()
  {    
    int x = int(random(-220, 220));
    return new PVector(x, -200);
  }

  boolean getPowerUp() 
  {
    int balloonTolerance = 35;
    if(pos.y >= 180 && pos.y <= 320)
    {
      if(pos.x >= (balPos.x - balloonTolerance) && pos.x <= (balPos.x + balloonTolerance))
        return true;
    }
    return false;
  }
}

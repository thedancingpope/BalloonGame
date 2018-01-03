class PowerUp 
{  
  float x, y;

  color protonColor = color(22, 128, 130);
  color neutronColor = color(23, 84, 55);

  PowerUp()
  {
    PowerSet();
  }

  void ActualPowerUp()
  {
    pushMatrix();
    translate(width / 2, 0, 25);
    ambient(150, 150, 150);         
    noStroke();
    translate(x / 2, y);
    scale(.4);
    pushMatrix(); 
    rotateY(frameCount * .4f);
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
    float electronSpeed = 0.7f;
    int inc = 120;

    pushMatrix();                         
    translate(x, -12);
    rotateX(1);
    rotateY(dir);
    translate(0, sin(frameCount * electronSpeed) * -inc, cos(frameCount * electronSpeed) * inc);
    fill(0);
    sphere(5);
    popMatrix();
  }

  void PowerMove()
  { 
    y += 7;
    if (y >= height + 30)
      PowerSet();
  }

  void PowerSet()
  {
    y = -450;
    x = int(random(-500, 500));
  }

  boolean PowerGrab() 
  {
    int balloonTolerance = 78;

    if (y >= 180 && y <= 300)
    {
      if (x >= (balX - balloonTolerance) && x <= (balX + balloonTolerance))
        return true;
    }
    return false;
  }
}
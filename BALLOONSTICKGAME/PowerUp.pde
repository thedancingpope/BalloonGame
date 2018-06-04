class PowerUp extends GameObjectAbstract
{
  color protonColor = color(22, 128, 130);
  color neutronColor = color(23, 84, 55);
  PGraphics powerUpLayer;
  
  PowerUp()
  {
    powerUpLayer = createGraphics(width, height, P3D);
    pos = newPosition();
    velocity = new PVector(0, 6);
  }

  void render()
  {    
    move();
    powerUpLayer.beginDraw();
    powerUpLayer.background(protonColor, 0);
    powerUpLayer.noLights();
    powerUpLayer.noStroke();
    powerUpLayer.pushMatrix(); 
    powerUpLayer.translate(pos.x, pos.y, 25);
    powerUpLayer.pushMatrix(); 
    powerUpLayer.rotateY(frameCount * .3f);
    powerUpLayer.translate(5, -10, -5);
    drawNucleus(neutronColor);           
    powerUpLayer.translate(-9, 0);
    drawNucleus(protonColor);  
    powerUpLayer.translate(0, 9, 9);
    drawNucleus(neutronColor); 
    powerUpLayer.translate(9, 0);
    drawNucleus(protonColor); 
    powerUpLayer.popMatrix();     
    drawElectron(-1);
    drawElectron(1);    
    powerUpLayer.popMatrix();
    powerUpLayer.endDraw();
    image(powerUpLayer, 0, 0);
  }    

  void drawNucleus(color nucleusColor)
  {
    powerUpLayer.pushMatrix();    
    powerUpLayer.noLights();
    powerUpLayer.noStroke();
    powerUpLayer.fill(nucleusColor);  
    powerUpLayer.sphere(8);
    powerUpLayer.popMatrix();
  }

  void drawElectron(int dir)
  {
    float electronSpeed = 0.5f;
    int inc = 60;
    powerUpLayer.pushMatrix();        
    powerUpLayer.rotateX(1);
    powerUpLayer.rotateY(dir);
    powerUpLayer.translate(0, sin(frameCount * electronSpeed) * -inc, cos(frameCount * electronSpeed) * inc);
    powerUpLayer.fill(0);
    powerUpLayer.sphere(2);
    powerUpLayer.popMatrix();
  }

  void move()
  {
    pos.add(velocity);
    if(phase != 3)
      if (pos.y >= height)
        pos = newPosition();
  }

  PVector newPosition()
  {    
    float x = random(10, width - 10);
    return new PVector(x, -125);
  }

  boolean getPowerUp() 
  {
    int balHeight = 70;
    if (pos.y >= (balPos.y - balHeight) && pos.y <= (balPos.y + balHeight))
    {
      int radius = 30;
      if (pos.x >= (balPos.x - radius) && pos.x <= (balPos.x + radius))
        return true;
    }
    return false;
  }
}

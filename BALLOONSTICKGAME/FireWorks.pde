class FireWorks extends GameObjectAbstract
{
  color fwColor;
  int circleCount, lifeTime;
  PGraphics fireWorksLayer;
  Circles [] Circles;

  FireWorks(color c, int time)
  {
    circleCount = int(random(10, 16));
    Circles = new Circles [circleCount];
    for(int i = 0; i < circleCount; i++)
      Circles[i] = new Circles();    
    int range = width / 4;
    float x = random(-range, range);    
    float y = random(-range, range);
    fireWorksLayer = createGraphics(width, height, P3D);
    pos = new PVector(x, y);
    lifeTime = time;
    fwColor = c;
  }
  
  boolean alive()
  {
    if(lifeTime <= 0)
      return false;
    else
      return true;
  }

  void render()
  {
    fireWorksLayer.beginDraw();
    fireWorksLayer.background(255, 0);
    fireWorksLayer.pushMatrix();
    fireWorksLayer.translate(pos.x, pos.y, 40);
    fireWorksLayer.noLights();
    fireWorksLayer.noStroke();
    for(int i = 0; i < circleCount; i++) 
    {        
      Circles[i].move();
      fireWorksLayer.fill(fwColor);
      fireWorksLayer.ellipse(Circles[i].pos.x, Circles[i].pos.y, Circles[i].size, Circles[i].size);
    }
    fireWorksLayer.popMatrix();
    fireWorksLayer.endDraw();
    image(fireWorksLayer, 0, 0);
    lifeTime --;      
  }
}

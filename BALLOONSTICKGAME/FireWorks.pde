class FireWorks extends GameObjectAbstract
{
  color fwColor;
  int circleCount, lifeTime;
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
    pos = new PVector(x, y, 40);
    lifeTime = time;
    fwColor = c;
  }

  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noLights();
    noStroke();
    for(int i = 0; i < circleCount; i++) 
    {        
      fill(fwColor);
      Circles[i].render();
      Circles[i].move();
    }
    popMatrix();
    lifeTime --;      
  }
}

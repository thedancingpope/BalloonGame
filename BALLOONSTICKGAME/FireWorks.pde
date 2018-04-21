class FireWorks
{      
  PVector pos;
  color fwColor;
  int circleCount;
  Circles [] Circles;

  FireWorks()
  {
    circleCount = 10;
    Circles = new Circles [circleCount];
    for (int i = 0; i < circleCount; i++)
      Circles[i] = new Circles();
    pos = newPosition();
    fwColor = colorChange();
  }

  void render()
  {
    int limit = 60;
    int midWidth = width / 2;
    int midHeight = height / 2;

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    for (int i = 0; i < circleCount; i++) 
    {  
      noLights();
      fill(fwColor);
      Circles[i].render();
      Circles[i].move();
      if (Circles[i].pos.x < (midWidth - limit) || Circles[i].pos.x > (midWidth + limit) || Circles[i].pos.y < (midHeight - limit) || Circles[i].pos.y > (midHeight + limit))
        Circles[i] = new Circles();      
      if (frameCount % 30 == 0)
      {        
        pos = newPosition(); 
        fwColor = colorChange();
      }
    }
    popMatrix();
  }
  
  color colorChange()
  {
    int R = int(random(255));
    int G = int(random(255));
    int B = int(random(255));
    return color(R,G, B);
  }
  
  PVector newPosition()
  {
    int range = width / 4;
    float x = random(-range, range);    
    float y = random(-range, range);
    return new PVector(x, y, 40);
  }
}

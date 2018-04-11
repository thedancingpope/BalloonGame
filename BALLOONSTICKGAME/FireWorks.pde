class FireWorks
{      
  PVector pos;
  int R, G, B; 
  int circleCount = 10;

  Circles [] Circles;

  FireWorks()
  {
    Circles = new Circles [circleCount];
    for (int i = 0; i < circleCount; i++)
      Circles[i] = new Circles();
    pos = newPosition();
    colorChange();
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
      fill(R, G, B);
      Circles[i].render();
      Circles[i].move();
      if (Circles[i].pos.x < (midWidth - limit) || Circles[i].pos.x > (midWidth + limit) || Circles[i].pos.y < (midHeight - limit) || Circles[i].pos.y > (midHeight + limit))
        Circles[i].newCircles();      
      if (frameCount % 30 == 0)
      {
        colorChange();
        pos = newPosition();        
      }
    }
    popMatrix();
  }

  PVector newPosition()
  {
    int range = width / 4;
    float x = random(-range, range);    
    float y = random(-range, range);
    return new PVector(x, y, 40);
  }
  
  void colorChange()
  {
    R = int(random(255));
    G = int(random(255));
    B = int(random(255));
  }
}

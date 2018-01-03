class FireWorks
{      
  float newX, newY;

  int circleCount = 10;
  
  Circles [] Circles;

  FireWorks()
  {
    Circles = new Circles [circleCount];
    for (int i = 0; i < circleCount; i++)
      Circles[i] = new Circles();
    newPos();
  }

  void renderFireWorks()
  {
    int limit = 60;
    int midWidth = width / 2;
    int midHeight = height / 2;
    
    pushMatrix();
    translate(newX, newY, 40);
    for (int i = 0; i < circleCount; i++) 
    {                 
      Circles[i].renderCircles();
      Circles[i].moveCircles();
      if (Circles[i].x < (midWidth - limit) || Circles[i].x > (midWidth + limit) || Circles[i].y < (midHeight - limit) || Circles[i].y > (midHeight + limit))
        Circles[i].newCircles();      
      if (frameCount % 30 == 0)
        newPos();
    }
    popMatrix();
  }

  void newPos()
  {
    int range = width / 4;
    newX = random(-range, range);
    newY = random(-range, range);
  }
}
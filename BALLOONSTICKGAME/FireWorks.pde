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
    newPosition();
  }

  void render()
  {
    int limit = 60;
    int midWidth = width / 2;
    int midHeight = height / 2;
    
    pushMatrix();
    translate(newX, newY, 40);
    for (int i = 0; i < circleCount; i++) 
    {                 
      Circles[i].render();
      Circles[i].move();
      if (Circles[i].x < (midWidth - limit) || Circles[i].x > (midWidth + limit) || Circles[i].y < (midHeight - limit) || Circles[i].y > (midHeight + limit))
        Circles[i].newCircles();      
      if (frameCount % 30 == 0)
        newPosition();
    }
    popMatrix();
  }

  void newPosition()
  {
    int range = width / 4;
    newX = random(-range, range);
    newY = random(-range, range);
  }
}
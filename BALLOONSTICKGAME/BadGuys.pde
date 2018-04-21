class BadGuy
{
  float yTolerance; 
  PVector pos;
  PImage badCloud, angryCloud, enemyImg;

  BadGuy() 
  {
    pos = new PVector(0, 300 + (height / 2));    
    yTolerance = 50;
    badCloud = loadImage("EvilCloud.png");
    badCloud = badCloud.get(183, 239, 700, 300);
    angryCloud = loadImage("EvilCloudSPrite copy.png"); 
    angryCloud = angryCloud.get(5, 35, 700, 300);
  }

  void render()
  {
    int imgTolerance = (width / 2) - 105;
    pushMatrix();
    noStroke();
    translate(pos.x + imgTolerance, pos.y);
    noLights();        
    if (pos.y <= balPos.y + yTolerance)
    {
      scale(.6);
      enemyImg = angryCloud;
    } 
    else
    {
      scale(.4);
      enemyImg = badCloud;
    }
    image(enemyImg, 0, 0);    
    popMatrix();
  }

  boolean caughtCheck()
  {
    int gap = 30;
    if (pos.x >= (balPos.x - gap) && pos.x <= (balPos.x + gap) && pos.y <= balPos.y - yTolerance)    
      return true;
    else
      return false;
  }

  void move()
  { 
    if (pos.x < balPos.x - 1)
      pos.x += 3;
    else if (pos.x > balPos.x + 1)
      pos.x -= 3;
    if (pos.y > balPos.y - yTolerance)
      pos.y -= 2;
  }

  void retreat()
  {
    pos.y += 14;
  }
}

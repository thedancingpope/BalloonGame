class BadGuy
{
  float balY; 
  PVector pos;
  int speed, imgTolerance;
  PImage badCloud, angryCloud, enemyImg;

  BadGuy() 
  {
    pos = new PVector(0, 300);
    imgTolerance = (width / 2) - 105;
    balY = -55;
    speed = 2;
    badCloud = loadImage("EvilCloud.png");
    badCloud = badCloud.get(183, 239, 700, 300);
    angryCloud = loadImage("EvilCloudSPrite copy.png"); 
    angryCloud = angryCloud.get(5, 35, 700, 300);
  }

  void render()
  {
    pushMatrix();
    noStroke();
    translate(pos.x + imgTolerance, pos.y + (height / 2));
    noLights();        
    if (pos.y <= 70)
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
    if (pos.x >= (balPos.x - gap) && pos.x <= (balPos.x + gap) && pos.y <= balY)    
      return true;
    else
      return false;
  }

  void move()
  { 
    if (pos.x < balPos.x - 1)
      pos.x += speed;
    else if (pos.x > balPos.x + 1)
      pos.x -= speed;
    if (pos.y > balY)
      pos.y -= speed;
  }

  void retreat()
  {
    pos.y += 14;
  }
}

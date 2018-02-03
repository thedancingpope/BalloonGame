class BadGuy
{
  float x, y, enemyFollow, balY; 

  int speed, imgTolerance;

  PImage badCloud, angryCloud, enemyImg;
  
  BadGuy() 
  {
    x = 0f;
    y = 300f;
    imgTolerance = (width / 2) - 105;
    balY = -65;
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
    translate(x + imgTolerance, y + (height / 2));
    noLights();        
    if(y <= 70)
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
    int gap = 15;
    if (x >= (enemyFollow - gap) && x <= (enemyFollow + gap) && y <= balY)    
      return true;
    else
      return false;
  }

  void move()
  { 
    enemyFollow = map(balX, -500, 500, -200, 200);
    if(x < enemyFollow - 1)
      x += speed;
    else if(x > enemyFollow + 1)
      x -= speed;
    if (y > balY)
      y -= speed;
  }
  
  void retreat()
  {
    y += 16;
  }
}
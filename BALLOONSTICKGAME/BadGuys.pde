class BadGuy extends GameObjectAbstract
{
  float yTolerance; 
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
    if(pos.y <= balPos.y + yTolerance)
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
    if(pos.x >= (balPos.x - gap) && pos.x <= (balPos.x + gap) && pos.y <= 205)    
      return true;
    else
      return false;
  }

  void move()
  {
    pos.x = lerp(pos.x, balPos.x, .15);
    if(pos.y > 200)
      pos.y -= 2;
  }

  void retreat()
  {
    pos.y += 10;
  }
}

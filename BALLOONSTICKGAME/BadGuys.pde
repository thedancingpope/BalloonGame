class BadGuy
{
  float x, y, balY; 

  int speed;

  PImage badCloud;
  PImage angryCloud;

  boolean closeToBalloon = false;

  BadGuy() 
  {
    x = 125f;
    y = 900f;
    balY = 250.0f;
    speed = 4;
    badCloud = loadImage("EvilCloud.png");
    angryCloud = loadImage("EvilCloudSPrite copy.png");
  }

  void render()
  {
    if (phase == 2)
    {
      pushMatrix();
      noStroke();
      translate(x, y);
      noLights();
      if (closeToBalloon)
      { 
        scale(.6);
        image(angryCloud, 5, -38);
      } else
      {
        scale(.4);
        image(badCloud.get(183, 239, 700, 300), 0, 0);
      }
      popMatrix();
    }
  }

  void move()
  {
    if (phase == 2)
    {
      int balloonTolerance = 70;        
      float balPos = map(balX, -500, 500, -20, 250);        

      if (x >= (balPos - 15) && x <= (balPos + 15) && y <= (balY - balloonTolerance))
        caught = true;

      if (gotPowerUp)
      {
        y += 23;
      } else
      {
        x = lerp(x, balPos, .2);
        if (y >= balY - balloonTolerance)       //Follow the Balloon's ypos
          y -= speed;
        if (y <= balY - balloonTolerance)    // dont go over the balloon height
          y = balY - balloonTolerance;
      } 

      if (y <= 300)              //check if the enemy is close to the balloon
        closeToBalloon = true;       
      else
        closeToBalloon = false;
    }
  }
}
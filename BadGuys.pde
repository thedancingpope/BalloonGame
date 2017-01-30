class BadGuy
{
  float bx;//Balloon xpos
  float balY = 250;//Balloon ypos
  float ex =0;//Enemy xpos
  float ey =0;//Enemy ypos
  float size;
  float speed;
  PImage badCloud;
  
  
  BadGuy() 
  {
    
    x = random(width);
    y = random(height);
    size = random(25, 45);
    speed = random(0.2, 0.6);
    badCloud = loadImage("EvilCloud.png");
  }

  void render()
  {
    noStroke();
    fill(170, 184, 185);
    image(badCloud, ex, ey + 1000);
  }

  void move()
  {
    //Follow the Balloon's xpos
    print(ex);
    if (ex != balX)
    {
      if ((balX -ex) > 0)
      {
        ex = ex + speed;
      }
      else if ((balX - ex) < 0) 
      {
        ex = ex - speed;
      }
      println(ex);
    
    }
    //Follow the Balloon's ypos
    if (ex != balY)
    {
      if((balY - ex) > 0)
      {
        ey = ey -(speed/2);
      }
      if((balY - ey) < 0)
      {
        ey = ey + speed;
      }
    }
  }
}
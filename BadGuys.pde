class BadGuy
{
  float bx;            //Balloon xpos
  float balY = 250.0;  //Balloon ypos
  float ex;            //Enemy xpos
  float ey;            //Enemy ypos
  float speed;
  PImage badCloud;
  
  
  BadGuy() 
  {
    ex = 0;
    ey = 1000;
    speed = 1;
    badCloud = loadImage("EvilCloud.png");
  }

  void render()
  {
    noStroke();
    fill(170, 184, 185);
    ambient(255);
    image(badCloud, ex, ey);
  }

  void move()
  {
    //Follow the Balloon's xpos
    if (ex != balX)
      {
        if ((balX + 80 - ex) > 0)
          {
            ex = ex + speed;
          }
        else if ((balX + 80 - ex) < 0) 
          {
            ex = ex - speed;
          }
      }
    //Follow the Balloon's ypos
    if (ey != balY)
      {
          ey = ey - speed;       
      }
  }
}

class BadGuy
{
  float bx;            //Balloon xpos
  float balY = 250.0;  //Balloon ypos
  float ex;            //Enemy xpos
  float ey;            //Enemy ypos
  float speed;
  PImage badCloud;
  PImage angryCloud;
  boolean closeToBalloon = false;
  
  BadGuy() 
  {
    ex = 0;
    ey = 1000;
    speed = 0.8;
    badCloud = loadImage("EvilCloud.png");
    angryCloud = loadImage("EvilCloudSPrite copy.png");
  }

 void render()
  {
    noStroke();
    fill(170, 184, 185);
    ambient(255);    
    if(closeToBalloon == true)
      {
        pushMatrix();
          ambient(100);
          translate(ex + 190, ey + 150);
          scale(1.5);
          image(angryCloud, 0, 0);
        popMatrix();
      }
    else
      image(badCloud, ex, ey);
  }

  void move()
  {
    //If Caught
    if(ex >= (balX-1.5) && ex <= (balX+1.5) && ey >= (balY-1.5) && ey <= (balY+1.5))
       caught = true;
    
      //Got PowerUp    
    if(gotPowerUp == true)
       ey = ey + 9;
          
    //Follow the Balloon's xpos
    if(ex != balX)
      {
        if(ex < (balX+150))
           ex = ex + speed;
        else if(ex > (balX+150)) 
           ex = ex - speed;
      }
        
    //Follow the Balloon's ypos
    if(ey >= balY)
      ey = ey - speed;  
    
    //check if close to the balloon
    if (ey <= 550)
       closeToBalloon = true;       
    else
       closeToBalloon = false;       
  }
}

class BadGuy
  {
    float balY;          //Balloon ypos
    float ex;            //Enemy xpos
    float ey;            //Enemy ypos
    
    int speed;
    
    PImage badCloud;
    PImage angryCloud;
    
    boolean closeToBalloon = false;
    
    BadGuy() 
    {
      ex = 0f;
      ey = 1500f;
      balY = 400.0f;
      speed = 3;
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
            translate(ex + 310, ey);
            scale(1.5);
            image(angryCloud, 0, -30);
          popMatrix();
        }
      else
        {
          pushMatrix();
            translate(ex + 300, ey + 28);
            image(badCloud.get(183, 239, 700, 300), 0, 0);
          popMatrix();
        }
    }
  
    void move()
    {
        //If Caught
      if(ex >= (balX - 20) && ex <= (balX + 20) && ey >= (balY - 20) && ey <= (balY + 20))
         caught = true;
      
        //Got PowerUp    
      if(gotPowerUp == true)
         ey = ey + 25;
         
      else
        {
            //Follow the Balloon's xpos
          if(ex != balX)
            {
              if(ex + speed <= (balX))
                 ex = ex + speed;
              else if(ex - speed > (balX)) 
                 ex = ex - speed;
            }
              
            //Follow the Balloon's ypos
          if(ey >= balY)
            ey = ey - speed; 
          if(ey <= balY)    // dont go over the balloon height
            ey = balY;
        } 
        
      //check if close to the balloon
      if (ey <= 750)
         closeToBalloon = true;       
      else
         closeToBalloon = false;       
    }
  }
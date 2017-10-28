class BadGuy
  {
     float balY;          //Balloon ypos
         
     int speed;
    
     PImage badCloud;
     PImage angryCloud;
    
     boolean closeToBalloon = false;
    
     BadGuy() 
       {
          ex = 125f;
          ey = 900f;
          balY = 250.0f;
          speed = 4;
          badCloud = loadImage("EvilCloud.png");
          angryCloud = loadImage("EvilCloudSPrite copy.png");
       }
    
     void render()
       {
          pushMatrix();
            noStroke();
            translate(ex, ey);
              if (closeToBalloon == true)
                { 
                   scale(.6);
                   image(angryCloud, 5, -38);
                } 
              else
                {
                   scale(.4);
                   image(badCloud.get(183, 239, 700, 300), 0, 0);
                }
          popMatrix();
       }
    
     void move()
       {
          int balloonTolerance = 70;        
          float balPos = map(balX, -500, 500, -20, 250);        
          
          if (ex >= (balPos - 15) && ex <= (balPos + 15) && ey <= (balY - balloonTolerance))
            caught = true;
        
          if (gotPowerUp == true)
            {
               ey = ey + 23;
            } 
          else
            {
              ex = lerp(ex, balPos, .2);
                    
               if (ey >= balY - balloonTolerance)       //Follow the Balloon's ypos
                 {
                    ey = ey - speed;
                 }               
               if (ey <= balY - balloonTolerance)    // dont go over the balloon height
                 {
                    ey = balY - balloonTolerance;
                 }
            } 
          
            if (ey <= 300)              //check if the enemy is close to the balloon
              closeToBalloon = true;       
            else
              closeToBalloon = false;
       }
  }
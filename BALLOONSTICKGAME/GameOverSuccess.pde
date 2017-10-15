class GameOverSuccess extends GameOverAbstractClass
  {
     int R, G, B;
     int clothCount = 5;
     int limit = 60;
     int speed = 3;
     int changeTime = 30;
     int circles = 10;
     float[] x = new float[circles];
     float[] y = new float[circles];
     float[] dx = new float[circles];
     float[] dy = new float[circles];
     float[] csize = new float[circles];
     float newX;
     float newY;
     PVector [] clothPos = new PVector[clothCount];
     boolean leftRight = true;
     
     GameOverSuccess()
       {  
          textColorChange();
          initialGameOver();
          clothPos[0] = new PVector(0, 0);
          clothPos[1] = new PVector(0, -20);
          clothPos[2] = new PVector(0, -30);
          clothPos[3] = new PVector(0, -40);
          clothPos[4] = new PVector(0, -50);
          for (int i = 0; i < circles; i++)
            {
               x[i] = width / 2;
               y[i] = width / 2;
               dx[i] = random(-speed, speed);
               dy[i] = random(-speed, speed);
               csize[i] = random(10, 30);
            }
          newX = random(-width / 4, width / 4);
          newY = random(-height / 4, height / 4); 
       }  
    
     void GameOverRender() 
       {
          pushMatrix();            
            fill(0);
            textSize(60);
            ambient(R, G, B);
            text("You Win!", 140, height / 2);       
            fireWorks();
            if (frameCount % 3 == 0)
              {
                textColorChange();
              }
            for(int i = 0; i < clothCount; i++)
              {
                 pushMatrix();
                   translate(clothPos[i].x, clothPos[i].y);
                   flyingCloth();   
                 popMatrix();
              }            
          popMatrix();
          movePieces();
       }
      
     void fireWorks()
       {
          pushMatrix();
            translate(newX, newY, 40);
              for (int i = 0; i < circles; i++) 
                {
                   fill(R, G, B);                  
                   ellipse(x[i], y[i], csize[i], csize[i]);
                  
                   x[i] = x[i] + dx[i];
                   y[i] = y[i] + dy[i];
              
                  if(x[i] < width / 2 - limit || x[i] > width / 2 + limit || y[i] < height / 2 - limit || y[i] > height / 2 + limit)
                    {
                       x[i] = width / 2;
                       y[i] = height / 2;
                       dx[i] = random(-speed, speed);
                       dy[i] = random(-speed, speed);
                    }
                  if(frameCount % changeTime == 0)
                    {
                       newX = random(-width/4, width/4);
                       newY = random(-height/4, height/4); 
                    }
                }
            popMatrix();
       }
      
     void movePieces()
       {
          int range = 23;
          if(leftRight)
            {
               clothPos[1].x += lerp(0, range, .1);
               clothPos[2].x -= lerp(0, range, .2);
               clothPos[3].x += lerp(0, range, .5);
               clothPos[4].x -= lerp(0, range, .3);
               if(clothPos[1].x > range)
                 leftRight = false;
            }           
          else
            {
               clothPos[1].x -= lerp(0, range, .1);
               clothPos[2].x += lerp(0, range, .2);
               clothPos[3].x -= lerp(0, range, .5);
               clothPos[4].x += lerp(0, range, .3);
               if(clothPos[1].x < -range)
                 leftRight = true;
            }
       }
      
     void textColorChange()
       {
           R = int(random(255));
           G = int(random(255));
           B = int(random(255));
       }
  }
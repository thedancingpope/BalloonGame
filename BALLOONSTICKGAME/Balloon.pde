class Balloon
  {    
    int rotZ = 0;
    int lastZ = 0;
    int balZ = 0;
               
    float angle = 0.0f;
    float angleIncrement = TWO_PI / 90;                 //to draw the sides of the cone     
    float balloonScale = 1.0f;
    float ballInc = .02f;
    BalloonString BalloonString;    
        
    void drawBalloon()
      {      
         BalloonString = new BalloonString();
         if (gotPowerUp) 
           {
             if(balloonScale < 1.14)
               {
                 balloonScale += ballInc;                  
               }
             if(lineZ < 65)
               lineZ += 8;
           }
         else 
           {
             if(balloonScale > 1.0)
               {
                 balloonScale -= ballInc;
               }
             if(lineZ > 10)
               lineZ -= 8;
           }
         pushMatrix();  
           ambientLight(205, 205, 205);                    // the color put out by the light on everything
           lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
           directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
           specular(180, 180, 180);                        // removes the this color when lit up
           shininess(9.0);                                  // the larger the number the smaller the shiny circle
           pushMatrix();                        //draw as one matrix together
             translate(width/2, height/2);                 //the center of the screen coordinates are (0 , 0, 0)
               scale(.4); 
               scale(balloonScale);  
               if(gotPowerUp)
                 ambient(244, 255, 126);
               else 
                 ambient(150, 150, 0);                          //light the balloon this color
               translate(balX,0, 40);                         //move the whole balloon as one object, based on the input from user
                 rotateZ(map(rotZ, -15, 15, -1, 1));              //rotate the whole balloon on the Z-axis when moving side to side
                 noStroke();                                      //draw no edges
                 fill(50,50,0);                                 //color the whole balloon
                 drawCone(70, 17, 5, 100);        //draw the large cone
                 drawCone(5, 100, 10, 110);       //draw the small cone
                 translate(0,-40,0);                          //moves to just above the center
                   sphere(90);                                      //main sphere of balloon           
                   translate(0, 0, 0);                            //goes back to center 
                     noFill();
                     stroke(0);                                     //black string
                     strokeWeight(4);                               //width of the string
                     line(-6, 136, 9, 6, 135, 8);          //draw the lines around the bottom of the balloon
                     line(-6, 135, 8, -10, 135, 0);              //to look like it is tied around
                     line(6, 135, 8, 10, 135, 0);                //the bottom of the balloon, used 3 lines  
                     scale(1.0);
           popMatrix();
           scale(balloonScale);
           lineX = (width/2) + map(balX, -500, 500, -203, 203) + (rotZ * -2.1);//draws the start of the string based on where the bottom of the balloons cone is 
           lineY = 290 - abs(map(rotZ, -15, 15, -20, 20));
         popMatrix();        
      } 
     
    void moveBalloon()
      {
       int centerBalloon = 3;
       int incBalloon = 12;
        
       if(rightTrue == true)        // rotate balloon if pressing key
         {                
            if(balX < width)        // increase rotation to one side
              {   
                balX += incBalloon;       
                if(lastZ < 15)               //only rotate if it hasn't reached its limit to rotate
                  rotZ += 5;
                else
                  rotZ = 15;                   // rotate until this point
              }
         }
       else if(leftTrue == true)        // increase rotation the other way
         {
            if(balX > -width)
              {
                 balX -= incBalloon;
                 if(lastZ > -15)
                   rotZ -= 5;
                 else
                   rotZ = -15;         // rotate until this point
              }
         }      
       else if (rightTrue == false && leftTrue == false)     //if not pressing key 
         {
           if(rotZ > 0)             //rotate back to center
             rotZ -= centerBalloon; 
           if(rotZ < 0)
             rotZ += centerBalloon;
         }  
       lastZ = rotZ;
     }
     
   void drawCone(int XZ1, int Y1, int XZ2, int Y2)
     {
       beginShape(QUAD_STRIP);                     
         for (int i = 0; i < 92; i++)                   //there are 92 sides on the cone to smooth it out    
           {                                              
             vertex(XZ1*cos(angle), Y1, XZ1*sin(angle));      //draw the top of the cone at vertex(x, y, z)
             vertex(XZ2*cos(angle), Y2, XZ2*sin(angle));       //draw the bottom of the cone at vertex(x, y, z)
             angle += angleIncrement;                       //increases the angle to draw the base of the cones     
           }                                                 
       endShape();
     }
  }
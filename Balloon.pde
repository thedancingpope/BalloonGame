class Balloon
  {
    
    int rotZ=0;
    int lastZ=0;
               
    float angle = 0;
    float angleIncrement = TWO_PI / 90;                 //to draw the sides of the cone     
    
    BalloonString BalloonString;    
        
    void drawBalloon()
      {      
       BalloonString = new BalloonString();
       noStroke();                                      //draw no edges
       fill(50,50,0);                                 //color the whole balloon
       ambientLight(205, 205, 205);                    // the color put out by the light on everything
       translate(width/2, height/2, 0);                 //the center of the screen coordinates are (0 , 0, 0)
       scale(.4);
       pushMatrix();                                //draw as one matrix together
        
        lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
        directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
        specular(180, 180, 180);                        // removes the this color when lit up
        shininess(9.0);                                  // the larger the number the smaller the shiny circle
       if(gotPowerUp)
          ambient(180, 100, 20);
        else 
          ambient(150, 150, 0);                          //light the balloon this color
         
                     
         translate(balX,0, 40);                         //move the whole balloon as one object, based on the input from user
         rotateZ(map(rotZ, -15, 15, -1, 1));              //rotate the whole balloon on the Z-axis when moving side to side
                                                        //other wise it is upright
         beginShape(QUAD_STRIP);                      //draw the large cone
           for (int i = 0; i < 91; ++i)                   //there are 90 sides on the cone to smooth it out    
             {                                              
             vertex(70*cos(angle), 17, 70*sin(angle));      //draw the top of the cone at vertex(x, y, z)
             vertex(5*cos(angle), 100, 5*sin(angle));       //draw the bottom of the cone at vertex(x, y, z)
             angle += angleIncrement;                       //increases the angle to draw the base of the cones     
             }                                                 
           endShape();
      
           beginShape(QUAD_STRIP);                      //draw the small cone
             for (int i = 0; i < 91; ++i)                   
               {
               vertex(5*cos(angle), 100, 5*sin(angle));     //draw the top of the cone at vertex(x, y, z)  change the y values to 
               vertex(10*cos(angle), 110, 10*sin(angle));   //draw the bottom of the cone at vertex(x, y, z)
               angle += angleIncrement;                     //increases the angle to draw the base of the cones
               }
             endShape();
    
           translate(0,-40,0);                          //moves to just above the center
           
           sphere(90);                                      //main sphere of balloon
           
                    
           translate(0, 0, 0);                            //goes back to center 
           noFill();
           stroke(0);                                     //black string
           strokeWeight(4);                               //width of the string
             line(-6, 136, 9, 6, 135, 8);          //draw the lines around the bottom of the balloon
             line(-6, 135, 8, -10, 135, 0);              //to look like it is tied around
             line(6, 135, 8, 10, 135, 0);                //the bottom of the balloon, used 3 lines  
                
       popMatrix();                                  //close the matrix and draw the next part separate from
       //print(balX);
       lineX = balX+(rotZ*-4)+(map(balX, -500, 500, -15, 15));                  //draws the start of the string based on where the bottom of the balloons cone is   //
       lineY = 100-abs(rotZ*3);                  // it moves the line with the balloon based on the rotZ value 
      
      strokeWeight(3);                                // the screen is still centered from the translate before the pushMatrix started
      line(lineX-map(balX, -500, 500, -10, 10), lineY, 40, lineX+30, lineY+(sin(angle)*3), 40);      // draws the string on the right side waving in the wind
      scale(1);
      
      
      } 
     
    void moveBalloon()
      {
         //if(keyPressed == true)                 // rotate balloon if pressing key
           //{
           //if(key == 'd' || key =='D')            // increase rotation to one side
             //{
             if(rightTrue == true)
               {
                
               if(balX < (width))
                  {   
                    balX+=10;       
                    if(lastZ < 15)               //only rotate if it hasn't reached its limit to rotate
                      {
                       rotZ += 5;
                      }  
                    else
                      {
                       rotZ = 15;                   // rotate until this point
                      }
                  }
               }
           //if(key =='a' || key == 'A')             // increase rotation the other way
           if(leftTrue == true)
             {
              if(balX > -(width))
                {
                 balX-=10;
                 if(lastZ > -15)
                   {
                   rotZ -= 5;
                   }
                 else
                   {
                   rotZ = -15;                  // rotate until this point
                   }
                }
             }
          // }
         if (rightTrue == false && leftTrue == false)               //if not pressing key 
           {
             if(rotZ > 0)                          //rotate back to center
               {
                  rotZ -= 3; 
               }
             if(rotZ < 0)
               {
                  rotZ += 3;
               }
           }  
         lastZ = rotZ;
     
      }
    
  }

class Balloon
{ 
  float lineX, lineY, lineZ, balloonScale;  

  int rotZ, lastZ, balZ;

  BalloonString BalloonString;

  Balloon()
  {
    BalloonString = new BalloonString();    
    lineZ = 10f;
    balloonScale = 1.0f;
    rotZ = 0;
    lastZ = 0;
    balZ = 0;
  }

  void drawBalloon()
  { 
    float ballInc = .02f; 
    if (gotPowerUp) 
    {
      if (balloonScale < 1.14f)
        balloonScale += ballInc;
      if (lineZ < 65)
        lineZ += 8;
    } 
    else 
    {
      if (balloonScale > 1.0f)
        balloonScale -= ballInc;
      if (lineZ > 10)
        lineZ -= 8;
    }
    pushMatrix();  
    GamePhases.BalloonLighting();
    pushMatrix();                      
    translate(width / 2, height / 2);                 
    scale(.4); 
    scale(balloonScale);  
    translate(balX, 0, 40);
    rotateZ(map(rotZ, -15, 15, -1, 1)); 
    noStroke();                                 
    fill(50, 50, 0);
    drawCone(70, 17, 5, 100);        //draw the large cone
    drawCone(5, 100, 10, 110);       //draw the small cone
    translate(0, -40, 0);                       
    sphere(90);                                         
    noFill();
    stroke(0);                                    
    strokeWeight(4);                              
    line(-6, 136, 9, 6, 135, 8);              //draw the lines around the bottom of the balloon
    line(-6, 135, 8, -10, 135, 0);              //to look like it is tied around
    line(6, 135, 8, 10, 135, 0);                //the bottom of the balloon, used 3 lines  
    scale(1.0);
    popMatrix();
    scale(balloonScale);
    lineX = (width/2) + map(balX, -500, 500, -203, 203) + (rotZ * -2.1);//draws the start of the string based on where the bottom of the balloons cone is 
    lineY = 290 - abs(map(rotZ, -15, 15, -20, 20));
    popMatrix();
    BalloonString.drawBalloonString(lineX, lineY, lineZ);
  } 

  void moveBalloon()
  {
    int centerBalloon = 3;
    int incBalloon = 12;
    int rotLimit = 15;
    int rotInc = 3;

    if (rightTrue)  
    {                
      if (balX < width) 
      {   
        balX += incBalloon;       
        if (lastZ < rotLimit)
          rotZ += rotInc;
        else
          rotZ = rotLimit;
      }
    } 
    else if (leftTrue)       
    {
      if (balX > -width)
      {
        balX -= incBalloon;
        if (lastZ > -rotLimit)
          rotZ -= rotInc;
        else
          rotZ = -rotLimit;
      }
    } 
    else if (!rightTrue && !leftTrue) //rotate back to center
    {
      if (rotZ > 0)            
        rotZ -= centerBalloon; 
      if (rotZ < 0)
        rotZ += centerBalloon;
    }  
    lastZ = rotZ;
  }

  void drawCone(int XZ1, int Y1, int XZ2, int Y2)
  {
    float angleIncrement = TWO_PI / 90; 
    float angle = 0.0f;

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
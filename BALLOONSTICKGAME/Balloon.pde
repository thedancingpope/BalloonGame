class Balloon
{ 
  float balloonScale;  
  PVector linePos;
  int rotZ, lastZ;
  BalloonString BalloonString;

  Balloon()
  {
    BalloonString = new BalloonString();    
    linePos = new PVector(0, 0, 10);
    balloonScale = .4f;
    rotZ = 0;
    lastZ = 0;
  }

  void render()
  { 
    float ballInc = .02f;
    float rotCompensation;
    if(Phases.gotPowerUp) 
    {
      rotCompensation = -3.8;
      if(balloonScale < .54f)
        balloonScale += ballInc;
      if(linePos.z < 40)
        linePos.z += 5;
    } 
    else 
    {
      rotCompensation = -3.5;
      if(balloonScale > .4f)
        balloonScale -= ballInc;
      if(linePos.z > 15)
        linePos.z -= 5;
    } 
    linePos.x = map(balPos.x, -200, 200, -215, 215) + (width/2) + (rotZ * rotCompensation); 
    linePos.y = 311 - abs(rotZ * 2);

    Phases.lighting();
    pushMatrix(); 
    noStroke();                                 
    fill(50, 50, 0);
    translate(balPos.x + (width / 2), balPos.y, 40);
    rotateZ(map(rotZ, -15, 15, -1, 1)); 
    scale(balloonScale);                       
    sphere(90); 
    drawCone(70, 57, 5, 140);        //draw the large cone
    drawCone(5, 140, 10, 150);       //draw the small cone                                                                  
    noFill();
    stroke(0);        
    drawCone(7, 137, 7, 141);     //draw the balloon tie
    popMatrix();   

    BalloonString.render(linePos); } 

  void move()
  {
    int incBalloon = 6;
    int rotLimit = 15;
    int rotInc = 3;

    if(rightTrue && !leftTrue)  
    {                
      if(balPos.x < 200) 
      {   
        balPos.x += incBalloon;       
        if(lastZ < rotLimit)
          rotZ += rotInc;
        else
          rotZ = rotLimit;
      }
    } 
    if(leftTrue && !rightTrue)       
    {
      if(balPos.x > -200)
      {
        balPos.x -= incBalloon;
        if(lastZ > -rotLimit)
          rotZ -= rotInc;
        else
          rotZ = -rotLimit;
      }
    } 
    if(!rightTrue && !leftTrue)
    {
      if(rotZ > 0)            
        rotZ -= rotInc; 
      if(rotZ < 0)
        rotZ += rotInc;
    }  
    lastZ = rotZ;
  }

  void drawCone(int XZ1, int Y1, int XZ2, int Y2)
  {
    float angleIncrement = TWO_PI / 90; 
    float angle = 0.0f;

    beginShape(QUAD_STRIP);                     
    for (int i = 0; i < 92; i++)  
    {                                              
      vertex(XZ1*cos(angle), Y1, XZ1*sin(angle));
      vertex(XZ2*cos(angle), Y2, XZ2*sin(angle));
      angle += angleIncrement;
    }                                                 
    endShape();
  }
}

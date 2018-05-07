class Balloon
{ 
  float balloonScale, rotZ, lastZ;  
  PVector stringPos;
  BalloonString BalloonString;

  Balloon()
  {
    BalloonString = new BalloonString();    
    stringPos = new PVector(0, 0, 10);
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
      if(stringPos.z < 40)
        stringPos.z += 5;
    } 
    else 
    {
      rotCompensation = -3.5;
      if(balloonScale > .4f)
        balloonScale -= ballInc;
      if(stringPos.z > 15)
        stringPos.z -= 5;
    } 
    stringPos.x = map(balPos.x, -200, 200, -215, 215) + (width/2) + (rotZ * rotCompensation); 
    stringPos.y = 311 - abs(rotZ * 2);

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

    BalloonString.render(stringPos); 
  } 

  void move()
  {
    int incBalloon = 6;
    float rotLimit = 15;
    float rotInc = .2f;

    if(rightTrue && !leftTrue)  
    {                
      if(balPos.x < 200) 
      {   
        balPos.x += incBalloon;       
        rotZ = lerp(rotZ, rotLimit, rotInc);
      }
    } 
    if(leftTrue && !rightTrue)       
    {
      if(balPos.x > -200)
      {
        balPos.x -= incBalloon;
        rotZ = lerp(rotZ, -rotLimit, rotInc);
      }
    } 
    if(!rightTrue && !leftTrue)
    {
      rotZ = lerp(rotZ, 0, rotInc);
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

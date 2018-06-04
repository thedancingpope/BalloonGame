class Balloon extends GameObjectAbstract
{
  float balloonScale, rotZ, lastZ;
  PVector stringPos;
  PGraphics balloonLayer;
  boolean powerUp;
  BalloonString BalloonString;

  Balloon()
  {
    BalloonString = new BalloonString();
    balloonLayer = createGraphics(width, height, P3D);
    stringPos = new PVector(width / 2, 0, 40);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    balloonScale = .4f;
    rotZ = 0.0f;
    lastZ = 0.0f;
    powerUp = false;
  }

  void render()
  { 
    BalloonString.render(stringPos);
    balloonLayer.beginDraw();      
    balloonLayer.background(205, 205, 205, 0);
    balloonLayer.ambientLight(205, 205, 205);
    balloonLayer.lightSpecular(205, 205, 205);
    balloonLayer.directionalLight(205, 205, 205, 1, 1, -2);    
    balloonLayer.specular(180, 180, 180);
    balloonLayer.shininess(9.0);
    if(powerUp)
      balloonLayer.ambient(244, 255, 126);
    else 
      balloonLayer.ambient(150, 150, 0); 
    balloonLayer.pushMatrix(); 
    balloonLayer.noStroke(); 
    balloonLayer.fill(50, 50, 0);
    balloonLayer.translate(balPos.x, balPos.y, 40);
    balloonLayer.rotateZ(rotZ); 
    balloonLayer.scale(balloonScale);                       
    balloonLayer.sphere(90); 
    drawCone(70, 57, 5, 140);        //draw the large cone
    drawCone(5, 140, 10, 150);       //draw the small cone                                                                  
    balloonLayer.noFill();
    balloonLayer.stroke(0);        
    drawCone(7, 137, 7, 141);     //draw the balloon tie
    balloonLayer.popMatrix(); 
    balloonLayer.noLights();
    balloonLayer.endDraw();
    image(balloonLayer, 0, 0);
  } 

  void move()
  {
    float edge = 50f;
    float changeDir = 0.7f;    
    int rotLimit = 10;
    int z = round(rotZ * 10);
    PVector move = new PVector(.45f, 0); 
    PVector stop = velocity.copy();
    stop.mult(-1);
    stop.normalize();
    stop.mult(.4f);    
    if(rightTrue && !leftTrue)  
    {                
      if(balPos.x < (width - edge)) 
      {   
        if(velocity.x < 0)
          velocity.mult(changeDir);
        acceleration.add(move);
        velocity.add(acceleration);  
        acceleration.mult(0.2);        
      }  
      else 
      {
        acceleration.add(stop);
        velocity.add(acceleration);
        acceleration.mult(0);
      }   
      if(z < rotLimit)
        z ++;
      if(z > rotLimit)
        z = rotLimit;
    } 
    else if(leftTrue && !rightTrue)       
    {
      if(balPos.x > edge)
      {
        if(velocity.x > 0)
          velocity.mult(changeDir);
        acceleration.add(move);
        velocity.sub(acceleration);              
        acceleration.mult(0.2); 
      }      
      else 
      {
        acceleration.add(stop);
        velocity.add(acceleration);
        acceleration.mult(0);
      }
      if(z > -rotLimit)
        z --;
      if(z < -rotLimit)
        z = -rotLimit;
    } 
    else
    {      
      PVector friction = velocity.copy();
      friction.mult(-1);
      friction.normalize();
      friction.mult(.25f);
      acceleration.add(friction);      
      velocity.add(acceleration);  
      acceleration.mult(0);        
      if(z > 0)
        z --;        
      else if(rotZ < 0)
        z ++;
    }
    velocity.limit(6);
    balPos.add(velocity);
    rotZ = z * .1f;
    lastZ = rotZ;
    powerUp = Phases.gotPowerUp;
    float ballInc = .02f;
    if(powerUp) 
    {
      if(balloonScale < .54f)
        balloonScale += ballInc;
    } 
    else 
    { 
      if(balloonScale > .4f)
        balloonScale -= ballInc;
    }   
    float mX = map(balloonScale, .4, .54, 48, 54);
    stringPos.x = balPos.x - (rotZ * mX);
    float mY = map(balloonScale, .4, .54, 26, 27);
    float tieGap = map(balloonScale, .4, .54, 57, 65);
    stringPos.y = (balPos.y + tieGap) - (abs(rotZ) * mY);    
  }

  void drawCone(int XZ1, int Y1, int XZ2, int Y2)
  {
    float angleIncrement = TWO_PI / 90; 
    float angle = 0.0f;
    balloonLayer.beginShape(QUAD_STRIP);                     
    for(int i = 0; i < 92; i++)  
    {                                              
      balloonLayer.vertex(XZ1*cos(angle), Y1, XZ1*sin(angle));
      balloonLayer.vertex(XZ2*cos(angle), Y2, XZ2*sin(angle));
      angle += angleIncrement;
    }                                                 
    balloonLayer.endShape();
  }
}

class TextCanvas extends GameObjectAbstract
{
  PGraphics textLayer;  
  float [] phaseStartingTime;
  int timeSurvived;
  String qButton, controls;
  
  TextCanvas()
  {
    textLayer = createGraphics(width, height);
    pos = new PVector(10, height - 40);
    acceleration = new PVector(0, .5f);
    velocity = new PVector(0, 0);
    phaseStartingTime = new float [7];    
    qButton = "Press Q for freedom.";
    controls = "Use A and D to steer.";
  }
  
  void render()
  {
    move();
    textLayer.beginDraw();
    textLayer.background(0, 0);
    textLayer.textSize(20);
    if(phase == 0)
    {
      textLayer.fill(255);
      textLayer.text(qButton, 30, 100);
      textLayer.text(controls, 30, 50);
    }
    if(phase > 1)
    {
      textLayer.fill(0);
      textLayer.text("Survived: ", pos.x, pos.y);
    }
    if(phase == 2)
    {                   
      timeSurvived = int((millis() / 1000) - phaseStartingTime[2]);
      textLayer.text(timeSurvived, pos.x + 100, pos.y);
    } 
    else if(phase > 2 && phase < 6)
    {      
      textLayer.text("Win!", pos.x + 100, pos.y);
    } 
    if(phase > 3)
      resetText();
    if(phase == 6)
    {
      textLayer.text(timeSurvived, pos.x + 100, pos.y);
      textLayer.fill(255, 0, 0);
      int countDown = int((timeSurvived * 2) - ((millis() / 1000) - phaseStartingTime[2]));      
      textLayer.text(countDown, pos.x + 100, pos.y + 20);      
    }
    textLayer.endDraw();  
    if(gameLayers[9])
      image(textLayer, 0, 0);
  }
  
  void move()
  {
    if(phase == 3 && (millis() / 1000) > phaseStartingTime[3] + 1.0f)
    {
      if(pos.y < height + 20)
        addForce();
      else
        velocity.mult(0);
    }
    if(phase == 5 && (millis() / 1000) > phaseStartingTime[5] + 1.0f)
    {
      if(pos.y > height - 40)
        addForce();
      else
        velocity.mult(0);
    }   
  }
  
  void resetText()
  {
    textLayer.fill(0);
    textLayer.text("Press 'R' to replay", 40, 50);
  }
  
  void addForce()
  {
    velocity.add(acceleration);            
    velocity.limit(3);
    pos.add(velocity);      
  }
  
  void setText()
  {
    if(phase == 3)
      pos = new PVector(10, height - 40);
    else if(phase == 4)
      pos = new PVector(10, height + 20);
    else if(phase == 5)
      pos = new PVector(10, height + 20);
  }
  
  float phaseStartTime(int _p)
  {
    return phaseStartingTime[_p]; 
  }
  
  void setStartTime(int _p)
  {
    phaseStartingTime[_p] = millis() / 1000f;
  }
}

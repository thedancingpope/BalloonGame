class GameOverSuccess extends GameOverAbstractClass
{
  color textColor; 
  int clothCount, fwCount, fwMax, waitTime, previousTime;
  boolean leftRight;
  FireWorks [] FW;
  Clothes [] Cloth;

  GameOverSuccess()
  {  
    clothCount = 5;
    leftRight = true;
    textColor = colorChange();
    fwMax = 5;
    FW = new FireWorks [fwMax];    
    setFireWorks();
    Cloth = new Clothes [clothCount];
    Cloth[0] = new Clothes(new PVector(0, 0), 0f);
    Cloth[1] = new Clothes(new PVector(0, -20), 0.1f);
    Cloth[2] = new Clothes(new PVector(0, -30), 0.2f);
    Cloth[3] = new Clothes(new PVector(0, -50), 0.5f);
    Cloth[4] = new Clothes(new PVector(0, -40), 0.3f);
  }  

  void render() 
  { 
    if((millis() - previousTime) / 1000 > waitTime)
      setFireWorks();
    movePieces();
    for(int i = 0; i < clothCount; i++)
      Cloth[i].render();
    for(int j = 0; j < fwCount; j++)
      FW[j].render();
    winText();
    resetText();
  }
  
  void movePieces()
  {
    int range = 23;    
    for (int i = 1; i < clothCount; i++)
    {
      if(leftRight)
      {
        if(i % 2 == 0)
          Cloth[i].pos.x -= lerp(0, range, Cloth[i].speed);
        else
          Cloth[i].pos.x += lerp(0, range, Cloth[i].speed);                       
        if(Cloth[1].pos.x > range)
          leftRight = false;
      } 
      else
      {
        if(i % 2 == 0)
          Cloth[i].pos.x += lerp(0, range, Cloth[i].speed);
        else
          Cloth[i].pos.x -= lerp(0, range, Cloth[i].speed);    
        if(Cloth[1].pos.x < -range)
          leftRight = true;
      }
    }
  }

  void setFireWorks()
  { 
    previousTime = millis();
    waitTime = int(random(1, 4));
    fwCount = int(random(2, fwMax + 1));
    for(int i = 0; i < fwCount; i++)
    {
      color c = colorChange(); 
      FW[i] = new FireWorks(c);      
    }
  }

  void winText()
  {
    fill(0);
    textSize(60);
    ambient(textColor);
    fill(textColor); 
    text("You Win!", 140, height / 2);
    if(frameCount % 3 == 0)
      textColor = colorChange();
  } 
  
  color colorChange()
  {
    int R = int(random(255));
    int G = int(random(255));
    int B = int(random(255));
    return color(R, G, B);
  }  
}

class GameOverSuccess extends GameOverAbstractClass
{
  color textColor; 
  int clothCount, fwCount, fwMax, waitTime, previousTime;
  boolean leftRight;
  FireWorks [] FW;
  Clothes [] Clothes;

  GameOverSuccess()
  {  
    clothCount = 5;
    leftRight = true;
    textColor = colorChange();
    initialGameOver();
    fwMax = 4;
    FW = new FireWorks [fwMax];    
    setFireWorks();
    Clothes = new Clothes [clothCount];
    Clothes[0] = new Clothes(new PVector(0, 0), 0f);
    Clothes[1] = new Clothes(new PVector(0, 20), 0.1f);
    Clothes[2] = new Clothes(new PVector(0, 30), 0.2f);
    Clothes[3] = new Clothes(new PVector(0, 50), 0.5f);
    Clothes[4] = new Clothes(new PVector(0, 40), 0.3f);
  }  

  void render() 
  { 
    if((millis() - previousTime) / 1000 > waitTime)
      setFireWorks();
    movePieces();
    for(int i = 0; i < clothCount; i++)
    {
      pushMatrix();
      translate(Clothes[i].pos.x, -Clothes[i].pos.y);
      Cloth();   
      popMatrix();
    }   
    for(int j = 0; j < fwCount; j++)
      FW[j].render();
    winText();
    resetText();
  }
  
  void movePieces()
  {
    int range = 23;    
    float inc = 1;
    //Clothes[1].pos.y = lerp(Clothes[1].pos.y, -20, inc);
    //Clothes[2].pos.y = lerp(Clothes[2].pos.y, -30, inc);
    //Clothes[3].pos.y = lerp(Clothes[3].pos.y, -50, inc);
    //Clothes[4].pos.y = lerp(Clothes[4].pos.y, -40, inc);
    for (int i = 1; i < clothCount; i++)
    {
      if(leftRight)
      {
        if(i % 2 == 0)
          Clothes[i].pos.x -= lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].pos.x += lerp(0, range, Clothes[i].speed);                       
        if(Clothes[1].pos.x > range)
          leftRight = false;
      } 
      else
      {
        if(i % 2 == 0)
          Clothes[i].pos.x += lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].pos.x -= lerp(0, range, Clothes[i].speed);    
        if(Clothes[1].pos.x < -range)
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

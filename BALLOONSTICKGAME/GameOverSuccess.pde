class GameOverSuccess extends GameOverAbstractClass
{
  color textColor; 
  int clothCount, fwCount;
  boolean leftRight;
  FireWorks [] FW;
  Clothes [] Cloth;

  GameOverSuccess()
  {  
    clothCount = 5;
    leftRight = true;
    textColor = colorChange();
    fwCount = 5;
    FW = new FireWorks [fwCount];
    for(int i = 0; i < fwCount; i++)
      setFireWorks(i);
    Cloth = new Clothes [clothCount];
    Cloth[0] = new Clothes(new PVector(0, 0), 0f);
    Cloth[1] = new Clothes(new PVector(0, -20), 0.1f);
    Cloth[2] = new Clothes(new PVector(0, -30), 0.2f);
    Cloth[3] = new Clothes(new PVector(0, -50), 0.5f);
    Cloth[4] = new Clothes(new PVector(0, -40), 0.3f);
  }  

  void render() 
  {
    movePieces();
    for(int i = 0; i < clothCount; i++)
      Cloth[i].render();
    for(int j = 0; j < fwCount; j++)
    {
      if(FW[j].lifeTime <= 0)
        setFireWorks(j); 
      FW[j].render();
    }
    winText();
    resetText();
  }

  void movePieces()
  {
    int range = 23;    
    for(int i = 1; i < clothCount; i++)
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

  void setFireWorks(int n)
  {
    int t = int(random(30, 130));
    color c = colorChange(); 
    FW[n] = new FireWorks(c, t);
  }

  void winText()
  {
    fill(0);
    textSize(60);
    ambient(textColor);
    fill(textColor); 
    text("You Win!", 140, height / 2);
    if(frameCount % 4 == 0)
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

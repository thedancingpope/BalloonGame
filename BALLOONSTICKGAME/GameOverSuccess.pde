class GameOverSuccess
{
  color textColor; 
  int clothCount, fwCount;
  boolean leftRight;
  PGraphics winTextLayer, clothesLayer;
  FireWorks [] FW;
  Clothes [] Cloth;

  GameOverSuccess()
  {  
    clothCount = 5;
    leftRight = true;
    textColor = colorChange();
    clothesLayer = createGraphics(width, height, P3D);
    winTextLayer = createGraphics(width, height, P3D);
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
    for(int j = 0; j < fwCount; j++)
    {
      if(FW[j].alive())
        FW[j].render(); 
      else
        setFireWorks(j);
    }
    winText();
    movePieces();
    for(int i = 0; i < clothCount; i++)
      {
        clothesLayer.beginDraw();
        clothesLayer.background(205, 205, 205, 0);        
        Cloth[i].render(clothesLayer);
        clothesLayer.endDraw();  
        if(gameLayers[7])
          image(clothesLayer, 0, 0); 
      }
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
    winTextLayer.beginDraw();
    winTextLayer.background(textColor, 0);
    winTextLayer.fill(0);
    winTextLayer.textSize(60);
    winTextLayer.noLights();
    winTextLayer.fill(textColor); 
    winTextLayer.text("You Win!", 140, height / 2);
    winTextLayer.endDraw();      
    if(gameLayers[5])
      image(winTextLayer, 0, 0);
    if(frameCount % 5 == 0)
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

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
    Cloth[1] = new Clothes(new PVector(0, -20), 0.2f);
    Cloth[2] = new Clothes(new PVector(0, -30), 0.5f);
    Cloth[3] = new Clothes(new PVector(0, -40), 0.5f);
    Cloth[4] = new Clothes(new PVector(0, -50), 0.2f);
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
    clothesLayer.beginDraw();
    clothesLayer.background(205, 205, 205, 0);
    clothesLayer.noStroke();
    clothesLayer.fill(50, 50, 0);  
    clothesLayer.ambientLight(205, 205, 205);
    clothesLayer.ambient(244, 255, 126);
    for(int i = 0; i < clothCount; i++)
      Cloth[i].render(clothesLayer);
    clothesLayer.endDraw();  
    if(gameLayers[7])
      image(clothesLayer, 0, 0); 
  }

  void movePieces()
  {
    int range = 25;    
    for(int i = 1; i < clothCount; i++)
    {
      if(Cloth[i].leftRight)
      {
        if(i % 2 == 0)
          Cloth[i].velocity.sub(Cloth[i].acceleration);
        else
          Cloth[i].velocity.add(Cloth[i].acceleration);
        if(Cloth[1].pos.x > range)
          Cloth[i].leftRight = !Cloth[i].leftRight;
      } 
      else
      {
        if(i % 2 == 0)
          Cloth[i].velocity.add(Cloth[i].acceleration);
        else
          Cloth[i].velocity.sub(Cloth[i].acceleration);
        if(Cloth[1].pos.x < -range)
          Cloth[i].leftRight = !Cloth[i].leftRight;
      }
      Cloth[i].velocity.limit(6f);
      Cloth[i].pos.add(Cloth[i].velocity);
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

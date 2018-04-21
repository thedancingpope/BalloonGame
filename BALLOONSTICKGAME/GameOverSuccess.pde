class GameOverSuccess extends GameOverAbstractClass
{
  color textColor; 
  int clothCount;
  boolean leftRight;
  FireWorks FW;
  Clothes [] Clothes;

  GameOverSuccess()
  {  
    clothCount = 5;
    leftRight = true;
    textColor = colorChange();
    initialGameOver();
    FW = new FireWorks();
    Clothes = new Clothes [clothCount];
    Clothes[0] = new Clothes(new PVector(0, 0), 0f);
    Clothes[1] = new Clothes(new PVector(0, -20), 0.1f);
    Clothes[2] = new Clothes(new PVector(0, -30), 0.2f);
    Clothes[3] = new Clothes(new PVector(0, -40), 0.5f);
    Clothes[4] = new Clothes(new PVector(0, -50), 0.3f);
  }  

  void render() 
  {   
    movePieces();
    for (int i = 0; i < clothCount; i++)
    {
      pushMatrix();
      translate(Clothes[i].pos.x, Clothes[i].pos.y);
      renderCloth();   
      popMatrix();
    }
    FW.render();
    winText();
    resetText();
  }
  
  void movePieces()
  {
    int range = 23;               
    for (int i = 1; i < clothCount; i++)
    {
      if (leftRight)
      {
        if (i % 2 == 0)
          Clothes[i].pos.x -= lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].pos.x += lerp(0, range, Clothes[i].speed);                       
        if (Clothes[1].pos.x > range)
          leftRight = false;
      } 
      else
      {
        if (i % 2 == 0)
          Clothes[i].pos.x += lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].pos.x -= lerp(0, range, Clothes[i].speed);    
        if (Clothes[1].pos.x < -range)
          leftRight = true;
      }
    }
  }

  void winText()
  {
    fill(0);
    textSize(60);
    ambient(textColor);
    fill(textColor); 
    text("You Win!", 140, height / 2);
    if (frameCount % 3 == 0)
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

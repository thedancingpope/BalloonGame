class GameOverSuccess extends GameOverAbstractClass
{
  int R, G, B; 
  int clothCount = 5;

  boolean leftRight = true;

  FireWorks FW;
  Clothes [] Clothes;

  GameOverSuccess()
  {  
    textColorChange();
    initialGameOver();
    FW = new FireWorks();
    Clothes = new Clothes [clothCount];
    Clothes[0] = new Clothes(0f, 0f, 0f);
    Clothes[1] = new Clothes(0f, -20f, 0.1f);
    Clothes[2] = new Clothes(0f, -30f, 0.2f);
    Clothes[3] = new Clothes(0f, -40f, 0.5f);
    Clothes[4] = new Clothes(0f, -50f, 0.3f);
  }  

  void render() 
  {           
    fill(0);
    textSize(60);
    ambient(R, G, B);
    fill(R, G, B); 
    text("You Win!", 140, height / 2);       
    FW.render();
    if (frameCount % 3 == 0)
      textColorChange();    
    for (int i = 0; i < clothCount; i++)
    {
      pushMatrix();
      translate(Clothes[i].x, Clothes[i].y);
      renderCloth();   
      popMatrix();
    }            
    movePieces();
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
          Clothes[i].x -= lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].x += lerp(0, range, Clothes[i].speed);                       
        if (Clothes[1].x > range)
          leftRight = false;
      } 
      else
      {
        if (i % 2 == 0)
          Clothes[i].x += lerp(0, range, Clothes[i].speed);
        else
          Clothes[i].x -= lerp(0, range, Clothes[i].speed);    
        if (Clothes[1].x < -range)
          leftRight = true;
      }
    }
  }

  void textColorChange()
  {
    R = int(random(255));
    G = int(random(255));
    B = int(random(255));
  }
}
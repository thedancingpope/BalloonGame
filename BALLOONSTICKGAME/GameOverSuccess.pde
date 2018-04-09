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
    Clothes[0] = new Clothes(new PVector(0, 0), 0f);//new Clothes(0f, 0f, 0f);
    Clothes[1] = new Clothes(new PVector(0, -20), 0.1f);//new Clothes(0f, -20f, 0.1f);
    Clothes[2] = new Clothes(new PVector(0, -30), 0.2f);//new Clothes(0f, -30f, 0.2f);
    Clothes[3] = new Clothes(new PVector(0, -40), 0.5f);//new Clothes(0f, -40f, 0.5f);
    Clothes[4] = new Clothes(new PVector(0, -50), 0.3f);//new Clothes(0f, -50f, 0.3f);
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
    if (frameCount % 3 == 0)
      textColorChange();
    fill(0);
    textSize(60);
    ambient(R, G, B);
    fill(R, G, B); 
    text("You Win!", 140, height / 2);
  }

  void textColorChange()
  {
    R = int(random(255));
    G = int(random(255));
    B = int(random(255));
  }
}

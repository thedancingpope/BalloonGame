class GameOverSuccess extends GameOverAbstractClass
  {
    int R, G, B;
    
    GameOverSuccess()
      {  
        textColorChange();
        initialGameOver();
      }  
    
    void GameOverRender() 
      {
        pushMatrix();
          flyingCloth();   
          
          fill(0);
          textSize(60);
          ambient(R, G, B);
          text("You Win!", 140, height/2);       
          if (frameCount % 3 == 0)
            {
              textColorChange();
            }
        popMatrix();
      }
      
    void textColorChange()
      {
         R = int(random(255));
         G = int(random(255));
         B = int(random(255));
      }
  }
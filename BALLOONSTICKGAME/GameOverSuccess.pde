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
        flyingCloth();   
        
        fill(0);
        textSize(60);
        pushMatrix();
          ambient(R, G, B);
          text("You Win!", 140, height/2);
        popMatrix();
        if (frameCount % 3 == 0)
          {
            textColorChange();
          }
      }
      
    void textColorChange()
      {
         R = int(random(255));
         G = int(random(255));
         B = int(random(255));
      }
  }
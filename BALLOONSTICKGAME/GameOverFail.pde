class GameOverFail extends GameOverAbstractClass 
{    
  GameOverFail()
  {  
    initialGameOver();
  }

  void render() 
  {   
    renderCloth();
    resetText();
  }
}
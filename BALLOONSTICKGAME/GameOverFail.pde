class GameOverFail extends GameOverAbstractClass 
{    
  GameOverFail()
  {  
    initialGameOver();
  }

  void render() 
  {  
    pushMatrix();
    //translate(balPos.x + (width / 2) - (width / 4), balPos.y - (height / 4), 40);
    Cloth();
    popMatrix();
    resetText();
  }
}

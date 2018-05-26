class GameOverFail extends GameOverAbstractClass 
{  
  Clothes Cloth;

  GameOverFail()
  {  
    Cloth = new Clothes(new PVector(0, 0), 0f);
  }

  void render() 
  {
    Cloth.render();
    resetText();
  }
}

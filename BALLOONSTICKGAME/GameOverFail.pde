class GameOverFail
{  
  PGraphics clothLayer;
  Clothes Cloth;

  GameOverFail()
  {  
    clothLayer = createGraphics(width, height, P3D);
    Cloth = new Clothes(new PVector(0, 0), 0f);
  }

  void render() 
  {
    clothLayer.beginDraw();
    clothLayer.background(205, 205, 205, 0);  
    Cloth.render(clothLayer);
    clothLayer.endDraw();
    image(clothLayer, 0, 0);
  }
}

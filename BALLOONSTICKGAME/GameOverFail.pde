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
    clothLayer.noStroke();
    clothLayer.fill(50, 50, 0);  
    clothLayer.ambientLight(205, 205, 205);
    clothLayer.ambient(244, 255, 126);    
    Cloth.render(clothLayer);
    clothLayer.endDraw();    
    if(gameLayers[7])
      image(clothLayer, 0, 0);
  }
}

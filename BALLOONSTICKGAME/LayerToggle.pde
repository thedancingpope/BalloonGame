class LayerToggle
{
  int layers;
  boolean debugLayers;
  PGraphics debugLayer;
  
  LayerToggle()
  {
    layers = 10;
    gameLayers = new boolean [layers];
    for(int i = 0; i < layers; i++)    
      gameLayers[i] = true;
    debugLayer = createGraphics(width, height, P3D);
  }
  
  boolean displayDebug()
  {
    return debugLayers; 
  }
  
  void toggleDebug()
  {
    debugLayers = !debugLayers;
  }
  
  void render()
  {
    int [] layersUsed;
    if(phase == 0)
      layersUsed = new int [] {0, 6, 7, 9};
    else if(phase == 1)
      layersUsed = new int [] {0, 6, 7};
    else if(phase == 2)
      layersUsed = new int [] {0, 1, 2, 3, 7, 8, 9};
    else if(phase == 3)
      layersUsed = new int [] {0, 1, 2, 3, 7, 8, 9};
    else if(phase == 4)
      layersUsed = new int [] {0, 1, 4, 5, 7, 8, 9};
    else if(phase == 5)
      layersUsed = new int [] {0, 1, 4, 5, 7, 8, 9};      
    else
      layersUsed = new int [] {0, 1, 7, 8, 9};

    debugLayer.beginDraw();
    debugLayer.textSize(20);
    debugLayer.background(255, 50, 100, 0);
    debugLayer.fill(255, 50, 100);
    debugLayer.text("Debug current phase: " + phase, 20, 25);
    if(isCaught)
      debugLayer.text("Caught!!", 20, 50); 
    if(gotPowerUp)
      debugLayer.text("Power Up!!", 20, 75);
    debugLayer.text("Press buttons '2' - '6' for phases, 'r' to reset", 20, height - 70);
    debugLayer.text("Current layers", 300, 25);
    
    for(int i = 0; i < layersUsed.length; i++)
    {
      String temp = layerCheck(layersUsed[i]);
      debugLayer.text(temp, 300, 50 + (i * 25));
    }
    debugLayer.endDraw();
    image(debugLayer, 0, 0);
  }
  
  String layerCheck(int _l)
  {
    String s = "";
    if(_l == 0)
      s += "(B)ackground";
    else if(_l == 1)
      s += "Rear clo(u)ds";
    else if(_l == 2)
      s += "(P)ower up";
    else if(_l == 3)
      s += "(E)nemy";
    else if(_l == 4)
      s += "(F)ire works";
    else if(_l == 5)
      s += "(W)in text";
    else if(_l == 6)
      s += "(S)tring";
    else if(_l == 7)
      s += "Ba(l)loon";
    else if(_l == 8)
      s += "Front (c)louds";
    else
      s += "(T)ext";
    
    if(gameLayers[_l])
      s += ": On";
    else
      s += ": Off";
    return s; 
  }
}

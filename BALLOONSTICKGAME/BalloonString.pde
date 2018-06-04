class BalloonString
{  
  int springCount;
  PGraphics stringLayer;
  Spring2D [] springs;

  BalloonString()
  {  
    springCount = 4;
    springs = new Spring2D [springCount];
    for(int i = 0; i < springCount; i++)
      springs[i] = new Spring2D(width / 2, height / 2);
    stringLayer = createGraphics(width, height, P3D);
  }

  void render(PVector _p) 
  {    
    stringLayer.beginDraw();
    stringLayer.background(0, 0);
    stringLayer.pushMatrix();
    stringLayer.strokeWeight(3);
    springs[0].move(_p.x, _p.y);
    stringLayer.line(_p.x, _p.y, _p.z, springs[0].pos.x, springs[0].pos.y, _p.z);
    for(int i = 1; i < springCount; i++)
    {    
      springs[i].move(springs[i - 1].pos.x, springs[i - 1].pos.y);
      stringLayer.line(springs[i - 1].pos.x, springs[i - 1].pos.y, _p.z, springs[i].pos.x, springs[i].pos.y, _p.z);
    }
    stringLayer.popMatrix();
    stringLayer.endDraw();
    image(stringLayer, 0, 0);
  }  
}

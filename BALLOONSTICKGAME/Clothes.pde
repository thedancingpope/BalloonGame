class Clothes extends GameObjectAbstract
{
  float flying, speed;
  float [][] level;
  int cols, rows;

  Clothes(PVector _p, float _s)
  {
    pos = _p;
    speed = _s;
    flying = 0;
    cols = width / 40 + 1;
    rows = height / 40 + 1;
    level = new float[cols][rows];
  }  

  void render(PGraphics layer)
  {
    int scale = 25;
    int range = 5;
    float  inc = 0.1f;    
    flying -= 0.03;
    float yOff = flying;
    for(int y = 0; y < rows; y++) 
    {    
      float xOff = 0;
      for(int x = 0; x < cols; x++) 
      {
        level[x][y] = map(noise(xOff, yOff), 0, 1, -110, 110);
        xOff += inc;
      }
      yOff += inc;
    }
    layer.pushMatrix();
    layer.noStroke();
    layer.fill(50, 50, 0);  
    layer.ambientLight(205, 205, 205);
    layer.ambient(244, 255, 126);
    layer.translate(balPos.x + pos.x, balPos.y + pos.y, 60);
    layer.rotateX(flying);
    layer.rotateY(.1);    
    layer.translate(-width / 4, -height / 4);
    for(int y = range; y < rows - range - 1; y++) 
    {
      layer.beginShape(TRIANGLE_STRIP);
      for(int x = range; x < cols - range; x++) 
      {             
        layer.vertex(x * scale, y *scale, level[x][y]);
        layer.vertex(x * scale, (y + 1) * scale, level[x][y+1]);
      }
      layer.endShape();
    }
    layer.popMatrix();
  }
}

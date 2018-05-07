class Clothes
{
  float flying, speed;
  float [][] level;
  int cols, rows;
  PVector pos;

  Clothes(PVector _p, float _s)
  {
    pos = _p;
    speed = _s;
    flying = 0;
    cols = width / 40 + 1;
    rows = height / 40 + 1;
    level = new float[cols][rows];
  }  
   
  void render()
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
    pushMatrix();
    noStroke();
    fill(50, 50, 0);  
    Phases.lighting();
    translate(balPos.x + pos.x + (width/2), balPos.y + pos.y, 60);
    rotateX(flying);
    rotateY(.1);    
    translate(-width / 4,  -height / 4);
    for(int y = range; y < rows - range - 1; y++) 
    {
      beginShape(TRIANGLE_STRIP);
      for(int x = range; x < cols - range; x++) 
      {             
        vertex(x * scale, y *scale, level[x][y]);
        vertex(x * scale, (y + 1) * scale, level[x][y+1]);
      }
      endShape();
    }
    popMatrix();
  }
}

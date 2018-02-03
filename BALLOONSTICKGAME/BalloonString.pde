class BalloonString
{  
  int springCount = 4;  

  Spring2D [] springs;

  BalloonString()
  {  
    springs = new Spring2D [springCount];
    for (int i = 0; i < springCount; i++)
      springs[i] = new Spring2D(width / 2, height / 2);
  }

  void render(float x, float y, float z) 
  {    
    pushMatrix();
    strokeWeight(3);
    springs[0].move(x, y);
    line(x, y, z, springs[0].x, springs[0].y, z);
    for (int i = 1; i < springCount; i++)
    {    
      springs[i].move(springs[i - 1].x, springs[i - 1].y);
      line(springs[i - 1].x, springs[i - 1].y, z, springs[i].x, springs[i].y, z);
    }
    popMatrix();
  }
}
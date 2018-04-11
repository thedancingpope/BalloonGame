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

  void render(PVector pos) 
  {    
    pushMatrix();
    strokeWeight(3);
    springs[0].move(pos.x, pos.y);
    line(pos.x, pos.y, pos.z, springs[0].pos.x, springs[0].pos.y, pos.z);
    for (int i = 1; i < springCount; i++)
    {    
      springs[i].move(springs[i - 1].pos.x, springs[i - 1].pos.y);
      line(springs[i - 1].pos.x, springs[i - 1].pos.y, pos.z, springs[i].pos.x, springs[i].pos.y, pos.z);
    }
    popMatrix();
  }
}

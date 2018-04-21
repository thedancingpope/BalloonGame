public abstract class GameOverAbstractClass 
{
  float flying;
  float [][] level;
  int cols, rows;

  public abstract void render(); 

  public void initialGameOver()
  {           
    flying = 0;
    cols = width / 40 + 1;
    rows = height / 40 + 1;
    level = new float[cols][rows];
  } 

  public void renderCloth()
  {
    int scale = 25;
    int range = 5;

    pushMatrix();
    noStroke();
    fill(50, 50, 0);  
    Phases.lighting();
    translate(balPos.x + (width / 2), balPos.y, 30);
    rotateX(flying);
    rotateY(1.6);
    translate(-width / 4, -height / 4);  
    for (int y = range; y < rows - range - 1; y++) 
    {
      beginShape(TRIANGLE_STRIP);
      for (int x = range; x < cols - range; x++) 
      {             
        vertex(x * scale, y *scale, level[x][y]);
        vertex(x * scale, (y + 1) * scale, level[x][y+1]);
      }
      endShape();
    }
    popMatrix();
  }

  public void move()
  {
    float  inc = 0.1f;    
    flying -= 0.03;
    float yOff = flying;

    for (int y = 0; y < rows; y++) 
    {    
      float xOff = 0;
      for (int x = 0; x < cols; x++) 
      {
        level[x][y] = map(noise(xOff, yOff), 0, 1, -110, 110);
        xOff += inc;
      }
      yOff += inc;
    }

    if (leftTrue && !rightTrue) 
      balPos.x -= 8;        
    if (rightTrue && !leftTrue) 
      balPos.x += 8;        

    if(balPos.x < -225)
      balPos.x = -223;              
    if(balPos.x > 225) 
      balPos.x = 223;
  }
  
  public void resetText()
  {
    pushMatrix();
    fill(25);
    noLights();
    textSize(20);
    text("Press 'R' to replay", 50, 100, 70); 
    popMatrix();
  }
}

public abstract class GameOverAbstractClass 
{
  float clothX, clothY, flying;
  float [][] level;

  int cols, rows;

  public abstract void GameOverRender(); 

  public void initialGameOver()
  {           
    flying = 0;
    clothX = 300;
    clothY = 250;
    cols = width / 40 + 1;
    rows = height / 40 + 1;
    level = new float[cols][rows];
  } 

  public void flyingCloth()
  {
    int scale = 25;
    int range = 5;

    pushMatrix();
    noStroke();
    fill(50, 50, 0);  
    GamePhases.BalloonLighting();
    translate(clothX, clothY, 30);
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

  public void GameOverMove()
  {
    float  inc = 0.1f;    
    flying -= 0.03;
    float yOff = flying;

    for (int y = 0; y < rows; y++) 
    {    
      float xOff = 0;
      for (int x = 0; x < cols; x++) 
      {
        level[x][y] = map(noise(xOff, yOff), 0, 1, -110, 110);      // makes it appear to fly 
        xOff += inc;
      }
      yOff += inc;
    }

    if (leftTrue && !rightTrue) 
      clothX -= 8;        // move left
    if (rightTrue && !leftTrue) 
      clothX += 8;        // move right

    if (clothX < 0) 
      clothX = 2;            // dont go past the edge of the screen on the left   
    if ( clothX > 500) 
      clothX = 498;          // dont go past the edge of the screen on the right
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
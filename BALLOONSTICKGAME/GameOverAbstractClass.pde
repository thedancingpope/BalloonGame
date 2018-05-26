public abstract class GameOverAbstractClass 
{
  public abstract void render(); 

  public void move()
  {
    if(leftTrue && !rightTrue) 
      balPos.x -= 6;        
    if(rightTrue && !leftTrue) 
      balPos.x += 6;        

    if(balPos.x < -225)
      balPos.x = -223;              
    if(balPos.x > 217) 
      balPos.x = 215;
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

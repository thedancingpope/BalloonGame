class PowerUp 
{
  float PowerX;
  float PowerY;
  float size;
  float speed;

  PowerUp()
  {


    PowerX = random(width);
    PowerY = 0;
    size = random(10, 60);
    speed = random(2, 7);
  }

  void ActualPowerUp()
  {
    pushMatrix();
    fill(150);
    ambient(150, 150, 0); 
    noStroke();
    translate(PowerX, PowerY);
    pushMatrix();
    
    //scale(.5);
    rotateY(frameCount*.1);
    translate(10, -20, -10);
    sphere(20);                  //draws the nucleus
    translate(-18, 0);
    fill(212, 114, 114);
    sphere(20);
    translate(0, 17, 17);
    fill(150);
    sphere(20);
    translate(18, 0);
    fill(212, 114, 114);
    sphere(20);
    popMatrix();

    pushMatrix(); 
    fill(0);              //draws the electron
    translate(10, -12, 0);
    rotateX(1);
    rotateY(-1);
    translate(0, sin(frameCount*.2)*120, cos(frameCount*.2)*120);
    sphere(5);            
    popMatrix();

    pushMatrix();                //draws the electron
    translate(-10, -12, 0);
    rotateX(1);
    rotateY(1);
    translate(0, sin(frameCount*.2)*-120, cos(frameCount*.2)*120);
    sphere(5);
    popMatrix();
    popMatrix();
  }

  void PowerMove()
  {
    
    PowerY +=speed;                            // auto movement of the power up
    println(PowerY);
    
    if(PowerY >= 1500)
      PowerX = random(width*2.5);
    
    if (PowerY + size <= 0)                     //min and max distances for the power up
      PowerY = size;
    else if (PowerY - size >= 1500)
      PowerY = -size;
  }
  
  void PowerGrab() 
  {
  //Play sound
  //Disappear
  //Send indicator to BadGuys to cause BadGuy to drop y value.
  print(balX);
  print(", ");
  print(balX+180);
  print(", ");
  println(map(PowerX, 0, 1000, -500, 500));
    if(PowerY >= 450 && PowerY <= 500)
         {
          if(map(PowerX, 0, 1000, -500, 500) >= balX && map(PowerX, 0, 1000, -500, 500) <= balX + 180)

            println("HIT");
         }
  }
}

class GameOverFail
{
  int cols, rows;
  int scale = 20;
  int w, h, d=5;
  float clothX = 300;
  float clothY = 300;
  float flying=0;
  float[][] level;
  float inc=0.1;
  boolean draw_on=true;

  GameOverFail()
  {

    w = width;
    h = height;
    cols = w/40+1;
    rows = h/40+1;
    level = new float[cols][rows];
  }

  void LooseMove()
  {
    flying -= 0.03;
    float yoff = flying; 
    for (int y=0; y<rows; y++) 
    {    
      float xoff = 0;
      for (int x=0; x<cols; x++) 
      {
        level[x][y] = map(noise(xoff, yoff), 0, 1, -110, 110);      // makes it appear to fly 
        xoff+=inc;
      }
      yoff+=inc;
    }

    if (leftTrue == true && rightTrue == false) clothX -= 10;  // move left

    if (clothX <= -1) clothX = 0;        // dont go past the edge of the screen on the left

    else if (rightTrue == true && leftTrue == false) clothX += 10;       // move right
   println(leftTrue, rightTrue, clothX);
    if ( clothX >= 501) clothX = 500;          // dont go past the edge of the screen on the right
  }

  void render() 
  {
    noStroke();                                      //draw no edges
    fill(50, 50, 0);                                 //color the whole balloon
    ambientLight(205, 205, 205);                    // the color put out by the light on everything
    lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
    directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
    specular(180, 180, 180);                        // removes the this color when lit up
    shininess(9.0);                                  // the larger the number the smaller the shiny circle
    ambient(150, 150, 0); 
    pushMatrix();
    translate(clothX, clothY);              //X coord key control
    rotateX(flying*6);
    rotateY(1.5);
    rotateZ(0);
    translate(-w/4, -h/4);   
    for (int y=d; y<rows -d-1; y++) 
    {
      beginShape(TRIANGLE_STRIP);
      for (int x=d; x<cols-d; x++) 
      {             
        vertex(x*scale, y*scale, level[x][y]);
        vertex(x*scale, (y+1)*scale, level[x][y+1]);
      }
      endShape();
    }
    popMatrix();
  }
}
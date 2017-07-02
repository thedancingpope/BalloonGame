public abstract class GameOverAbstractClass 
  {
    int cols, rows;
    int scale;
    int w, h, d;
    float clothX;
    float clothY;
    float flying;
    float[][] level;
    float inc;
    
    public abstract void GameOverRender(); 
    
    public void initialGameOver()
      {
        scale = 25;
        d = 5;
        inc = 0.1f;
        flying = 0;
        clothX = 300;
        clothY = 250;
        w = width;
        h = height;
        cols = w/40+1;
        rows = h/40+1;
        level = new float[cols][rows];
      }  
    
    public void flyingCloth()
      {
        pushMatrix();
          noStroke();                                      //draw no edges
          fill(50, 50, 0);                                 //color the whole cloth
          ambientLight(205, 205, 205);                    // the color put out by the light on everything
          lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
          directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
          specular(180, 180, 180);                        // removes the this color when lit up
          shininess(9.0);                                  // the larger the number the smaller the shiny circle
          ambient(150, 150, 0);
          translate(clothX, clothY, 30);              //X coord key control
            rotateX(flying);
            rotateY(1.6);
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
    
    public void GameOverMove()
      {
        flying -= 0.03;
        float yoff = flying; 
        for (int y=0; y<rows; y++) 
          {    
            float xoff = 0;
            for (int x=0; x<cols; x++) 
              {
                level[x][y] = map(noise(xoff, yoff), 0, 1, -110, 110);      // makes it appear to fly 
                xoff += inc;
              }
            yoff += inc;
          }
    
        if (leftTrue == true && rightTrue == false) 
          clothX -= 8;                                    // move left
    
        if (clothX <= -1) 
          clothX = 1;            // dont go past the edge of the screen on the left
    
        else if (rightTrue == true && leftTrue == false) 
          clothX += 8;                                   // move right
      
        if ( clothX >= 501) 
          clothX = 499;          // dont go past the edge of the screen on the right
      }
  
     
}
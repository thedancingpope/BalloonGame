class CloudThings
  { 
    float x;
    float y;
    float z;
    float size;
    float speed;
    int sizeCloud;
  
    CloudThings() 
      {
        x = random(width);
        y = -450f;
        z = random(12, -80);
        size = random(10, 60);
        speed = random(2, 7);
        sizeCloud = int(random(0, 2));
      }
  
    void render()
      {
        translate(-width/8,-height/8,0);
          fill(255);
          noStroke();
          lights();
          ambient(255, 255, 255);
         
          pushMatrix();
            scale(1.5);
            translate(x, y, z);
              sphere(size);
              translate(size-2, size/2, size-2);
                sphere(size);
                translate(-size/2, size/2, size/2);
                  sphere(size);
                  translate(size, 0);
                    sphere(size);
                    if (sizeCloud > 0)
                      {
                        translate(0, -size, -size);
                          sphere(size);
                          translate(size, size/2, size/2);
                            sphere(size);
                            translate(-size*3, 0);
                              sphere(size);
                      }
                    scale(1.0);
          popMatrix();
     }
  
    void move()
      { 
        if(phase != 4 && phase != 3)
          {
            y += speed;                            // auto movement of the clouds
           
            if(y + size > height + 400)        // if reaching the bottom of the panel
              {
                y = -500 + size;                // go to the top  
                x = random(width);          // generate a new x value to start at
              }
          }  
        else
          {
            y -= speed + 1;
            
            if(y < -400)        // if reaching the top of the panel
                {
                  y = height + 400;                // go to the bottom 
                  x = random(width);          // generate a new x value to start at
                }
          }
    } 
} 
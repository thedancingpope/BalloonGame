class CloudThings
  { 
    float x;
    float y;
    float z;
    float size;
    float speed;
    int sizeCloud;
    int cloudBottom = 70;
    
    CloudThings() 
      {
        newCloudPos();        
      }
  
    void render()
      {        
        pushMatrix(); 
          lights();
          ambient(255, 255, 255);
          fill(255);
          noStroke();
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
        popMatrix();
     }
  
    void move()
      { 
        if(phase != 4 && phase != 3)
          {
            y += speed;           // movement of the clouds
            if (gotPowerUp)   
              y+= speed * 0.7f;        //speed up if you have the power up
                   
            if(y - size > height)        // if reaching the bottom of the panel
              newCloudPos();              
          }  
        else
          {
            y -= speed;         // movement of the clouds
            if(y < -cloudBottom)        // if reaching the top of the panel
              newCloudPos();
          }
    } 
    
    void newCloudPos()
      {
        size = random(15, 35);
        speed = random(3, 6);
        sizeCloud = int(random(0, 2));
        x = random(30, 480);          
        z = random(0, -80);
        if(phase != 4 && phase != 3)
          y = - cloudBottom - size;           // go to the top
        else
          y = height + cloudBottom + size;      // go to the bottom 
      }
} 
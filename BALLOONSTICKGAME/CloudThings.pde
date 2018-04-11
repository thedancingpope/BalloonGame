class CloudThings
{ 
  float size, speed;
  PVector pos;
  int cloudType;  //large or small cloud type
  int cloudBottom = 70;

  boolean phaseOut;

  CloudThings() 
  {
    pos = newPos();
  }

  void render()
  {        
    pushMatrix(); 
    lights();
    ambient(255, 255, 255);
    fill(255);
    noStroke();
    translate(pos.x, pos.y, pos.z);
    sphere(size);
    translate(size / 2, size / 2, size / 2);
    sphere(size);
    translate(-size / 2, size / 2, size / 2);
    sphere(size);
    translate(size, 0);
    sphere(size);
    if (cloudType > 0)
    {
      translate(0, -size, -size);
      sphere(size);
      translate(size, size / 2, size / 2);
      sphere(size);
      translate(-size * 3, 0);
      sphere(size);
    }
    popMatrix();
  }

  void move()
  { 
    if (phase < 4)
    {
      pos.y += speed;   
      if (pos.y - size > height)        // if reaching the bottom of the panel
        if (!phaseOut)
          pos = newPos();
    } 
    else
    {
      pos.y -= speed; 
      if ((pos.y + size) < -cloudBottom)        // if reaching the top of the panel  
          if (!phaseOut)
            pos = newPos();
    }
  }
  
  PVector newPos()
  {
    size = random(15, 35);
    speed = random(3, 6);
    cloudType = int(random(0, 2));
    float x = random(20, 480);          
    float z = random(0, -80);
    float y;
    if (phase < 4)
      y = - cloudBottom - size;           // go to the top    
    else    
      y = height + cloudBottom + size;      // go to the bottom
    return new PVector(x, y, z);
  }
} 

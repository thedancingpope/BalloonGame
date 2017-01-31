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
    y = random(height);
    z = random(12, -80);
    size = random(10, 60);
    speed = random(2, 7);
    sizeCloud = int(random(0, 2));
  }


  //Mess with the random value and this render function. Could I get a specific type of render? Placement?
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
      y+=speed;                            // auto movement of the clouds

      if(y + size > height + 400)        // if reaching the bottom of the panel
        {
          y = -500+size;                // go to the top  
          x = random(width);          // generate a new x value to start at
        }
  } 
} 

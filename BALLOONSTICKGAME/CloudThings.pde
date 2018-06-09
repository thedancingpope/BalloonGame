class CloudThings extends GameObjectAbstract
{ 
  int cloudType, cloudBottom, size, speed;
  boolean phaseOut;

  CloudThings() 
  {
    cloudBottom = 70;
    pos = newPos();
    acceleration = new PVector(0, .5f);
  }

  void render(PGraphics layer)
  {
    layer.pushMatrix(); 
    layer.noLights();
    layer.lights();
    layer.ambient(255, 255, 255);
    layer.fill(255, 200);
    layer.noStroke();
    layer.translate(pos.x, pos.y, pos.z);
    layer.sphere(size);
    layer.translate(size / 2, size / 2, size / 2);
    layer.sphere(size);
    layer.translate(-size / 2, size / 2, size / 2);
    layer.sphere(size);
    layer.translate(size, 0);
    layer.sphere(size);
    if(cloudType > 0)
    {
      layer.translate(0, -size, -size);
      layer.sphere(size);
      layer.translate(size, size / 2, size / 2);
      layer.sphere(size);
      layer.translate(-size * 3, 0);
      layer.sphere(size);
    }
    layer.popMatrix();
  }

  void moveWithPowerUp()
  {
    acceleration = new PVector(0, .1f);
    changePos();
  }

  void move()
  { 
    acceleration = new PVector(0, .3);
    changePos();
  }

  void changePos()
  {
    if(phase < 4)
    {
      velocity.add(acceleration);
      velocity.limit(speed);
      pos.add(velocity);
      if(pos.y - size > height)
        if(!phaseOut)
          pos = newPos();
    } 
    else
    {
      velocity.add(acceleration);
      velocity.limit(speed);
      pos.sub(velocity);
      if((pos.y + size) < -cloudBottom) 
        if(!phaseOut)
          pos = newPos();
    }    
  }

  PVector newPos()
  {
    size = int(random(15, 35));
    speed = int(random(3, 5));
    velocity = new PVector(0f, speed);
    cloudType = int(random(0, 2));
    int edge = 30;
    float x = random(edge, width - edge);          
    float z = random(0, -80);
    float y;
    if(phase < 4)
      y = - cloudBottom - size;  
    else    
      y = height + cloudBottom + size;
    return new PVector(x, y, z);
  }
} 

class BadGuy extends GameObjectAbstract
{   
  PImage badCloud, angryCloud, enemyImg;
  PVector moveUp, moveDown, turn;
  PGraphics enemyLayer;

  BadGuy() 
  {
    enemyLayer = createGraphics(width, height, P3D);
    pos = new PVector(width / 2, 550);   
    velocity = new PVector(0, 0);
    moveUp = new PVector(0, .1);
    moveDown = new PVector(0, 4);
    turn = new PVector(.2, 0);
    acceleration = new PVector(0, 0);
    badCloud = loadImage("EvilCloud.png");
    angryCloud = loadImage("EvilCloudSPrite copy.png");
    badCloud.resize(0, 122);
    angryCloud.resize(0, 150); 
  }

  void render()
  {
    float yTolerance = 100;
    int imgGap;
    if(pos.y <= balPos.y + yTolerance)
    {      
      imgGap = -angryCloud.height / 2;
      enemyImg = angryCloud;
    } 
    else
    {
      imgGap = (-badCloud.height / 2) + 20;
      enemyImg = badCloud;
    }
    enemyLayer.beginDraw();
    int gray = 115;    
    enemyLayer.background(gray, gray, gray, 0);  
    enemyLayer.pushMatrix();
    enemyLayer.translate(pos.x, pos.y);    
    enemyLayer.image(enemyImg, -enemyImg.width / 2, imgGap);
    enemyLayer.popMatrix();
    enemyLayer.endDraw();
    if(gameLayers[3])
      image(enemyLayer, 0, 0);
  }

  boolean caughtCheck()
  {
    int gap = 50;
    if(pos.x >= (balPos.x - gap) && pos.x <= (balPos.x + gap) && pos.y <= balPos.y + 10)    
      return true;
    else
      return false;
  }

  void steer()
  {
    float radius = 20;
    if(pos.x > (balPos.x + radius))
      acceleration.sub(turn);
    else if(pos.x < (balPos.x - radius))
      acceleration.add(turn);
    else
      acceleration.x = 0;
  }
  
  void move()
  {
    if(pos.y > balPos.y)
      acceleration.sub(moveUp);
    if(pos.y <= balPos.y + 10)
      acceleration.mult(.5);
    if(acceleration.y > 0)
      acceleration.mult(.5);
    steer();    
    velocity.add(acceleration);
    velocity.limit(3f);    
    pos.add(velocity);
  }

  void retreat()
  {
    steer();
    if(velocity.y < 0)
    {
      velocity.y = 0;
      acceleration.y = 0;
    }
    acceleration.add(moveDown);
    velocity.add(acceleration);
    velocity.limit(6f);
    pos.add(velocity);
    acceleration.mult(1.1);
  }
}

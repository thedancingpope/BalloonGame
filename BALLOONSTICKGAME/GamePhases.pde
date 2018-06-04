class GamePhases
{ 
  float BGy, BGspeed;
  int cloudCount, phaseOutCloud;
  boolean BGparallax, beginParallax, gotPowerUp, startPhase1, startPhase3, debug;
  PImage woods, cloudSky, bgCloud1, bgCloud2, cloudsToSpace;  
  PGraphics sceneBG, backClouds, frontClouds, instructionsLayer;
  Balloon Balloon;  
  CloudThings [] cloudList;
  BadGuy Enemy;
  PowerUp PowerUp;
  GameOverSuccess Win;
  GameOverFail Loose;
  TextCanvas Canvas;

  GamePhases()
  { 
    woods = loadImage("ForestBackgroundOne.jpg");
    cloudSky = loadImage("CloudBackgroundReg.jpg");
    bgCloud1 = loadImage("BlueSky2.jpg");
    bgCloud2 = loadImage("BlueSky2.jpg");
    cloudsToSpace = loadImage("TallHorizon.png");
    cloudCount = 10;
    resetComponents();
  } 

  void RunPhases()
  { 
    renderBackground();    
    Balloon.move(); 
    
    if(phase == 1)    
      phase01();
    if(phase == 2)    
      phase02(); 
    if(phase == 3)       
      phase03(); 
    if(phase == 4)    
      phase04();
    if(phase == 5)    
      phase05();
    if(phase == 6)    
      phase06();       
    if(phase < 4)
      Balloon.render();
    if(phase > 1)     
      image(frontClouds, 0, 0);
    if(phase == 0)
      image(instructionsLayer, 0, 0);
      
    Canvas.render();

    if(phase >= 4)  
    {
      if(reset)
        resetComponents();
    }
    if(reset && debug)
      resetComponents();
  } 
  
  /**--------------------------[Phase 1]----------------------------------------------------------*/

  void phase01()
  { 
    int center = 5;
    
    if(startPhase1)
    {
      if(balPos.x > (width / 2) + center)
      {
        rightTrue = false; 
        leftTrue = true;
      } 
      else if(balPos.x < (width / 2) - center)
      {
        leftTrue = false;
        rightTrue = true;
      } 
      else if(balPos.x < ((width / 2) + center) && balPos.x > ((width / 2) - center))
      {
        startPhase1 = false;
        rightTrue = false; 
        leftTrue = false;
        Canvas.setStartTime(1);
      }
    } 
    else
    {
      if(BGy < 150)
      {
        leftTrue = true;
      } 
      else if(BGy < 400)
      {
        leftTrue = false;
        rightTrue = true;
      } 
      else if(BGy < 480)
      {
        rightTrue = false;
        leftTrue = true;
      }
      else if(BGy > 480)
      {
        leftTrue = false;
        rightTrue = false;
      }
      if(BGy > 500)
      {
        Canvas.setStartTime(2);  
        phase = 2; 
        BGy = 0;
        beginParallax = false;
        BGparallax = true;
        phaseAllCloudsOut();
      }
    }
  }
  /**--------------------------[Phase 2]----------------------------------------------------------*/

  void phase02()
  { 
    if(phaseOutCloud >= 0)
    {
      if((millis() / 1000f) > (Canvas.phaseStartTime(2) + 1f))
      {
        cloudList[phaseOutCloud].phaseOut = false;
        if(frameCount % 20 == 0)
            phaseOutCloud --;
      }
    }
    
    backClouds.beginDraw();      
    backClouds.background(255, 0);
    for(int i = 0; i < cloudCount / 2; i++)
    {
      if(!cloudList[i].phaseOut)
      {
        cloudList[i].move();
        if(gotPowerUp)
          cloudList[i].moveWithPowerUp();
        cloudList[i].render(backClouds);
      }
    }
    backClouds.endDraw();     
    frontClouds.beginDraw();
    frontClouds.background(255, 0);        
    for(int j = cloudCount / 2; j < cloudCount; j++)
    {
      if(!cloudList[j].phaseOut)
      {
        cloudList[j].move();
        if(gotPowerUp)
          cloudList[j].moveWithPowerUp();
        cloudList[j].render(frontClouds); 
      }
    }
    frontClouds.endDraw();
    image(backClouds, 0, 0);
    
    PowerUp.render();
    gotPowerUp = PowerUp.getPowerUp();    
    if(gotPowerUp)
      Enemy.retreat();
    else
      Enemy.move();
    Enemy.render();
    
    if((millis() / 1000) - Canvas.phaseStartTime(2) >= 80 || (debug && (millis() / 1000) - Canvas.phaseStartTime(2) >= 10)) 
    {
      Canvas.setStartTime(3);
      changePhase(3);     
      startPhase3 = false;
    }
    if(Enemy.caughtCheck()) 
    {  
      Canvas.setStartTime(6); 
      changePhase(6);
    }
  }  
  /**--------------------------[Phase 3]----------------------------------------------------------*/

  void phase03()
  {
    if(phaseOutCloud != cloudCount)
    {
      if((millis() / 1000f) > (Canvas.phaseStartTime(3) + 15f))
      {           
        cloudList[phaseOutCloud].phaseOut = true;
        if(frameCount % 20 == 0)     
          phaseOutCloud ++;
      } 
    }    
    cloudLayers();
    
    if(!startPhase3)
    {
      gotPowerUp = false;
      phaseOutCloud = 0;      
      if(BGy >= 500)
      {
        startPhase3 = true;
        BGy = -cloudsToSpace.height;
        Canvas.setStartTime(3);
      }
    }
    if(PowerUp.pos.y < height)
      PowerUp.render();
    if(Enemy.pos.y < height)
    {
      Enemy.retreat();
      Enemy.render();
    }
    if(BGy >= 0 && (millis() / 1000f) > (Canvas.phaseStartTime(3) + 15f))
    {
      Canvas.setStartTime(4);
      phase = 4;
      phaseOutCloud = cloudCount - 1;
    }
  }
  /**--------------------------[Phase 4]----------------------------------------------------------*/

  void phase04()
  {  
    if(phaseOutCloud >= 0)
    {
      if((millis() / 1000f) > (Canvas.phaseStartTime(4) + 8f))
      {
        cloudList[phaseOutCloud].phaseOut = false;
        if(frameCount % 20 == 0)
            phaseOutCloud --;
      }
    }
    
    cloudLayers();
    Win.render();
    
    if(BGy <= -1300 - height)
    {
      Canvas.setStartTime(5);
      phase = 5;  
      BGparallax = true;
    }
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase05()
  {
    cloudLayers();
    Win.render();
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase06()
  { 
    cloudLayers();
    Loose.render();
    //if(countDownTime < 0)
    //resetComponents();
  }

  void phase07()
  {
    //balloon cloth piece lands on the ground
  }

  void phaseAllCloudsOut()
  {    
    for(int i = 0; i < cloudCount; i++)
      cloudList[i].phaseOut = true;
    phaseOutCloud = cloudCount - 1;
  }
  
  void phaseAllCloudsIn()
  {    
    for(int i = 0; i < cloudCount; i++)
      cloudList[i].phaseOut = false;
    phaseOutCloud = 0;
  }
  
  void cloudLayers()
  {
    backClouds.beginDraw();      
    backClouds.background(255, 0);
    for(int i = 0; i < (cloudCount / 2); i++)
    {
      cloudList[i].move();
      if(gotPowerUp)
        cloudList[i].moveWithPowerUp();
      cloudList[i].render(backClouds);
    }
    backClouds.endDraw();     
    frontClouds.beginDraw();
    frontClouds.background(255, 0);        
    for(int j = (cloudCount / 2); j < cloudCount; j++)
    {
      cloudList[j].move();
      if(gotPowerUp)
        cloudList[j].moveWithPowerUp();
      cloudList[j].render(frontClouds); 
    }
    frontClouds.endDraw();
    image(backClouds, 0, 0);
  }
  
  void setPhase1()
  {
    startPhase1 = true;
    Canvas.setStartTime(1);
    phase = 1;
  }

  void debugPhase(int p)
  {
    resetComponents();
    phase = p;
    debug = true;
    
    if(p == 2)
    {
      phaseAllCloudsIn();
      BGy = 250;
    }
    if(p == 3)
    {             
      phaseAllCloudsIn();
      beginParallax = true;
    }
    if(p == 4)
    {
      phaseAllCloudsOut();
    }
    if(p == 5)
    {
      phaseAllCloudsIn();
    }    
    
    Canvas.setText();
    Canvas.setStartTime(p);
  }

  void changePhase(int p)
  {
    BGparallax = true;
    phase = p;
  }

  void renderBackground()
  {    
    moveBackground();  
    background(255);
    sceneBG.beginDraw();
    sceneBG.background(0, 0);
    sceneBG.pushMatrix();   
    sceneBG.translate(0, BGy); 
    
    if(phase == 0 || phase == 1)
    {
      drawBG(woods, true);
      drawBG(cloudSky, false);
    }
    if(phase == 2 || (phase == 3 && !startPhase3))
    {   
      PImage BG1;
      PImage BG2;
      boolean switchBG;
      if(!beginParallax)
      {
        BG1 = cloudSky;
        BG2 = bgCloud1;
        switchBG = true;
      } 
      else
      {
        if(BGparallax)
        {
          BG1 = bgCloud1;
          BG2 = bgCloud2;          
          switchBG = true;
        } 
        else
        {
          BG1 = bgCloud1;
          BG2 = bgCloud2;          
          switchBG = false;
        }
      }  
      drawBG(BG1, switchBG);
      drawBG(BG2, !switchBG);
    } 
    if(phase == 3 && startPhase3)
    {
      if(BGy <= -1300)
      {
        sceneBG.pushMatrix(); 
        sceneBG.translate(0, 1300 + height);
        BGPanel(bgCloud2, 0, width, 0, height);
        sceneBG.popMatrix();
      }
      BGPanel(cloudsToSpace, 0, width, 0, cloudsToSpace.height);
    }
    if(phase == 4)
    {
      if(BGy <= -1300)
      {
        sceneBG.pushMatrix(); 
        sceneBG.translate(0, 1300);
        BGPanel(bgCloud1, 0, width, height, height + height);
        sceneBG.popMatrix();
      }
      BGPanel(cloudsToSpace, 0, width, 0, cloudsToSpace.height);      
    }
    if(phase == 5 || phase == 6)
    {
      PImage BG1;
      PImage BG2;
      boolean switchBG;
      if(BGparallax)
      {
        BG1 = bgCloud1;
        BG2 = bgCloud2;          
        switchBG = true;
      } 
      else
      {
        BG1 = bgCloud1;
        BG2 = bgCloud2;          
        switchBG = false;
      }
      drawBG(BG1, switchBG);
      drawBG(BG2, !switchBG);
    }
    
    sceneBG.popMatrix();    
    sceneBG.endDraw();
    image(sceneBG, 0, 0); 
  }

  void moveBackground()
  {
    if(phase == 1 && !startPhase1)         
      BGy += BGspeed * 2;    
    else if(phase == 2)
    {
      BGy += BGspeed;
      if(BGy >= height)
      {
        BGy = 0;
        if(beginParallax) 
          BGparallax = !BGparallax;
        else
          beginParallax = true;
      }
    } 
    else if(phase == 3)
    {
      BGy += BGspeed;
    } 
    else if(phase == 4)
    {
      if(BGy >= -1300 - height)
        BGy -= BGspeed;
    } 
    else if(phase == 5 || phase == 6)
    {
      BGy -= BGspeed;
      if(BGy <= -height)
      {
        BGy = 0; 
          BGparallax = !BGparallax;
      }
    }
  }

  void drawBG(PImage picBG, boolean heightPos)
  {
    int bgHeight1;
    int bgHeight2;
    if(heightPos)
    {
      bgHeight1 = 0;
      bgHeight2 = height;
    } 
    else
    {
      bgHeight1 = -height;
      bgHeight2 = 0;
      if(phase == 5 || phase == 6)
      {
        if(BGy <= 0)
        {
          bgHeight1 = height;
          bgHeight2 = height + height;
        }
      }
    }
    BGPanel(picBG, 0, width, bgHeight1, bgHeight2);
  }

  void BGPanel(PImage img, int x1, int x2, int y1, int y2)
  {
    sceneBG.pushMatrix(); 
    sceneBG.noStroke();
    sceneBG.textureWrap(NORMAL);
    sceneBG.beginShape(QUADS);
    sceneBG.texture(img);   
    sceneBG.vertex(x1, y2, 0, img.height);          
    sceneBG.vertex(x1, y1, 0, 0);
    sceneBG.vertex(x2, y1, img.width, 0); 
    sceneBG.vertex(x2, y2, img.width, img.height);    
    sceneBG.endShape();
    sceneBG.popMatrix();
  }

  void resetComponents()
  {
    Win = new GameOverSuccess();
    Loose = new GameOverFail(); 
    Balloon = new Balloon();
    Enemy = new BadGuy();
    PowerUp = new PowerUp();     
    Canvas = new TextCanvas();
    cloudList = new CloudThings[cloudCount];
    for(int i=0; i <cloudList.length; i++) 
      cloudList[i]=new CloudThings();
    phase = 0; 
    startPhase1 = false;
    startPhase3 = false;
    balPos = new PVector(width / 2, height / 2); 
    sceneBG = createGraphics(width, height, P3D);
    backClouds = createGraphics(width, height, P3D);
    frontClouds = createGraphics(width, height, P3D);
    instructionsLayer = createGraphics(width, height, P3D);
    BGy = 0;
    BGspeed = 2; 
    Canvas.setStartTime(0);
    BGparallax = true;
    beginParallax = false;    
    leftTrue = false;
    rightTrue = false;
    gotPowerUp = false;
    reset = false;
    debug = false;
  }
}

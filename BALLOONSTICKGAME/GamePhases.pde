class GamePhases
{ 
  float BGy, BGspeed;

  int cloudCount, phaseOutCloud, timeSurvived, endTime, floatingTime, countDownTime, winTime;

  String qButton, controls;

  boolean BGparallax, beginParallax, spaceTransition, gotPowerUp, startPhase1, debug;

  PImage woods, cloudSky, bgCloud1, bgCloud2, cloudsToSpace;

  Balloon Balloon;  
  CloudThings [] cloudList;
  BadGuy Enemy;
  PowerUp PowerUp;
  GameOverSuccess Win;
  GameOverFail Loose;

  GamePhases()
  { 
    qButton = "Press Q for freedom.";
    controls = "Use A and D to steer.";
    woods = loadImage("ForestBackgroundOne.jpg");
    cloudSky = loadImage("CloudBackgroundReg.jpg");
    bgCloud1 = loadImage("BlueSky2.jpg");
    bgCloud2 = loadImage("BlueSky2.jpg");
    cloudsToSpace = loadImage("TallHorizon.png");
    resetComponents();
  } 

  void RunPhases()
  {
    renderBackground();
    moveBackground();
    if (phase < 4)
    {      
      Balloon.render();
      Balloon.move();
    }    
    if (phase > 1)
    {        
      for (int i = 0; i < cloudCount; i++)
      {
        cloudList[i].render();
        cloudList[i].move();
        if (gotPowerUp)  
          cloudList[i].move();
      }      
      TimeStamp();
    }

    if (phase == 0)    
      phase00();
    if (phase == 1)    
      phase01();
    if (phase == 2)    
      phase02(); 
    if (phase == 3)       
      phase03(); 
    if (phase == 4)    
      phase04();
    if (phase == 5)    
      phase05();

    if (phase >= 4)  
    {
      if (reset || debug)
        resetComponents();
    }
  }    
  /**--------------------------[Phase 0]----------------------------------------------------------*/

  void phase00()
  {     
    pushMatrix();
    fill(255);
    textSize(20);
    text(qButton, 50, 100);
    text(controls, 50, 50);  
    popMatrix();
    startPhase1 = false;
  }
  /**--------------------------[Phase 1]----------------------------------------------------------*/

  void phase01()
  { 
    if (startPhase1)
    {
      if (balX > 0)
      {
        rightTrue = false; 
        leftTrue = true;
      }        
      else if (balX < 0)
      {
        leftTrue = false;
        rightTrue = true;
      }
      else if (balX == 0)
      {
        startPhase1 = false;
        rightTrue = false; 
        leftTrue = false;
      }
    } 
    else
    {
      if (BGy < 200)
      {
        balX = int(map(BGy, 0, 200, 0, -100));
        leftTrue = true;
      } 
      else if (BGy < 450)
      {
        balX = int(map(BGy, 200, 450, -100, 50));
        leftTrue = false;
        rightTrue = true;
      }
      else if (BGy <= 500)
      {
        balX = int(map(BGy, 450, 500, 50, 0));
        rightTrue = false;
        leftTrue = true;
      }
      if (BGy > 500)
      {
        phase = 2;
        floatingTime = int(millis() / 1000);  
        balX = 0;
        leftTrue = false;
        rightTrue = false;
        BGy = 0;
        beginParallax = false;
        BGparallax = true;
      }
    }
  }
  /**--------------------------[Phase 2]----------------------------------------------------------*/

  void phase02()
  { 
    PowerUp.render();
    PowerUp.move();   
    gotPowerUp = PowerUp.getPowerUp();
    Enemy.render();
    if (gotPowerUp)
      Enemy.retreat();
    else
      Enemy.move();

    if (timeSurvived >= 80) 
    {
      changePhase(3);
      BGy = 0;
    }
    if (Enemy.caughtCheck()) 
      changePhase(5);
  }  
  /**--------------------------[Phase 3]----------------------------------------------------------*/

  void phase03()
  {  
    float waitLong = 60000f;
    if (!spaceTransition)
    {
      winTime = millis();
      phaseOutCloud = 0;
      spaceTransition = true;
      BGy = height - cloudsToSpace.height;
    }    
    if (millis() > winTime + 10000f && millis() < winTime + waitLong)
    {           
      cloudList[phaseOutCloud].phaseOut = true;
      if (frameCount % 20 == 0)
        if (phaseOutCloud < cloudCount - 1)
          phaseOutCloud ++;
    } 
    else if (millis() > winTime + waitLong)
    {
      cloudList[phaseOutCloud].phaseOut = false;
      if (frameCount % 20 == 0)
        if (phaseOutCloud > 0)
          phaseOutCloud --;
    }
    //reverse the bg movement back to earth

    //phase = 4;
  }
  /**--------------------------[Phase 4]----------------------------------------------------------*/

  void phase04()
  {  
    Win.move();
    Win.render();
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase05()
  {
    Loose.move();  
    Loose.render();
    //if (countDownTime < 0)
    //resetComponents();
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase06()
  {
    //balloon cloth piece lands on the ground
  }

  void setPhase1()
  {
    if (phase == 0)
    {    
      startPhase1 = true;
      phase = 1;
    }
  }

  void debugPhase(int p)
   {
     phase = p;
     debug = true;
     if(p == 3)
     {
       spaceTransition = false;
     }
   }

  void changePhase(int p)
  {
    endTime = timeSurvived;  
    BGparallax = true;
    phase = p;
  }

  void parallaxBg()
  {
    beginParallax = true;
    BGy -= BGspeed;
    if (BGy <= -height)
    {
      BGy = 0; 
      BGparallax = !BGparallax;
    }
  }

  void moveBackground()
  {
    if (phase == 1 && !startPhase1)         
      BGy += BGspeed * 2;    
    else if (phase == 2)
    {
      BGy += BGspeed;
      if (BGy >= height)
      {
        BGy = 0;
        if (beginParallax) 
          BGparallax = !BGparallax;
        else
          beginParallax = true;
      }
    } 
    else if (phase == 3)
    {
      if (BGy < 0)
        BGy += BGspeed;
    } 
    else if (phase == 4 || phase == 5)
      parallaxBg();
  }

  void renderBackground()
  {
    if (phase != 0 || phase != 1 || phase != 3)
    {   
      PImage BG1;
      PImage BG2;
      boolean switchBG;
      if (!beginParallax)
      {
        BG1 = cloudSky;
        BG2 = bgCloud1;
        switchBG = true;
      } 
      else
      {
        if (BGparallax)
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
      pushMatrix();   
      translate(0, BGy, 0);
      drawBG(BG1, switchBG);
      drawBG(BG2, !switchBG);
      popMatrix();
    }  
    if (phase == 0 || phase == 1)
    {         
      pushMatrix();   
      translate(0, BGy, 0);
      drawBG(woods, true);
      drawBG(cloudSky, false);
      popMatrix();
    }
    if (phase == 3)
    {
      pushMatrix();   
      translate(0, BGy, 0);
      noStroke();
      textureWrap(NORMAL);
      beginShape(QUADS);
      texture(cloudsToSpace);                  
      vertex(0, 0, 0, 0);
      vertex(width, 0, 1, 0);
      vertex(width, cloudsToSpace.height, 1, 1);
      vertex(0, cloudsToSpace.height, 0, 1);
      endShape();
      popMatrix();
    }
  }

  void TimeStamp()
  {      
    pushMatrix();
    stroke(0, 0, 0);
    fill(0, 0, 0);
    ambient(0, 0, 0);
    textSize(20);
    translate (56, 425, 80);             
    text("Survived: ", 0, 0);
    if (phase == 2)
    {                   
      timeSurvived = int((millis() / 1000) - floatingTime);
      if(!debug)
          text(timeSurvived, 100, 0);
    } 
    else
    {
      countDownTime = int((endTime * 2) - ((millis() / 1000) - floatingTime)); 
      if(!debug)
      {
          text(countDownTime, 100, 0);         
          fill(200, 25, 25);
          text(endTime, 100, 17);
      }
    }
    popMatrix();
  }

  void drawBG(PImage picBG, boolean heightPos)
  {
    int bgHeight1;
    int bgHeight2;
    if (heightPos)
    {
      bgHeight1 = 0;
      bgHeight2 = height;
    } 
    else
    {
      bgHeight1 = -height;
      bgHeight2 = 0;

      if (phase == 4 || phase == 5)
      {
        if (BGy <= 0)
        {
          bgHeight1 = height;
          bgHeight2 = height + height;
        }
      }
    }    
    pushMatrix();       
    noStroke();
    textureWrap(NORMAL);
    beginShape(QUADS);
    texture(picBG);                  
    vertex(0, bgHeight1, 0, 0);
    vertex(width, bgHeight1, 1, 0);
    vertex(width, bgHeight2, 1, 1);
    vertex(0, bgHeight2, 0, 1);
    endShape();
    popMatrix();
  }

  void resetComponents()
  {
    Win = new GameOverSuccess();
    Loose = new GameOverFail(); 
    Balloon = new Balloon();
    Enemy = new BadGuy();
    PowerUp = new PowerUp(); 
    cloudCount = 10;
    cloudList = new CloudThings[cloudCount];
    for (int i=0; i <cloudList.length; i++) 
      cloudList[i]=new CloudThings();
    phase = 0; 
    startPhase1 = false;
    balX = 0;
    BGy = 0;
    BGspeed = 2;    
    countDownTime = 0;
    BGparallax = true;
    beginParallax = false;    
    leftTrue = false;
    rightTrue = false;
    gotPowerUp = false;
    reset = false;
    spaceTransition = false;
    debug = false;
  }

  void lighting()
  {
    pushMatrix();
    ambientLight(205, 205, 205);                    // the color put out by the light on everything
    if (phase < 4)
    {
      lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
      directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
    }
    specular(180, 180, 180);                        // removes the this color when lit up
    shininess(9.0);
    if (gotPowerUp)
      ambient(244, 255, 126);
    else 
    ambient(150, 150, 0);    
    popMatrix();
  }
}

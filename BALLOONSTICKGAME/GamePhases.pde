class GamePhases
{ 
  float BGy, BGspeed, textY;
  float [] phaseStartTime;
  int cloudCount, phaseOutCloud, timeSurvived, finishTime, countDownTime;
  String qButton, controls;
  boolean BGparallax, beginParallax, gotPowerUp, startPhase1, startPhase3, debug;
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
    cloudCount = 10;
    resetComponents();
  } 

  void RunPhases()
  {
    renderBackground();
    moveBackground();
    if(phase < 4)
    {      
      Balloon.render();
      Balloon.move();
    }    
    if(phase > 1)
    {        
      for (int i = 0; i < cloudCount; i++)
      {
        cloudList[i].render();
        cloudList[i].move();
        if(gotPowerUp)  
          cloudList[i].move();
      }      
      TimeStamp();
    }

    if(phase == 0)    
      phase00();
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

    if(phase >= 4)  
    {
      if(reset)
        resetComponents();
    }
    if(reset && debug)
        resetComponents();
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
    if(startPhase1)
    {
      if(balPos.x > 0)
      {
        rightTrue = false; 
        leftTrue = true;
      }        
      else if(balPos.x < 0)
      {
        leftTrue = false;
        rightTrue = true;
      }
      else if(balPos.x == 0)
      {
        startPhase1 = false;
        rightTrue = false; 
        leftTrue = false;
        setPhaseTime(1);
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
      else if(BGy <= 500)
      {
        rightTrue = false;
        leftTrue = true;
      }
      if(BGy > 500)
      {
        setPhaseTime(2);  
        phase = 2; 
        balPos.x = 0;
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
    if(gotPowerUp)
      Enemy.retreat();
    else
      Enemy.move();

    if(timeSurvived >= 80) 
    {
      setPhaseTime(3);
      changePhase(3);
      BGy = 0;
    }
    if(Enemy.caughtCheck()) 
    {  
      setPhaseTime(6); 
      changePhase(6);      
    }
  }  
  /**--------------------------[Phase 3]----------------------------------------------------------*/

  void phase03()
  {  
    if(!startPhase3)
    {
      phaseOutCloud = 0;
      startPhase3 = true;
      BGy = height - cloudsToSpace.height;
    }    
    if((millis() / 1000f) > (phaseStartTime[3] + 10f))
    {           
      cloudList[phaseOutCloud].phaseOut = true;
      if(frameCount % 20 == 0)
        if(phaseOutCloud < cloudCount - 1)
          phaseOutCloud ++;
    } 
    if(BGy >= 0)
    {
      setPhaseTime(4);
      phase = 4;
    }
  }
  /**--------------------------[Phase 4]----------------------------------------------------------*/

  void phase04()
  {  
    if(phaseOutCloud != 0)
    {
      if((millis() / 1000f) > (phaseStartTime[4] + 10f))
      {
        cloudList[phaseOutCloud].phaseOut = false;
        if(frameCount % 20 == 0)
          if(phaseOutCloud > 0)
            phaseOutCloud --;
      }
    }
    Win.move();
    Win.render();
    if(BGy <= -1300)
    {
      setPhaseTime(5);
      phase = 5;  
    }
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase05()
  {
    Win.move();
    Win.render();
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase06()
  { 
    Loose.move();
    Loose.render();
    //if(countDownTime < 0)
    //resetComponents();
  }

  void phase07()
  {
    //balloon cloth piece lands on the ground
  }
  

  void setPhase1()
  {
     startPhase1 = true;
     setPhaseTime(1);
     phase = 1;
  }

  void debugPhase(int p)
   {
     resetComponents();
     phase = p;
     debug = true;
     if(p == 3)
     {       
       startPhase3 = false;
       textY = 0;
     }
     if(p == 4)
     {
       for(int i = 0; i < cloudCount; i++)
         cloudList[i].phaseOut = true;
       phaseOutCloud = cloudCount - 1; 
       textY = 50;
     }
     if(p == 5)
     {
       textY = 50;
     }
     setPhaseTime(p);     
   }

  void setPhaseTime(int p)
  {
     phaseStartTime[p] = millis() / 1000f;   
  }

  void changePhase(int p)
  {
    finishTime = timeSurvived;  
    BGparallax = true;
    phase = p;
  }

  void renderBackground()
  {
    if(phase == 2 || phase == 5 || phase == 6)
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
      pushMatrix();   
      translate(0, BGy, 0);
      drawBG(BG1, switchBG);
      drawBG(BG2, !switchBG);
      popMatrix();
    }  
    if(phase == 0 || phase == 1)
    {         
      pushMatrix();   
      translate(0, BGy, 0);
      drawBG(woods, true);
      drawBG(cloudSky, false);
      popMatrix();
    }
    if(phase == 3 || phase == 4)
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
      if(BGy < 0)
        BGy += BGspeed;
    }
    else if(phase == 4)
    {
      if(BGy > -1300)
        BGy -= BGspeed;
    }
    else if(phase == 5 || phase == 6)
      parallaxBg();
  }

  void parallaxBg()
  {
    beginParallax = true;
    BGy -= BGspeed;
    if(BGy <= -height)
    {
      BGy = 0; 
      BGparallax = !BGparallax;
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

  void TimeStamp()
  {    
    float i = ((millis() / 1000f) - phaseStartTime[phase]) / 1.5f;
    if(i >= 0.0f && i <= 1.0f)
    {
      if(phase == 3)
        textY = lerp(0, 50, i);
      if(phase == 5)
        textY = lerp(50, 0, i);
    }
    pushMatrix();
    stroke(0, 0, 0);
    fill(0, 0, 0);
    ambient(0, 0, 0);
    textSize(20);
    translate (56, 425, 80);             
    text("Survived: ", 0, textY);
    countDownTime = int((timeSurvived * 2) - ((millis() / 1000) - phaseStartTime[2]));
    if(phase == 2)
    {                   
      timeSurvived = int((millis() / 1000) - phaseStartTime[2]);
      if(!debug)
        text(timeSurvived, 100, 0);
    }
    else if(phase > 2 && phase < 6)
    {      
      text("Win!", 100, textY);
    }
    else
    { 
      text(countDownTime, 100, 0);         
      fill(200, 25, 25);
      text(timeSurvived, 100, 17);
    }
    popMatrix();
  }

  void resetComponents()
  {
    Win = new GameOverSuccess();
    Loose = new GameOverFail(); 
    Balloon = new Balloon();
    Enemy = new BadGuy();
    PowerUp = new PowerUp();     
    cloudList = new CloudThings[cloudCount];
    for (int i=0; i <cloudList.length; i++) 
      cloudList[i]=new CloudThings();
    phase = 0; 
    startPhase1 = false;
    startPhase3 = false;
    balPos = new PVector(0, height / 2);
    BGy = 0;
    BGspeed = 2; 
    textY = 0;
    phaseStartTime = new float [7];
    setPhaseTime(0);
    countDownTime = 0;
    BGparallax = true;
    beginParallax = false;    
    leftTrue = false;
    rightTrue = false;
    gotPowerUp = false;
    reset = false;
    debug = false;
  }

  void lighting()
  {
    pushMatrix();
    ambientLight(205, 205, 205);
    if(phase < 4)
    {
      lightSpecular(205, 205, 205);
      directionalLight(205, 205, 205, 1, 1, -2);
    }
    specular(180, 180, 180);
    shininess(9.0);
    if(gotPowerUp)
      ambient(244, 255, 126);
    else 
    ambient(150, 150, 0);    
    popMatrix();
  } 
}

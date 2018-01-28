class GamePhases
{ 
  float BGy, BGspeed;

  int cloudCount, timeSurvived, endTime, floatingTime, countDownTime;

  String qButton, controls;

  boolean BGparallax, beginParallax;

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
    BGspeed = 2;
    cloudCount = 10;
    resetComponents();
  } 

  void RunPhases()
  {
    backgroundPhaseDisplay();
    if (phase < 4)
    {      
      Balloon.drawBalloon();
      Balloon.moveBalloon();
    }
    Enemy.render();
    Enemy.move();
    if (phase > 1)
    {        
      for (int i = 0; i < cloudCount; i++)
      {
        cloudList[i].render();
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
      if (reset)
        resetComponents();
    }
  }    
  /**--------------------------[Phase System Begin]----------------------------------------------------------*/

  void phase00()
  {     
    pushMatrix();
    fill(255);
    textSize(20);
    text(qButton, 50, 100);
    text(controls, 50, 50);  
    popMatrix();
  }
  /**--------------------------[Phase 1]----------------------------------------------------------*/

  void phase01()
  {        
    BGy += 5;

    if (BGy < 200)
    {
      balX = int(map(BGy, 0, 200, 0, -250));
      leftTrue = true;
    } else if (BGy < 400)
    {
      balX = int(map(BGy, 200, 400, -250, 100));
      leftTrue = false;
      rightTrue = true;
    } else if (BGy < 500)
    {
      balX = int(map(BGy, 400, 500, 100, 0));
      rightTrue = false;
      leftTrue = true;
    }

    if (BGy > 500)
    {
      phase = 2;
      floatingTime = int(millis() / 1000);  
      balX = 0;
      leftTrue = false;
      BGy = 0;
      beginParallax = false;
      BGparallax = true;
    }
  }
  /**--------------------------[Phase 2]----------------------------------------------------------*/

  void phase02()
  {  
    BGy += BGspeed;
    if (BGy >= 500)
    {
      BGy = 0;
      if (beginParallax) 
        BGparallax = !BGparallax;
      else
        beginParallax = true;
    }

    PowerUp.ActualPowerUp();
    PowerUp.PowerMove();
    gotPowerUp = PowerUp.PowerGrab();

    if (timeSurvived >= 80) 
      phase = changePhase(3);
    if (caught) 
      phase = changePhase(5);
  }  
  /**--------------------------[Phase 3]----------------------------------------------------------*/

  void phase03()
  {     
      //parallax into space
      pushMatrix();       
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
      //phase = 4;
  }
  /**--------------------------[Phase 4]----------------------------------------------------------*/

  void phase04()
  {          
    parallaxBg();
    Win.GameOverMove();
    Win.GameOverRender();      
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase05()
  {
    parallaxBg();
    Loose.GameOverMove();  
    Loose.GameOverRender();
  }
  /**--------------------------[Phase 5]----------------------------------------------------------*/

  void phase06()
  {
    //balloon cloth piece lands on the ground
  }

  int changePhase(int p)
  {
    endTime = timeSurvived;  
    BGparallax = true;
    return p;
  }

  void parallaxBg()
  {
    beginParallax = true;
    BGy -= BGspeed;
    if (BGy <= -500)
    {
      BGy = 0; 
      BGparallax = !BGparallax;
    }
  }

  void backgroundPhaseDisplay()
  {
    if (phase != 0 || phase != 1  || phase != 3)
    {                       
      pushMatrix();   
      translate(0, BGy, 0);
      if (!beginParallax)
      {
        drawBG(cloudSky, true);
        drawBG(bgCloud1, false);
      } else
      {
        if (BGparallax)
        {
          drawBG(bgCloud1, true);
          drawBG(bgCloud2, false);
        } else
        {
          drawBG(bgCloud1, false);
          drawBG(bgCloud2, true);
        }
      }
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
      text(timeSurvived, 100, 0);
    } else
    {
      countDownTime = int((endTime * 2) - ((millis() / 1000) - floatingTime));          
      text(countDownTime, 100, 0);         
      fill(200, 25, 25);
      text(endTime, 100, 17);
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
    } else
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
    cloudList = new CloudThings[cloudCount];
    for (int i=0; i <cloudList.length; i++) 
      cloudList[i]=new CloudThings();
    phase = 0; 
    balX = 0;
    BGy = 0;
    countDownTime = 0;
    BGparallax = true;
    beginParallax = false;    
    leftTrue = false;
    rightTrue = false;
    gotPowerUp = false;
    caught = false;
  }
}
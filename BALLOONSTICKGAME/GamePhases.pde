class GamePhases
  { 
   String qButton;
   String controls;
   
   GamePhases()
     { 
       qButton = "Press Q for freedom.";
       controls = "Use A and D to steer.";
       BGy = 0;
     } 
     
   void RunPhases()
     {
       backgroundPhaseDisplay();
       if(phase < 3)
         {
           Balloon.drawBalloon();
           Balloon.moveBalloon();
           BalloonString.drawBalloonString(); 
         }
       if(phase > 1)
          {
            for (int i=0; i <cloudList.length; i++)
              {
                 cloudList[i].render();
                 cloudList[i].move();
              }  
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
     }    
   /**--------------------------[Phase System Begin]----------------------------------------------------------*/
    
   void phase00()
     {     
       pushMatrix();
         fill(255);
         text(qButton, 50, 100);
         text(controls, 50, 50);  
       popMatrix();
     }
   /**--------------------------[Phase 1]----------------------------------------------------------*/
    
   void phase01()
     {        
        BGy += 5;
        
        if(BGy < 200)
          {
            balX = int(map(BGy, 0, 200, 0, -250));
            leftTrue = true;
          }
        else if(BGy < 400)
          {
            balX = int(map(BGy, 200, 400, -250, 100));
            leftTrue = false;
            rightTrue = true;
          }
        else if(BGy < 500)
          {
            balX = int(map(BGy, 400, 500, 100, 0));
            rightTrue = false;
            leftTrue = true;
          }
        
        if(BGy > 500)
          {
            phase = 2;
            floatingTime = int(millis()/1000);  
            balX = 0;
            leftTrue = false;
          }
    }
  /**--------------------------[Phase 2]----------------------------------------------------------*/
    
   void phase02()
     {  
        for (int i=0; i <PowerUpList.length; i++)
          {   
            PowerUpList[i].ActualPowerUp();
            PowerUpList[i].PowerMove();
            PowerUpList[i].PowerGrab();
          }        
        for (int i=0; i <enemiesList.length; i++)
          {   
            enemiesList[i].render();
            enemiesList[i].move();
          }
          
        timeSurvived = int((millis()/1000) - floatingTime);         
        surviveTimeStamp();
              
        if(timeSurvived == 80) 
          {  
            endTime = timeSurvived;  
            phase = 3;      // if the time played is reached then change phase
          }
        if(caught == true) 
          {
            endTime = timeSurvived;
            phase = 4;
          }
     }
   /**--------------------------[Phase 3]----------------------------------------------------------*/
    
   void phase03()
     {
          Win.GameOverMove();
          Win.GameOverRender();
          
          timeSurvived = int((endTime*2) - ((millis()/1000) - floatingTime));          
          surviveTimeStamp();   
     }
   /**--------------------------[Phase 4]----------------------------------------------------------*/    
    
   void phase04()
     {
          Loose.GameOverMove();  
          Loose.GameOverRender();           
          
          timeSurvived = int((endTime*2) - ((millis()/1000) - floatingTime));       
          surviveTimeStamp();
     }
    /**--------------------------[Phase 5]----------------------------------------------------------*/
    
    void phase05()
      {
        //balloon cloth piece lands on the ground
        
      }
    /**--------------------------[Phase End]--------------------------------------------------------*/
    
    void backgroundPhaseDisplay()
      {
         if(phase != 0 && phase != 1)
           {                       
             drawBG(cloudSky, true);
             tint(255, 255, 255, fadeImage);      //Transitions from day time to night time
             drawBG(nightSky, true);
             noTint();                //End night fade    
           }  
         if(phase == 0 || phase == 1)
           {         
             pushMatrix();   
               translate(0, BGy, 0);                  //moves both images together as 1
                 pushMatrix();                 
                   drawBG(woods, true);
                   drawBG(cloudSky, false);
                 popMatrix();
             popMatrix();
           }  
      }
      
    void surviveTimeStamp()
      {      
          pushMatrix();
            stroke(0, 0, 0);
            fill(0, 0, 0);
            ambient(0, 0, 0);
            textSize(20);
            translate (10, 470);             
              text("Survived: ", 0, 0);
              if(phase != 2)
                { 
                  text(endTime, 100, 0);         
                  ambient(200, 25, 25);
                  text(timeSurvived, 100, 17);
                }
              else
                {
                  text(timeSurvived,  100, 0);
                }
          popMatrix();
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
}
class GamePhases
  { 
   String q;
   String controls;
     
   float y;  
   
   GamePhases()
     { 
       q = "Press Q for freedom.";
       controls = "Use A and D to steer.";
       y = 0;
     }  
    /**--------------------------[Phase System Begin]----------------------------------------------------------*/
    
   void phase00()
     {     
       backgroundPhaseDisplay();
       
       fill(255);
       text(q, 50, 100);
       text(controls, 50, 50);
              
       Balloon.drawBalloon();
       Balloon.moveBalloon();
       BalloonString.drawBalloonString();  
       image(lol, 120, 300);    
     }
     /**--------------------------[Phase 1]----------------------------------------------------------*/
    
   void phase01()
     {
        backgroundPhaseDisplay();
        
        Balloon.drawBalloon();
        Balloon.moveBalloon();
        BalloonString.drawBalloonString();
        
        y += 5;
        if(y < 200)
          {
            balX = int(map(y, 0, 200, 0, -250));
            leftTrue = true;
          }
        else if(y < 400)
          {
            balX = int(map(y, 200, 400, -250, 100));
            leftTrue = false;
            rightTrue = true;
          }
        else if(y < 500)
          {
            balX = int(map(y, 400, 500, 100, 0));
            rightTrue = false;
            leftTrue = true;
          }
        
        if(y == 500)
          {
            phase = 2;
            balX = 0;
            leftTrue = false;
          }
    }
    /**--------------------------[Phase 2]----------------------------------------------------------*/
    
   void phase02()
     {
         backgroundPhaseDisplay();
          
          Balloon.drawBalloon();
          Balloon.moveBalloon();
          BalloonString.drawBalloonString();
          
          for (int i=0; i <cloudList.length; i++)
            {
              cloudList[i].render();
              cloudList[i].move();
            }    
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
          
          timeSurvived = int((millis() - floatingTime)/1000);         
          surviveTimeStamp();
                
          if(timeSurvived == 80) 
            {
              phase = 3;      // if the time played is reached then change phase
              endTime = timeSurvived;  
            }
          if(caught == true) 
            {
              phase = 4;
              endTime = timeSurvived;
            }
     }
     /**--------------------------[Phase 3]----------------------------------------------------------*/
    
   void phase03()
     {
        pushMatrix();
          backgroundPhaseDisplay();
          
          Win.GameOverMove();
          Win.GameOverRender();
          
          timeSurvived = int((endTime*2) - (millis()/1000));          
          surviveTimeStamp();            
        popMatrix();
     }
   /**--------------------------[Phase 4]----------------------------------------------------------*/    
    
   void phase04()
     {
        pushMatrix();  
          backgroundPhaseDisplay();
             
          Loose.GameOverMove();  
          Loose.GameOverRender();           
          
          timeSurvived = int((endTime*2) - (millis()/1000));       
          surviveTimeStamp();
        popMatrix();
     }
    /**--------------------------[Phase 5]----------------------------------------------------------*/
    
    void phase05()
      {
        //balloon cloth piece lands on the ground
        
      }
      
    void backgroundPhaseDisplay()
      {
        background(255);
        if(phase != 0 && phase != 1)
          {                       
            drawFadeBG(cloudSky);
            tint(255, 255, 255, fadeImage);      //Transitions from day time to night time
            drawFadeBG(nightSky);
            noTint();                //End night fade          
            if(phase != 2)
             {
               pushMatrix();
                 translate(width/2, height/2, 0);                 //the center of the screen coordinates are (0 , 0, 0)
                   scale(.4);     
                   for (int i=0; i <cloudList.length; i++)
                     {
                       cloudList[i].render();
                       cloudList[i].move();
                     }
               popMatrix();
             }         
          }  
        
        if(phase == 0 || phase == 1)
          {         
            pushMatrix();          
              translate(0, y, -10);                  //moves both images together as 1
                pushMatrix();                  //connects both shapes together as 1
                  beginShape(QUADS);
                    texture(woods);
                    vertex(-10, -15, 0, 0);
                    vertex(width+10, -15, 1, 0);
                    vertex(width+10, height, 1, 1);
                    vertex(-10, height, 0, 1);
                  endShape();                
                  translate(0, 0, 10); // bring forward a little bit                
                    beginShape(QUADS);
                      texture(cloudSky);              //draw second image just above the first image
                      vertex(0, 0-height, 0, 0);
                      vertex(width, 0-height, 1, 0);
                      vertex(width, 0, 1, 1);
                      vertex(0, 0, 0, 1);
                    endShape();
                popMatrix();
           popMatrix();
         }
      }
      
    void surviveTimeStamp()
      {      
          stroke(0, 0, 0);
          fill(0, 0, 0);
          ambient(0, 0, 0);
          textSize(20);
           
            if(phase != 2)
              { 
                pushMatrix();
                  translate (width/2, height/2);  
                    scale(.4);
                    translate (-350,400);            
                      text("Survived: ", 40, -100, 500);
                      text(endTime, 155, -100, 500);            //display the survived time
                      ambient(200, 25, 25);
                      text(timeSurvived, 155, -80, 500);
                popMatrix();
              }
            if(phase == 2)
              {     
                pushMatrix();
                  translate (width/2, height*2);
                    text("Survived: ", 40, -100, 500);
                    text(timeSurvived,  155, -100, 500);            //display the survived time
                popMatrix();
              }
        
      }
      
    void drawFadeBG(PImage picBG)
      {
        pushMatrix();                 
          textureWrap(NORMAL);
          beginShape(QUADS);
            texture(picBG);                  
            vertex(-200, -200, -200, 0, 0);
            vertex(650, -200, -200, 1, 0);
            vertex(650, 700, -200, 1, 1);
            vertex(-200, 700, -200, 0, 1);
            endShape();
        popMatrix(); 
      }
}
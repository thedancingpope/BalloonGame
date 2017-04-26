//Balloon goes above the screen, the screen follows it, and then the balloon 
//reaches space and pops.
/** phase0 will be the section in which the balloon
 is on the stick/string . It is the intro phase.
 phase1 will be the section in which the balloon is
 Seemingly propelled upwards. This will be accomplished by
 scrolling the background as a parallax behind the balloon,
 which will detach from the string and the stick when a 
 counter condition is met. I will have the counter condition
 look for the player pressing the "w" key 1 time. 
 Phase 2 is the final phase. This phase is instantiated 
 when the balloon reaches a certain height of pixels. The 
 balloon, having met this condition, will then fall towards the
 ground. The player will only have right/left control over the 
 balloon at this point.
 */
/**
@TheDancingPope
@MeeeMooo
*/
/**
 Phase Zero Pseudo:
 -Draw background(It's larger than the screen   0 minus image height, then add screen height.
 It offsets the background so you start and the bottom and can scroll it down.
 -Draw image of balloon on a mouse coordinate.
 -Draw an image of the stick which is a tethering point for the moving line of the string.
 -To leave this state and enter phase one, the player must press "up" or the "w" key. There 
 will be a counter looking for this condition
 */

import processing.serial.*;

Serial port;

String data;

float lineX;
float lineY;

int fadeImage;
int val[];
int value1;
int balX;
int phase; 
int timeSurvived;
int endTime;
int floatingTime;

boolean leftTrue = false;
boolean rightTrue = false;
boolean gotPowerUp = false;
boolean caught = false;

PImage woods;
PImage lol;
PImage balloon;
PImage cloudSky;
PImage nightSky;

PFont font;

Balloon Balloon;
BalloonString BalloonString;
Spring2D s1, s2, s3, s4, s5, s6;
CloudThings[] cloudList;
BadGuy[] enemiesList;
PowerUp [] PowerUpList;
GameOverSuccess Win;
GameOverFail Loose;
GamePhases Phases;

void setup()               //Fun note, if you put background in setup, you get infinite balloon madness
  {
    size(500, 500, P3D);
    frameRate(45);
    font = loadFont("ArialRoundedMTBold-36.vlw");
    textFont(font);
    textureMode(NORMAL);   
    textSize(20);
    stroke(0);
    
    //port = new Serial(this, "COM3", 9600);         //  "/dev/cu.usbmodem1411" or "com3"
    //port.bufferUntil('\n');
    data = "";
    
    Win = new GameOverSuccess();
    Loose = new GameOverFail();
    Phases = new GamePhases();
    
    cloudList = new CloudThings[10];
    for (int i=0; i <cloudList.length; i++) 
      {
        cloudList[i]=new CloudThings();
      }
    enemiesList = new BadGuy[1];
    for (int i=0; i <enemiesList.length; i++) 
      {
        enemiesList[i]=new BadGuy();
      }
      
     PowerUpList = new PowerUp[1];
    for (int i=0; i <PowerUpList.length; i++) 
      {
        PowerUpList[i]=new PowerUp();
      }
  
    woods=loadImage("ForestBackgroundOne.jpg");
    lol=loadImage("Wood-Grain-Web-2.jpg");
    balloon=loadImage("Balloon Up_Down.png");
    cloudSky=loadImage("CloudBackgroundReg.jpg");
    nightSky=loadImage("nightTime.jpg");
      
    Balloon = new Balloon();
    BalloonString = new BalloonString();
    s1 = new Spring2D(0.0, width);
    s2 = new Spring2D(0.0, width);
    s3 = new Spring2D(0.0, width/2);
    s4 = new Spring2D(0.0, width/2);
    s5 = new Spring2D(0.0, width/2);
    s6 = new Spring2D(0.0, width/2);
    
    phase = 0; 
    balX = 0;
    fadeImage = 0;
  }

void draw()
  {
    if(phase == 0)    
     Phases.phase00();  
      
    if(phase == 1)    
     Phases.phase01();
      
    if(phase == 2)    
      Phases.phase02();      
      
    if(phase == 3)       
      Phases.phase03();      
      
    if(phase == 4)    
      Phases.phase04();
     
    if(phase == 5)    
      Phases.phase05();    
  }

void serialEvent(Serial port)
  { 
    int val[] = new int [2];
    data = port.readStringUntil('\n');
  
    val = int(split(data, " "));
    fadeImage = int(map(val[0], 25, 1025, 255, 0)); 
    value1 = int(map(val[1], 0, 1200, 0, 255));
  }

void keyPressed()
  {
    if(key == 'a' || key == 'A')      
      leftTrue = true;        
    else if(key == 'd' || key == 'D') 
      rightTrue = true; 
  }

void keyReleased()
  {
    if(key == 'a' || key == 'A') 
      leftTrue = false;
    else if(key == 'd' || key == 'D') 
      rightTrue = false;
      
    if(key == 'q' || key == 'Q')    
      {
        if(phase == 0)    // only sets if it is phase 0 
          {  
            phase = 1;    // sets to phase 1
            floatingTime = int(millis()/1000);        
          }
      }
      
    if(key == 'p' || key == 'P')
      phase = 3;
      
    if(key == 'l' || key == 'L')
      phase = 4;
  }
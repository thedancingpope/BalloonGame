/** Current Info: We're looking at adding several new features to the game, in order to move it closer to completion.
With the main body of the game's code now finished, the remaining changes are mostly cosmetic, and in keeping with
certain visual themes and patterns already established. Here are some changes we're floating around:
-A quick balloon animation, such as a swelling or wiggle when a helium atom is caught.*
-The parallax of the clouds during the main phase moving faster when a helium atom is caught.*
-Stratosphere animation:
    -Extended background.
    -Balloon popping animation.
    -Confetti.
-Music
-Balloon hitting ground (animation).

Sincerely, 

TheDancingPope
 */
/**
@TheDancingPope
@MeeeMooo
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
    frameRate(30);
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
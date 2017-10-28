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
float lineZ;
float BGy;  //Background Y 
float ex;            //Enemy xpos
float ey;            //Enemy ypos
float PowerY = 0;

int fadeImage;
int val[];
int value1;
int balX;
int phase; 
int timeSurvived;
int endTime;
int floatingTime;
int PowerX;

boolean leftTrue = false;
boolean rightTrue = false;
boolean gotPowerUp = false;
boolean caught = false;
boolean reset = false;

PImage woods;
PImage lol;
PImage balloon;
PImage cloudSky;
PImage nightSky;
PImage bgCloud1;
PImage bgCloud2;

PFont font;

Balloon Balloon;
BalloonString BalloonString;
Spring2D s1, s2, s3, s4;
CloudThings[] cloudList;
BadGuy [] enemiesList;
PowerUp [] PowerUpList;
GameOverSuccess Win;
GameOverFail Loose;
GamePhases GamePhases;

void setup()               //Fun note, if you put background in setup, you get infinite balloon madness
  {
    size(500, 500, P3D);
    frameRate(25);
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
    GamePhases = new GamePhases();
    
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
  
    woods = loadImage("ForestBackgroundOne.jpg");
    lol = loadImage("Wood-Grain-Web-2.jpg");
    balloon = loadImage("Balloon Up_Down.png");
    cloudSky = loadImage("CloudBackgroundReg.jpg");
    nightSky = loadImage("nightTime.jpg");
    bgCloud1 = loadImage("BlueSky2.jpg");
    bgCloud2 = loadImage("BlueSky2.jpg");
      
    Balloon = new Balloon();
    BalloonString = new BalloonString();
    
    s1 = new Spring2D(width/2, height/2);
    s2 = new Spring2D(width/2, height/2);
    s3 = new Spring2D(width/2, height/2);
    s4 = new Spring2D(width/2, height/2);
    
    phase = 0; 
    balX = 0;
    fadeImage = 0;
    lineZ = 10;
  }

void draw()
  {
      GamePhases.RunPhases();  
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
    if(phase != 1)
      {
        if(key == 'a' || key == 'A')       
          leftTrue = true;        
        else if(key == 'd' || key == 'D') 
          rightTrue = true; 
      }
    if(key == 'r' || key == 'R')
      reset = true;
  }

void keyReleased()
  {
    if(key == 'a' || key == 'A') 
      leftTrue = false;
    else if(key == 'd' || key == 'D') 
      rightTrue = false;
      
    if(key == 'r' || key == 'R')
      reset = false;  
      
    if(key == 'q' || key == 'Q')    
      {
        if(phase == 0)
            phase = 1;       
      }
      
    if(key == 'p' || key == 'P')
      phase = 3;
      
    if(key == 'l' || key == 'L')
      phase = 4;
  }
  
void BalloonLighting()
  {
     pushMatrix();
       ambientLight(205, 205, 205);                    // the color put out by the light on everything
       if(phase < 3)
         {
            lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
            directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
         }
       specular(180, 180, 180);                        // removes the this color when lit up
       shininess(9.0);
       if(phase == 2)
         { 
            if(gotPowerUp)
              ambient(244, 255, 126);
            else 
              ambient(150, 150, 0);                          //light the balloon this color
         }
       else 
         {
            ambient(150, 150, 0);
         }
     popMatrix();
  }
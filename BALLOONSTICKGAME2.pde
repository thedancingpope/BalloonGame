//Balloon goes above the screen, the screen follows it, and then the balloon 
//reaches space and then pops.
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

String q = "Press Q for freedom.";
String controls = "Use A and D to steer.";
String data = "";

float size;
float line;
float speed = 1;
float gravity = 1;
float fadeImage = 0;
float TimePressedUp;
float easing = 0.02;
float x = 0;
float y = 0;
float angle = 0.0;
float val[] = new float [2];
float lineX;
float lineY;
float floatingTime = 0;

int balloonWidth = 200;
int balloonHeight = 200;
int balloonSpeed = 2;
int value, value1;
int posX;
int posY;
int balX = 0;
int phase; 
int timeSurvived = 0;

boolean p1UP = false;
boolean p1DOWN = false;
boolean p1LEFT = false;
boolean p1RIGHT = false;
boolean upCheck = false;
boolean balloonMove = false;
boolean upTrue, downTrue;
boolean leftTrue = false;
boolean rightTrue = false;
boolean gotPowerUp = false;

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

void setup()                      //Fun note, if you put background in setup, you get infinite balloon madness
{
  size(500, 500, P3D);
  frameRate(65);
  
  //port = new Serial(this, "COM3", 9600);            //  "/dev/cu.usbmodem1411" or "com3"
  //port.bufferUntil('\n');
  
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
    
   PowerUpList = new PowerUp[2];
  for (int i=0; i <PowerUpList.length; i++) 
    {
      PowerUpList[i]=new PowerUp();
    }

  woods=loadImage("ForestBackgroundOne.jpg");
  lol=loadImage("Wood-Grain-Web-2.jpg");
  balloon=loadImage("Balloon Up_Down.png");
  cloudSky=loadImage("CloudBackgroundReg.jpg");
  nightSky=loadImage("nightTime.jpg");
  
  posX = width/2;
  posY = height/2;
  val[0] = 0;
  val[1] = 0;
  size = random(25, 80);
  
  Balloon = new Balloon();
  BalloonString = new BalloonString();
  s1 = new Spring2D(0.0, width, 2.0, 9.0);
  s2 = new Spring2D(0.0, width, 2.0, 9.0);
  s3 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s4 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s5 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s6 = new Spring2D(0.0, width/2, 2.0, 9.0);
  
  
  font = loadFont("ArialRoundedMTBold-36.vlw");
  textFont(font);
  textureMode(NORMAL);    
}

void draw()
{
/**--------------------------[Phase System Begin]----------------------------------------------------------*/
  if (phase == 0)
    {
      //DRAW BACKGROUND
  
      background(woods);
      stroke(0);
      fill(255);
      text(q, 50, 100);
      text(controls, 50, 50);
      textSize(24);
      
  
      //THE BALLOON
      noStroke();
      fill(245, 91, 97);
      Balloon.drawBalloon();
      Balloon.moveBalloon();
      BalloonString.drawBalloonString();
  
      //THE STICK
      image(lol, 228, 300);
            
      if (keyPressed) 
        {
          if (key == 'q') phase = 1;
        }
    }
/**--------------------------[Phase 1]----------------------------------------------------------*/
  if (phase == 1)
    {
      //Balloon.drawBalloon();
      //Balloon.moveBalloon();
  
      //background(255);
      pushMatrix();
        translate(0, y);                  //moves both images together as 1
          pushMatrix();                  //connects both shapes together as 1
            beginShape(QUADS);
              texture(woods);
              vertex(0, -2, 0, 0);
              vertex(width, -2, 1, 0);
              vertex(width, height, 1, 1);
              vertex(0, height, 0, 1);
            endShape();
        
            beginShape(QUADS);
              texture(cloudSky);              //draw second image just above the first image
              vertex(0, 0-height, 0, 0);
              vertex(width, 0-height, 1, 0);
              vertex(width, 0, 1, 1);
              vertex(0, 0, 0, 1);
            endShape();
          popMatrix();
      popMatrix();
      
      Balloon.drawBalloon();
      Balloon.moveBalloon();
      BalloonString.drawBalloonString();
      
      noStroke();
      textSize(45);
      text("^ Escape ^", 50, 50);
  
      if (keyPressed == true)    
        {
          if (key == 'w' || key =='W')     // stop moving at the top
            {
              if (y < 500) y +=2;          //if not at the top, move both images up       
            }
          if (key =='s' || key == 'S')      // stop moving at the bottom
            {
              if (y>0) y -=5;              //if not at the bottom, move both images down                  
            }
        }
    }
//flip bool when w key pressed
/**--------------------------[Phase 2]----------------------------------------------------------*/
//Start the y coord of the image at a negative.
  if (phase == 2)
    {
      
      //Phase 2 cloud machine
      //Balloon and controls  
      background(255);      
      pushMatrix();                  //connects both shapes together as 1
        textureWrap(NORMAL);
        beginShape(QUADS);
        texture(cloudSky);                  //draw first image on the panel
        vertex(-200, -200, -200, 0, 0);
        vertex(650, -200, -200, 1, 0);
        vertex(650, 700, -200, 1, 1);
        vertex(-200, 700, -200, 0, 1);
        endShape();
      popMatrix();
      tint(255, 255, 255, fadeImage);      //NightTransition
      pushMatrix();  
        textureWrap(NORMAL);
        beginShape(QUADS);
        texture(nightSky);              //draw second image just above the first image
        vertex(-200, -200, -200, 0, 0);
        vertex(650, -200, -200, 1, 0);
        vertex(650, 700, -200, 1, 1);
        vertex(-200, 700, -200, 0, 1);
        endShape();      
      popMatrix();
      noTint();                //End night fade      
      
      //fill(value1, mouseX, value);
      //value is left sensor, value1 is right if pins are facing you
      //ellipse(mouseX, mouseY, value, value1);
      //fill(150, 150, 0);
      Balloon.drawBalloon();
      Balloon.moveBalloon();
      BalloonString.drawBalloonString();
      
      for (int i=0; i <cloudList.length; i++)
        {
          cloudList[i].render();
          cloudList[i].move();
        }
  
      for (int i=0; i <enemiesList.length; i++)
        {   
          enemiesList[i].render();
          enemiesList[i].move();
        }
      
      for (int i=0; i <enemiesList.length; i++)
        {   
          PowerUpList[i].ActualPowerUp();
          PowerUpList[i].PowerMove();
        }
    
            
  
      if (p1UP==true) posY -=balloonSpeed;        // Controls
      if (p1DOWN==true) posY +=balloonSpeed;        
      if (p1LEFT==true) posX -= balloonSpeed;
      if (p1RIGHT==true) posX += balloonSpeed;
      
      timeSurvived = int((millis() - floatingTime)/1000);
      stroke(0, 0, 0);
      fill(0, 0, 0);
      ambient(0, 0, 0);
      translate (width/2, height*2);
      text("Survived: ", 40, -100, 500);
      text(timeSurvived, 155, -100, 500);            //display the survived time
      
      
      
      //if(timeSurvived == minute()) phase = 3;      // if the time played is reached then change phase
    }
/**--------------------------[Phase 3]----------------------------------------------------------*/
  if (phase == 3) //Goal reached phase
    {
      background(255);
      /**
       Animation phase of balloon / Guided fall.
       Series of Sprites run, giving the illusion of a popping balloon.
       Formulation to do reverse parralax movement with the added condition of side to side movement.
       After certain time-limit of falling-state, the background is cycled in slowly.
       Balloon death animation
       End.
       */
    }
/**--------------------------[Phase 4]----------------------------------------------------------*/    
  if (phase == 4)
    {
    
    }
  
}
/**--------------------------[End Phase 4]----------------------------------------------------------*/
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
  if(key == 'a' || key == 'A') leftTrue = true;
  else if(key == 'd' || key == 'D') rightTrue = true;
  
  //if (key == 'w' || key =='W') upTrue=true;
  //else if (key =='s' || key == 'S') downTrue=true;
}

void keyReleased()
{
  if(key == 'a' || key == 'A') leftTrue = false;
  else if(key == 'd' || key == 'D') rightTrue = false;
  
  if(key == 'e' || key == 'E') 
    {
      floatingTime = millis();
      phase = 2;
      balX = 0;
    }
  
  //if (key == 'w' || key =='W')   upTrue=false;
  //else if (key =='s' || key == 'S')   downTrue=false;
}


/**
 -----------End Controls-------------------------------------
 */
//Addition needed: A condition set up so that after 1 minute of upward movement you reach phase

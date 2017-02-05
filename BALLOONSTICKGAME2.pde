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

String q = "Press Q for freedom.";
String controls = "Use A and D to steer.";
String data = "";

float fadeImage = 0;
float y = 0;
float lineX;
float lineY;
float floatingTime = 0;


int val[];
int value1;
int balX = 0;
int phase = 0; 
int timeSurvived = 0;

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
  
  Win = new GameOverSuccess();
  Loose = new GameOverFail();
  
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
  s1 = new Spring2D(0.0, width, 2.0, 9.0);
  s2 = new Spring2D(0.0, width, 2.0, 9.0);
  s3 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s4 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s5 = new Spring2D(0.0, width/2, 2.0, 9.0);
  s6 = new Spring2D(0.0, width/2, 2.0, 9.0);
  
}

void draw()
{
/**--------------------------[Phase System Begin]----------------------------------------------------------*/
  if (phase == 0)
    {
     phase00();  
    }
/**--------------------------[Phase 1]----------------------------------------------------------*/
  if (phase == 1)
    {
     phase01();
    }
/**--------------------------[Phase 2]----------------------------------------------------------*/
  if (phase == 2)
    {
      phase02();      
    }
/**--------------------------[Phase 3]----------------------------------------------------------*/
  if (phase == 3) //Goal reached phase
    {
      background(255);
      Win.GameWin();
      /**
       Animation phase of balloon / Guided fall.
       Series of Sprites run, giving the illusion of a popping balloon.
       Formulation to do reverse parralax movement with the added condition of side to side movement.
       After certain time-limit of falling-state, the background is cycled in slowly.
       Balloon death animation
       End.
       */   
       
       // make the enemy cloud fall away
       // pull up into space
       // pop balloon 
       //begin cloth flowing code
       // fall to the ground
    }
/**--------------------------[Phase 4]----------------------------------------------------------*/    
  if (phase == 4)
    {
      background(0);
      Loose.render();
      Loose.LooseMove();
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
  if(key == 'a' || key == 'A') 
    //if(phase == 0 || phase == 2)
      leftTrue = true;
      
  else if(key == 'd' || key == 'D') 
   // if(phase == 0 || phase == 2)
      rightTrue = true; 
}

void keyReleased()
{
  if(key == 'a' || key == 'A') leftTrue = false;
  else if(key == 'd' || key == 'D') rightTrue = false;
  
  //if(key == 'e' || key == 'E') 
  //  {
  //    floatingTime = millis();
  //    phase = 2;
  //    balX = 0;
  //  }
  
  if(key == 'q' || key == 'Q')    
    {
      if(phase == 0)    // only sets if it is phase 0 
        {  
          phase = 1;    // sets to phase 1
          floatingTime = millis();        
        }
    }
    
  if(key == 'p' || key == 'P')
    phase = 3;
    
  if(key == 'l' || key == 'L')
    phase = 4;
}

void phase00()
{
  //DRAW BACKGROUND
  background(255);
  textSize(20);
  pushMatrix();
   beginShape(QUADS);
      texture(woods);      
      vertex(0, 0, 0, 0);
      vertex(width, 0, 1, 0);
      vertex(width, height, 1, 1);
      vertex(0, height, 0, 1);
    endShape();
  popMatrix();
  fill(255);
  text(q, 50, 100);
  text(controls, 50, 50);
          
  //THE BALLOON
  Balloon.drawBalloon();
  Balloon.moveBalloon();
  BalloonString.drawBalloonString();

  //THE STICK
  image(lol, 120, 300);    
}

void phase01()
{
 background(255);
 textSize(20);
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

void phase02()
{
     //Phase 2 cloud machine
      background(255);      
      textSize(20);
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
      stroke(0, 0, 0);
      fill(0, 0, 0);
      ambient(0, 0, 0);
      pushMatrix();
        translate (width/2, height*2);
        text("Survived: ", 40, -100, 500);
        text(timeSurvived, 155, -100, 500);            //display the survived time
      popMatrix();
      if(timeSurvived == 80) phase = 3;      // if the time played is reached then change phase
      
      if(caught == true) phase = 4; 
}

/**
 -----------End Controls-------------------------------------
 */
//Addition needed: A condition set up so that after 1 minute of upward movement you reach phase

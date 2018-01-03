/** Current Info: We're looking at adding several new features to the game, in order to move it closer to completion.
 With the main body of the game's code now finished, the remaining changes are mostly cosmetic, and in keeping with
 certain visual themes and patterns already established. Here are some changes we're floating around:
 -Stratosphere animation:
 -Extended background.
 -Balloon popping animation.
 -Music
 -Balloon hitting ground (animation).
 
 Sincerely, 
 
 TheDancingPope
 */
/**
 @TheDancingPope
 @MeeeMooo
 */
int balX, phase; 

boolean leftTrue, rightTrue, gotPowerUp, caught, reset;

PImage woods, cloudSky, bgCloud1, bgCloud2;

PFont font;

GamePhases GamePhases;

void setup()
{
  size(500, 500, P3D);
  frameRate(25);
  font = loadFont("ArialRoundedMTBold-36.vlw");
  textFont(font);
  textureMode(NORMAL);   
  textSize(20);
  stroke(0);

  GamePhases = new GamePhases();

  woods = loadImage("ForestBackgroundOne.jpg");
  cloudSky = loadImage("CloudBackgroundReg.jpg");
  bgCloud1 = loadImage("BlueSky2.jpg");
  bgCloud2 = loadImage("BlueSky2.jpg");
}

void draw()
{
  GamePhases.RunPhases();
}

void keyPressed()
{
  if (phase != 1)
  {
    if (key == 'a' || key == 'A')       
      leftTrue = true;        
    else if (key == 'd' || key == 'D') 
      rightTrue = true;
  }
  if (key == 'r' || key == 'R')
    reset = true;
}

void keyReleased()
{
  if (phase != 1)
  {  
    if (key == 'a' || key == 'A') 
      leftTrue = false;
    else if (key == 'd' || key == 'D') 
      rightTrue = false;
  }
  if (key == 'r' || key == 'R')
    reset = false;  

  if (key == 'q' || key == 'Q')    
  {
    if (phase == 0)
      phase = 1;
  }

  if (key == 'p' || key == 'P')
    phase = 3;

  if (key == 'l' || key == 'L')
    phase = 4;
}

void BalloonLighting()
{
  pushMatrix();
  ambientLight(205, 205, 205);                    // the color put out by the light on everything
  if (phase < 3)
  {
    lightSpecular(205, 205, 205);                    //the light that will be removed on shiny parts
    directionalLight(205, 205, 205, 1, 1, -2);      // directional light facing the balloon
  }
  specular(180, 180, 180);                        // removes the this color when lit up
  shininess(9.0);
  if (phase == 2)
  { 
    if (gotPowerUp)
      ambient(244, 255, 126);
    else 
    ambient(150, 150, 0);                          //light the balloon this color
  } else 
  {
    ambient(150, 150, 0);
  }
  popMatrix();
}
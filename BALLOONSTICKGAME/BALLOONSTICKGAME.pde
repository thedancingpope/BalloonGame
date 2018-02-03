/* Current Info: We're looking at adding several new features to the game, in order to move it closer to completion.
 With the main body of the game's code now finished, the remaining changes are mostly cosmetic, and in keeping with
 certain visual themes and patterns already established. Here are some changes we're floating around:
 -Stratosphere animation:
 -Extended background.
 -Balloon popping animation.
 -Music
 -Balloon hitting ground (animation).
 
 Sincerely,  
 TheDancingPope
 

 @TheDancingPope
 @MeeeMooo
 */
int balX, phase; 

boolean leftTrue, rightTrue, reset;

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
    if (phase == 0)
      phase = 1;

  if (key == 'p' || key == 'P')
    phase = 3;

  if (key == 'l' || key == 'L')
    phase = 5;
}
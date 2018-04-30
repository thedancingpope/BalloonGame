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
int phase; 
PVector balPos;
boolean leftTrue, rightTrue, reset;
PFont font;
GamePhases Phases;

void setup()
{
  size(500, 500, P3D);
  frameRate(25);
  font = loadFont("ArialRoundedMTBold-36.vlw");
  textFont(font);
  textureMode(NORMAL);   
  textSize(20);
  stroke(0);
  Phases = new GamePhases();
}

void draw()
{
  Phases.RunPhases();
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
  if(phase != 1)
  {  
    if(key == 'a' || key == 'A') 
      leftTrue = false;
    else if(key == 'd' || key == 'D') 
      rightTrue = false;
  }
  if(key == 'r' || key == 'R')
    reset = false;
    
  if(phase == 0)
    if(key == 'q' || key == 'Q')    
      Phases.setPhase1();

  if(key == '3')
    Phases.debugPhase(3);
  else if(key == '4')
    Phases.debugPhase(4);   
  else if(key == '5')
    Phases.debugPhase(5);
  else if(key == '6')
    Phases.debugPhase(6);
}

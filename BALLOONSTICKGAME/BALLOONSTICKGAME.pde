/*Current Info: We're looking at adding several new features to the game, in order to move it closer to completion.
 With the main body of the game's code now finished, the remaining changes are mostly cosmetic, and in keeping with
 certain visual themes and patterns already established. Here are some changes we're floating around:
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
boolean leftTrue, rightTrue, isCaught, gotPowerUp, reset, shift;
boolean [] gameLayers;
PFont font;
PGraphics gameScene;
GamePhases Phases;
LayerToggle Layers;

void setup()
{
  //size(displayWidth, displayHeight, P3D); //when using a phone
  size(500, 500, P3D);
  frameRate(25);
  font = loadFont("SitkaText-Bold-48.vlw");
  textFont(font);
  textureMode(NORMAL);   
  textSize(20);
  stroke(0);
  Phases = new GamePhases();
  Layers = new LayerToggle();
}

void draw()
{
  Phases.RunPhases();
  if(Layers.debugLayers)
    Layers.render();
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
  if(keyCode == SHIFT)
    shift = true;
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
    
  if(keyCode == SHIFT)
    shift = false;
  if(shift && (key == 'l' || key == 'L'))
    Layers.toggleDebug();
  
  if(Layers.debugLayers && !shift)
  {
    if(key == 'b' || key == 'B')
      gameLayers[0] = !gameLayers[0];
    if(key == 'u' || key == 'U')
      gameLayers[1] = !gameLayers[1];
    if(key == 'p' || key == 'P')
      gameLayers[2] = !gameLayers[2];
    if(key == 'e' || key == 'E')
      gameLayers[3] = !gameLayers[3];
    if(key == 'f' || key == 'F')
      gameLayers[4] = !gameLayers[4];
    if(key == 'w' || key == 'W')
      gameLayers[5] = !gameLayers[5];
    if(key == 's' || key == 'S')
      gameLayers[6] = !gameLayers[6];
    if(key == 'l' || key == 'L')
      gameLayers[7] = !gameLayers[7];
    if(key == 'c' || key == 'C')
      gameLayers[8] = !gameLayers[8];
    if(key == 't' || key == 'T')
      gameLayers[9] = !gameLayers[9];
    if(key == '2')
      Phases.debugPhase(2);
    if(key == '3')
      Phases.debugPhase(3);
    if(key == '4')
      Phases.debugPhase(4);   
    if(key == '5')
      Phases.debugPhase(5);
    if(key == '6')
      Phases.debugPhase(6);
  }
}

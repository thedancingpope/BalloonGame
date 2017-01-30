class BalloonString
{
  float gravity = 9.0;
  float mass = 2.0;
  
  void stringSetup(){
    
    }

  void drawBalloonString() 
    {      
    s1.update(lineX, lineY);
    s1.display(lineX, lineY);
    s2.update(s1.x, s1.y);
    s2.display(s1.x, s1.y);
    s3.update(s2.x, s2.y);
    s3.display(s2.x, s2.y);
    s4.update(s3.x, s3.y);
    s4.display(s3.x, s3.y);
    s5.update(s4.x, s4.y);
    s5.display(s4.x, s4.y);
    s6.update(s5.x, s5.y);
    s6.display(s5.x, s5.y);
   }
 }
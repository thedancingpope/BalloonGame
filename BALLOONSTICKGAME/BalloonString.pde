class BalloonString
  {  
     void stringSetup()
       {  }
  
     void drawBalloonString() 
       {      
          s1.update(lineX, lineY);
          s1.display(lineX, lineY);
          s2.update(s1.springX, s1.springY);
          s2.display(s1.springX, s1.springY);
          s3.update(s2.springX, s2.springY);
          s3.display(s2.springX, s2.springY);
          s4.update(s3.springX, s3.springY);
          s4.display(s3.springX, s3.springY);
       }
   }
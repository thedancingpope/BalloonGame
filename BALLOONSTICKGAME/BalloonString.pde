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
        s5.update(s4.springX, s4.springY);
        s5.display(s4.springX, s4.springY);
        s6.update(s5.springX, s5.springY);
        s6.display(s5.springX, s5.springY);
     }
   }
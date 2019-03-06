/******************************************************************************
Draw your initials here in perspective.
******************************************************************************/

void persp_initials()
{
  gtInitialize();
  
  gtPerspective (60, 10, 10000);
  gtPushMatrix();
 
  gtTranslate (-2,0,-6);
  gtRotateX(-15);
  gtRotateY(45);
  q();
  gtPopMatrix();
  gtPushMatrix();
 
  gtTranslate (0,-0,-6);
  gtRotateX(15);
  gtRotateY(45);
  gtScale(1,1,1);
  t();
  gtPopMatrix();
}
void q() {
  gtBeginShape();
  
  gtVertex(1,1,1);
  gtVertex(1,-1,1);
  
  gtVertex(1,1,1);
  gtVertex(-1,1,1);
  
  gtVertex(1,-1,1);
  gtVertex(-1,-1,1);
  
  gtVertex(-1,-1,1);
  gtVertex(-1,1,1);
  
  gtVertex(0.5,-0.5,1);
  gtVertex(1.5,-1.5,1);
  
  gtEndShape();
  }
void t() {
  gtBeginShape();
  gtVertex(-1,1,1);
  gtVertex(1,1,1);
  
  gtVertex(0,1,1);
  gtVertex(0,-1,1);
  gtEndShape();
  }

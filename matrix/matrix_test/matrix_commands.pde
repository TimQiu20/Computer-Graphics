// Matrix Stack Library

// You should modify the routines below to complete the assignment.
// Feel free to define any classes, global variables, and helper routines that you need.

import java.util.*;

class gtMatrix {
  float[][] matrix;
  gtMatrix() {matrix = new float[4][4];}
}
int size=0;
Stack<gtMatrix> matrixStack = new Stack<gtMatrix>();
gtMatrix CTM;

void gtInitialize()
{
  float m[][] = {{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}};
  gtMatrix gt = new gtMatrix();
  gt.matrix = m;
  matrixStack.add(gt);
  CTM = gt;
  size=1;
}

float[][] newCTM(float[][] oldCTM, float[][] transfomation){
  float[][] newCTM = new float[4][4];
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 4; j++){
      for(int k = 0; k < 4; k++){
        newCTM[i][j] += oldCTM[i][k] * transfomation[k][j];
      }
    }
  }
  return newCTM;
}

void gtPushMatrix()
{
  gtMatrix copy = new gtMatrix();
  for (int i = 0; i <=3; i++) {
    for(int j = 0; j<=3; j++) {
      copy.matrix[i][j] = matrixStack.peek().matrix[i][j];
    }
  }
  matrixStack.push(copy);
  CTM=copy;
  size++;
}

void gtPopMatrix()
{
  if(size == 1) {
    System.out.println("cannot pop the matrix stack");
  } else {
    matrixStack.pop();
    CTM = matrixStack.peek();
    size--;
  }
}

void gtTranslate(float x, float y, float z)
{
  gtMatrix transMatrix = new gtMatrix();
  float [][]trans = {{1,0,0,x},{0,1,0,y},{0,0,1,z},{0,0,0,1}};
  transMatrix.matrix = trans;
  CTM.matrix = newCTM(CTM.matrix,transMatrix.matrix);
}

void gtScale(float x, float y, float z)
{
  gtMatrix transMatrix = new gtMatrix();
  float [][]trans = {{x,0,0,0},{0,y,0,0},{0,0,z,0},{0,0,0,1}};
  transMatrix.matrix = trans;
  CTM.matrix = newCTM(CTM.matrix,transMatrix.matrix);

}

void gtRotateX(float theta)
{
  gtMatrix transMatrix = new gtMatrix();
  float ang = radians(theta);
  float [][]trans = {{1,0,0,0},{0,cos(ang),-sin(ang),0},{0,sin(ang),cos(ang),0},{0,0,0,1}};
  transMatrix.matrix = trans;
  CTM.matrix = newCTM(CTM.matrix,transMatrix.matrix);
}

void gtRotateY(float theta)
{
  gtMatrix transMatrix = new gtMatrix();
  float ang = radians(theta);
  float [][]trans = {{cos(ang),0,sin(ang),0},{0,1,0,0},{-sin(ang),0,cos(ang),0},{0,0,0,1}};
  transMatrix.matrix = trans;
  CTM.matrix = newCTM(CTM.matrix,transMatrix.matrix);
}

void gtRotateZ(float theta)
{
  gtMatrix transMatrix = new gtMatrix();
  float ang = radians(theta);
  float [][]trans = {{cos(ang),-sin(ang),0,0},{sin(ang),cos(ang),0,0},{0,0,1,0},{0,0,0,1}};
  transMatrix.matrix = trans;
  CTM.matrix = newCTM(CTM.matrix,transMatrix.matrix);
}

void print_ctm()
{
 for (int i = 0; i <= 3; i ++) {
   System.out.println(Arrays.toString(CTM.matrix[i]));
 }
 println();
}

// Dummy routines for OpenGL commands.
// These are for you to write!
// You should incorporate your matrix stack routines from part A of this project.


import java.util.*;

class gtMatrix {
  float[][] matrix;
  gtMatrix() {matrix = new float[4][4];}
}

class gtVertex {
  float[] vertex;
  gtVertex(){vertex = new float[4];}
}
class gtVector {
  float[] vector;
  gtVector(){vector = new float[3];}
}
int size=0;
Stack<gtMatrix> matrixStack = new Stack<gtMatrix>();
gtMatrix CTM;
gtVertex firstVertex;
gtVertex secondVertex;
int vertexCount = 0;
boolean shape = false;

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

float pfov = 0;
float pnear = 0;
float pfar = 0;
float oleft = 0;
float oright = 0;
float obottom = 0;
float otop = 0;
float onear = 0;
float ofar = 0;
boolean isPerspective = false;
boolean isOrtho = false;
void gtPerspective(float f, float near, float far)
{
  isPerspective = true;
  isOrtho = false;
  pfov = f;
  pnear = near;
  pfar = 0;
}

void gtOrtho(float l, float r, float b, float t, float n, float f)
{
  isPerspective = false;
  isOrtho = true;
  oleft = l;
  oright = r;
  obottom = b;
  otop = t;
  onear = n;
  ofar = f;
}

void gtBeginShape()
{
  shape = true;
}

void gtVertex(float x, float y, float z)
{
  if (vertexCount == 0) {
    firstVertex = new gtVertex();
    firstVertex.vertex[0] = x;
    firstVertex.vertex[1] = y;
    firstVertex.vertex[2] = z;
    firstVertex.vertex[3] = 0;
    vertexCount++;
  } else {
    secondVertex = new gtVertex();
    secondVertex.vertex[0] = x;
    secondVertex.vertex[1] = y;
    secondVertex.vertex[2] = z;
    secondVertex.vertex[3] = 0;
    vertexCount = 0;
    
    gtVector a = new gtVector();
    a.vector[0] = 0;
    a.vector[1] = 0;
    a.vector[2] = 0;
    gtVector b = new gtVector();
    b.vector[0] = 0;
    b.vector[1] = 0;
    b.vector[2] = 0;
    
    for(int i = 0; i < 3; i++) {
      for(int j = 0; j < 4; j++){
        if (j == 3){
          a.vector[i] += CTM.matrix[i][j];
        }
        else{
          a.vector[i] += CTM.matrix[i][j] * firstVertex.vertex[j];
        }
      }
    }
    
    for(int i = 0; i < 3; i++) {
      for(int j = 0; j < 4; j++){
        if (j == 3){
          b.vector[i] += CTM.matrix[i][j];
        }
        else{
          b.vector[i] += CTM.matrix[i][j] * secondVertex.vertex[j];
        }
      }
    }
    firstVertex = new gtVertex();
    secondVertex = new gtVertex();
    
    if (isPerspective == false) {
      float p1x = float(width) / (oright - oleft) * (a.vector[0] - oleft);
      float p2x = float(width) / (oright - oleft) * (b.vector[0] - oleft);
      float p1y = float(height) / (obottom - otop) * (a.vector[1] - otop);
      float p2y = float(height) / (obottom - otop) * (b.vector[1] - otop);
      line(p1x,p1y,p2x,p2y);
    } else {
      float tan = tan(radians(pfov / 2));
      float p1x = (float(width) / (2*tan)) * (a.vector[0] / Math.abs(a.vector[2]) + tan);
      float p2x = (float(width) / (2*tan)) * (b.vector[0] / Math.abs(b.vector[2]) + tan);
      float p1y = (float(height) / (2*tan)) * (a.vector[1] / -Math.abs(a.vector[2]) + tan);
      float p2y = (float(height) / (2*tan)) * (b.vector[1] / -Math.abs(b.vector[2]) + tan);
      line(p1x,p1y,p2x,p2y);
    }
  }
}

void gtEndShape()
{
  shape = false;
}

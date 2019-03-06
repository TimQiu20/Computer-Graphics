// 3D Scene Example

float time = 0;  // keep track of passing of time

void setup() {
  size(800, 800, P3D);  // must use 3D here !!!
  noStroke();           // do not draw the edges of polygons
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(0);  // clear the screen to black

  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);

  // place the camera in the scene (just like gluLookAt())
  camera (0.0, 0.0, 85.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
  // create an ambient light source
  ambientLight (102, 102, 102);

  // create two directional light sources
  lightSpecular (204, 204, 204);
  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (152, 152, 152, 0, 0, -1);


  // Draw a box

  pushMatrix();

  fill (100, 100, 200);
  ambient (100, 100, 200);
  specular (0, 0, 0);
  shininess (1.0);

  translate (0, 0, 0);
  rotate (-time, 1.0, 0.0, 0.0);      // rotate based on "time"
  beginShape(TRIANGLE);
  vertex(-20,0,-5);
  vertex(20,0,-5);
  vertex(0,30,-5);
  endShape();
  beginShape(TRIANGLE);
  vertex(-20,0,5);
  vertex(20,0,5);
  vertex(0,30,5);
  endShape();
  
  beginShape(QUADS);
  vertex(-20,0,-5);
  vertex(-20,0,5);
  vertex(20,0,5);
  vertex(20,0,-5);
  endShape();

  popMatrix();

  // step forward in time
  time += 0.03;
}

float time = 0;  // keep track of passing of time
float time1 = 0;
//instance tree
void setup() {
  size(800, 800, P3D);  // must use 3D here !!!
  noStroke();           // do not draw the edges of polygons
  rectMode(CENTER);
}

void draw() {
  resetMatrix();
  
  background(150,150,150);
  camera (100, -100, 350 , 0, 0, -1.0, 0.0, 1.0, 0.0);
  if(time1>=0 && time1 <=150){
    camera (100+(time1/150 * 75), -100+(time1/150 *80), 350-(time1/150*50) , 0, 0, -1.0, 0.0, 1.0, 0.0);
  }
  if(time1>150){
    camera (175, -20, 300 , 0, 0, -1.0, 0.0, 1.0, 0.0);
  }
  if(time1 >300 && time1 <=450){
    camera(175, -20 , 300 +(time1-300)/150 * 200, 0, 0, -1.0, 0.0, 1.0, 0.0);
  }
  if(time1 > 450) {
    camera(175, -20 , 500, 0, 0, -1.0, 0.0, 1.0, 0.0);
  }
  if(time1 > 600 && time1 <=800) {
    camera(175, -20 , 500, time1-600, 0, -1.0, 0.0, 1.0, 0.0);
  }
  if(time1 > 800) {
   camera(175, -20 , 500, 200, 0, -1.0, 0.0, 1.0, 0.0);
  }
  println(time1);
  ambientLight (50, 50, 50);

  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (130, 130, 130, 0, 0, -1);
  
  //Light source
  pointLight(255, 255, 255, 0, -200, -400);
  
  //set sun
  pushMatrix();
  translate(0,-250,-400);
  scale(1,1,1);
  sun();
  popMatrix();
  
  //set tree
  for(int i = -10; i !=10;i++){
    pushMatrix();
    scale(.3,.3,.3);
    translate(150*i,0,-200);
    tree();
    popMatrix();
  }
  
  //set house()
  pushMatrix();
  translate(0,10,100);
  scale(3,3,3);
  house();
  pushMatrix();
  scale(0.15,.15,.15);
  translate(0,12.5,166.5);
  door();
  popMatrix();
  popMatrix();
  
  //set dogHouse()
  pushMatrix();
  translate(100,10,100);
  dogHouse();
  pushMatrix();
  scale(.3,.3,.3);
  translate(0,0,250);
  rotateY(-PI/2);
  if (time1 >150 && time1<=300) {
    float y = -Math.abs(25 * sin(time1/4));
    translate(0,y,0);
  }
  if(time1 >300 && time1 <=450){
    float y = -Math.abs(25*sin(time1/4));
    float x = (time1 - 300) / 150 * 300;
    translate(x,y,0);
  }
  if(time1 > 450 && time1 <= 600) {
    translate(300,0,0);
    rotateY(((time1-450)/150)*(PI/2));
  }
  if (time1 > 600 && time1 <= 1200){
    translate(300,0,0);
    rotateY(PI/2);
  }
  if (time1 > 1200){
    translate(300,0,0);
    rotateY(PI/2);
    float y = -Math.abs(25 * sin(time1/4));
    translate(0,y,0);
  }
  dog();
  popMatrix();
  popMatrix();
  
  //set people
  pushMatrix();
  translate(100,10,100);
  scale(.3,.3,.3);
  translate(0,0,250);
  rotateY(-PI/2);
  translate(300,0,0);
  rotateY(PI/2);
  translate(0,-50,0);
  translate(600,0,0);
  if(time1>800 && time1<=950){
    rotateY(((time1-800)/150)*(-PI/2));
  }
  if(time1>950 && time1 <=1200){
    rotateY(-PI/2);
    float x = (time1-950)/250 * 450;
    translate(0,0,x);
  }
  if (time1 > 1200){
    rotateY(-PI/2);
    translate(0,0,450);
  }
  people();
  popMatrix();
  
  time += 0.0001;
  time1++;
}

void house(){
  fill(255,255,153);
  box(30,20,50);
}
void people(){
  fill(218,165,32);
  ambient(120);
  specular(1);
  pushMatrix();
  sphere(20);
  popMatrix();
  
  pushMatrix();
  translate(0,20,0);
  cylinder(20,50,50);
  
  pushMatrix();
  translate(15,10,0);
  rotateZ(-PI/4);
  cylinder(5,30,300);
  popMatrix();
  
  pushMatrix();
  translate(-15,10,0);
  rotateZ(PI/4);
  cylinder(5,30,300);
  popMatrix();
  
  pushMatrix();
  translate(-8,50,0);
  cylinder(5,30,300);
  popMatrix();
  
  pushMatrix();
  translate(8,50,0);
  cylinder(5,30,300);
  popMatrix();
  popMatrix();
}
void dog(){
  fill(205,133,63);
  //rotate (time, 0, -1.0, 0.0);      // rotate based on "time"
  rotate(PI/2,0,0,-1);
  cylinder(20,75,50);
  pushMatrix();
  translate(-14.14213562,20,11.14213562);
  rotate(PI/2,0,0,1);
  cylinder(3,40,50);
  popMatrix();
  pushMatrix();
  translate(-14.14213562,20,-11.14213562);
  rotate(PI/2,0,0,1);
  cylinder(3,40,50);
  popMatrix();
  pushMatrix();
  translate(-14.14213562,55,-11.14213562);
  rotate(PI/2,0,0,1);
  cylinder(3,40,50);
  popMatrix();
  pushMatrix();
  translate(-14.14213562,55,11.14213562);
  rotate(PI/2,0,0,1);
  cylinder(3,40,50);
  popMatrix();
  pushMatrix();
  translate(0,80,0);
  box(40,40,60);
  
  //ear1
  pushMatrix();
  translate(20,0,-15);
  rotate(PI/2,0,0,0);
  beginShape(TRIANGLE);
  vertex(25,-2,0);
  vertex(0,-2,10);
  vertex(0,-2,-10);
  endShape();
  beginShape(TRIANGLE);
  vertex(25,2,0);
  vertex(0,2,10);
  vertex(0,2,-10);
  endShape();
  beginShape(QUADS);
  vertex(25,-2,0);
  vertex(25,2,0);
  vertex(0,2,10);
  vertex(0,-2,10);
  endShape();
  beginShape(QUADS);
  vertex(25,-2,0);
  vertex(25,2,0);
  vertex(0,2,-10);
  vertex(0,-2,-10);
  endShape();
  popMatrix();
  //ear2
  pushMatrix();
  translate(20,0,15);
  rotate(PI/2,0,0,0);
  beginShape(TRIANGLE);
  vertex(25,-2,0);
  vertex(0,-2,10);
  vertex(0,-2,-10);
  endShape();
  beginShape(TRIANGLE);
  vertex(25,2,0);
  vertex(0,2,10);
  vertex(0,2,-10);
  endShape();
  beginShape(QUADS);
  vertex(25,-2,0);
  vertex(25,2,0);
  vertex(0,2,10);
  vertex(0,-2,10);
  endShape();
  beginShape(QUADS);
  vertex(25,-2,0);
  vertex(25,2,0);
  vertex(0,2,-10);
  vertex(0,-2,-10);
  endShape();
  popMatrix();
  popMatrix();
}
void sun(){
  fill(220,20,60);
  ambient(255,215,0);
  specular(30);
  sphere(50);
}

void tree(){
  fill(139,69,19);
  cylinder(20,100,100);
  pushMatrix();
  translate(0,-30,0);
  fill(0,128,0);
  sphere(50);
  popMatrix();
}
void dogHouse(){
  fill(210,105,30);
  ambient(139,69,19);
  specular(20);
  shininess(1);
  box(35,30,45);
  
  pushMatrix();
  fill(0);
  ambient(10);
  specular(5);
  shininess(1);
  translate(0,5,22.5);
  box(10,20,0.01);
  popMatrix();
  
  pushMatrix();
  fill(0);
  ambient(10);
  shininess(1);
  translate(0,-4.5,22.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  halfCylinder(5,0.01,50);
  popMatrix();
  
  pushMatrix();
  fill(32,178,170);
  translate(0,-15,0);
  rotate(PI,1,0,0);
  triangular_prism_roof(35,20,45);
  popMatrix();
  
  pushMatrix();
  fill(192,192,192);
  ambient(210);
  specular(20);
  shininess(1);
  translate(0,-15,22.6);
  ellipse(0, 0, 10, 5);
  popMatrix();
}
void door(){
  fill(139,69,19);
  ambient(50);
  specular(50,50,50);
  shininess(1);
  box(45,110,3);
  
  // set up the first handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,1.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  cylinder (2.5, 1.0, 50);
  popMatrix();
  

  // set up the later handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,2.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  cylinder (0.8, 1.5, 50);
  // finish the later handle
  popMatrix();
  
  //set up the sphere handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,5.8);
  scale(2,2,2);
  sphere(0.9);
  // finish the sphere handle
  popMatrix();
  
  
  // set up the second handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,-2.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  cylinder (2.5, 1.0, 50);
  // finish the handle
  popMatrix();
  
  //set up the sphere handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,-2.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  cylinder (2.5, 1.0, 50);
  // finish the sphere handle
  popMatrix();
  
  // set up the later handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,-2.5);
  rotate (PI * 3/2, 1.0, 0.0, 0.0);
  cylinder (0.8, 1.5, 50);
  // finish the later handle
  popMatrix();
  
  //set up the sphere handle
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,0.0,-5.8);
  scale(2,2,2);
  sphere(0.9);
  // finish the sphere handle
  popMatrix();
  
  // set up the lock
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,-5.0,1.5);
  rotate (PI/2, 1.0, 0.0, 0.0);
  cylinder (1.5, 1.0, 50);
  // finish the lock
  popMatrix();
  
  // set up the lock
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,-5.0,2.5);
  scale(1.5,0.5,1);
  halfCylinder(1,1,50);
  popMatrix();
  
  // set up the lock
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-18.5,-5.0,-1.5);
  rotate (PI*3/2, 1.0, 0.0, 0.0);
  cylinder (1.5, 1.0, 50);
  popMatrix();
  
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(-22.5,-3,0);
  box(0.05,10,2);
  popMatrix();
  
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(22.5,30,0);
  box(0.05,10,2);
  popMatrix();
  
  pushMatrix();
  fill(192,192,192);
  ambient(100);
  specular(0);
  shininess(1);
  translate(22.5,-30,0);
  box(0.05,10,2);
  popMatrix();
  
  
}
  
  
void triangular_prism_roof(float Width, float Height, float Thickness){
  fill(210,105,30);
  ambient(139,69,19);
  specular(20);
  shininess(1);
  
  beginShape(TRIANGLE);
  vertex(-Width/2,0,-Thickness/2);
  vertex(Width/2,0,-Thickness/2);
  vertex(0,Height,-Thickness/2);
  endShape();
  
  fill(64,224,208);
  ambient(32,178,170);
  specular(50);
  shininess(1.5);
  
  beginShape(TRIANGLE);
  vertex(-Width/2,0,Thickness/2);
  vertex(Width/2,0,Thickness/2);
  vertex(0,Height,Thickness/2);
  endShape();
  
  beginShape(QUADS);
  vertex(-Width/2,0,-Thickness/2);
  vertex(-Width/2,0,Thickness/2);
  vertex(0,Height,Thickness/2);
  vertex(0,Height,-Thickness/2);
  endShape();
  
  beginShape(QUADS);
  vertex(Width/2,0,-Thickness/2);
  vertex(Width/2,0,Thickness/2);
  vertex(0,Height,Thickness/2);
  vertex(0,Height,-Thickness/2);
  endShape();
}
// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}
  
  // Draw a half cylinder of a given radius, height and number of sides.
  // The base is on the y=0 plane, and it extends vertically in the y direction.
void halfCylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}

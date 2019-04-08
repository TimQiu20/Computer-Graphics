// This is the starter code for the CS 3451 Ray Tracing project.
//
// The most important part of this code is the interpreter, which will
// help you parse the scene description (.cli) files.

//global variable
import java.util.*;
  
  float fov;
  int backgroundColor = color(0, 0, 0);
  float[] eye = new float [3];
  float[] uvw = new float [9];
  List<Light> lightList = new ArrayList<Light>();
  float[] surface = new float[11];
  List<Shape> shapeList = new ArrayList<Shape>();
  float[] cone = new float [5];
  Surface currentSurface ;
void setup() {
  size(400, 400);  
  noStroke();
  colorMode(RGB,1.0);
  background(0, 0, 0);
}

void reset_scene() {
  fov = 0;
  eye = new float [3];
  backgroundColor = color(0, 0, 0);
  uvw = new float [9];
  lightList = new ArrayList<Light>();
  surface = new float[11];
  shapeList = new ArrayList<Shape>();
  currentSurface = new Surface(0,0,0,0,0,0,0,0,0,0,0);
}

void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  interpreter("01_one_sphere.cli"); break;
    case '2':  interpreter("02_three_spheres.cli"); break;
    case '3':  interpreter("03_shiny_sphere.cli"); break;
    case '4':  interpreter("04_one_cone.cli"); break;
    case '5':  interpreter("05_more_cones.cli"); break;
    case '6':  interpreter("06_ice_cream.cli"); break;
    case '7':  interpreter("07_colorful_lights.cli"); break;
    case '8':  interpreter("08_reflective_sphere.cli"); break;
    case '9':  interpreter("09_mirror_spheres.cli"); break;
    case '0':  interpreter("10_reflections_in_reflections.cli"); break;
    case 'q':  exit(); break;
  }
}


// this routine helps parse the text in a scene description file
void interpreter(String filename) {
  
  println("Parsing '" + filename + "'");
  String str[] = loadStrings(filename);
  if (str == null) println("Error! Failed to read the file.");
  
  for (int i = 0; i < str.length; i++) {
    
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov")) {
      fov = float(token[1]);
      // call routine to save the field of view
    }
    else if (token[0].equals("background")) {
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      backgroundColor = color(r, g, b);
      // call routine to save the background color
    }
    else if (token[0].equals("eye")) {
      //float x = float(token[1]);
      eye[0] = float(token[1]);
      //float y = float(token[2]);
      eye[1] = float(token[2]);
      //float z = float(token[3]);
      eye[2] = float(token[3]);
      // call routine to save the eye position
    }
    else if (token[0].equals("uvw")) {
      //float ux = float(token[1]);
      uvw[0] = float(token[1]);
      //float uy = float(token[2]);
      uvw[1] = float(token[2]);
      //float uz = float(token[3]);
      uvw[2] = float(token[3]);
      //float vx = float(token[4]);
      uvw[3] = float(token[4]);
      //float vy = float(token[5]);
      uvw[4] = float(token[5]);
      //float vz = float(token[6]);
      uvw[5] = float(token[6]);
      //float wx = float(token[7]);
      uvw[6] = float(token[7]);
      //float wy = float(token[8]);
      uvw[7] = float(token[8]);
      //float wz = float(token[9]);
      uvw[8] = float(token[9]);
      // call routine to save the camera u,v,w
    }
    else if (token[0].equals("light")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      Light light = new Light(x,y,z,r,g,b);
      lightList.add(light);
      // call routine to save light information
    }
    else if (token[0].equals("surface")) {
      float Cdr = float(token[1]);
      float Cdg = float(token[2]);
      float Cdb = float(token[3]);
      float Car = float(token[4]);
      float Cag = float(token[5]);
      float Cab = float(token[6]);
      float Csr = float(token[7]);
      float Csg = float(token[8]);
      float Csb = float(token[9]);
      float P = float(token[10]);
      float K = float(token[11]);
      Surface surface = new Surface(Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K);
      currentSurface = surface;
      // call routine to save surface materials
    }    
    else if (token[0].equals("sphere")) {
      float r = float(token[1]);
      float x = float(token[2]);
      float y = float(token[3]);
      float z = float(token[4]);
      // call routine to save sphere
      Shape s = new Sphere(r,x,y,z,currentSurface);
      shapeList.add(s);

    }
    else if (token[0].equals("cone")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float h = float(token[4]);
      float k = float(token[5]);
      // call routine to save cone
      Shape c = new Cone(x,y,z,h,k,currentSurface);
      shapeList.add(c);
    }
    else if (token[0].equals("write")) {
      draw_scene();   // this is where you actually perform the ray tracing
      println("Saving image to '" + token[1] + "'");
      save(token[1]); // this saves your ray traced scene to a PNG file
    }
    else if (token[0].equals("#")) {
      // comment symbol
    }
    else {
      println ("cannot parse line: " + str[i]);
    }
  }
}

// This is where you should put your code for creating eye rays and tracing them.
void draw_scene() {
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      float d = 1.0/tan(radians(fov/2.0));
      float u = -1.0 + ((2.0*(float)x)/(float)width);
      float v = -1.0 + ((2.0*(float)y)/(float)height);
      PVector uu = new PVector(u*uvw[0],u*uvw[1],u*uvw[2]);
      PVector vv = new PVector(v*uvw[3],v*uvw[4],v*uvw[5]);
      PVector dw = new PVector(d*uvw[6],d*uvw[7],d*uvw[8]);
      dw = dw.mult(-1);
      PVector origin = new PVector(eye[0],eye[1],eye[2]);
      PVector pixelPos = dw.add(uu);
      pixelPos = pixelPos.add(vv);
      PVector direction = pixelPos;
      direction.y = -direction.y;
      Ray eyeray = new Ray(origin,direction.normalize());
      Hit hit =  eyeray.cast(shapeList); 
      if (hit != null) {
        hit.calColor(eyeray, backgroundColor, lightList, shapeList, 0);
        fill(hit.c);
      }
      else {fill(backgroundColor);}
      rect(x,y,1,1);
    }
  }
}

void draw() {
  // nothing should be placed here for this project!
}

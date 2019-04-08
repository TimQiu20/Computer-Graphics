public class Hit
{
  public float t;
  public PVector hitP;
  public Shape shape;
  public int c;
  
  public Hit(PVector hitP, Shape shape, float t)
  {
    this.hitP = hitP;
    this.shape = shape;
    this.t = t;
    this.c = color(1, 1, 1); 
  }
  
  public void calColor(Ray ray, int bg, List<Light> lightList,List<Shape> shapeList, int depth) 
  {
    PVector n = null;
    if (shape instanceof Sphere) {
      PVector sphCenter = new PVector(shape.x,shape.y,shape.z);
      n = PVector.sub(this.hitP, sphCenter);
      n = n.normalize();
    } else {
      n = ((Cone)shape).normal;
      n = n.normalize();
     }
     //Surface surface = this.shape.surface;
     //float rT = 0;
     //float gT = 0;
     //float bT = 0;
     //rT += surface.Car;
     //gT += surface.Cag;
     //bT += surface.Cab;
     //for (Light light : lightList) 
     //{
     //  float lightx = light.x;
     //  float lighty = light.y;
     //  float lightz = light.z;
     //  float lightr = light.r;
     //  float lightg = light.g;
     //  float lightb = light.b;
     //  Ray lightRay = new Ray(hitP, new PVector(lightx - hitP.x, lighty - hitP.y, lightz - hitP.z));
     //  boolean shadow = false;
     //  Hit p = lightRay.cast(shapeList);
     //  if (p != null) 
     //  {
     //    float d1 = dist(hitP.x,hitP.y,hitP.z,light.x,light.y,light.z);
     //    float d2 = dist(hitP.x,hitP.y,hitP.z,p.hitP.x,p.hitP.y,p.hitP.z);
     //    if (d1 > d2) {shadow = true;}
     //  }
     //  if (shadow) {
     //    lightr = 0;
     //    lightg = 0;
     //    lightb = 0;
     //  }
     //  //PVector L = new PVector(light.x - hitP.x, light.y - hitP.y, light.z - hitP.z);
       //L = L.normalize();
       //PVector V = new PVector(-hitP.x,-hitP.y,-hitP.z);
       //V = V.normalize();
       //PVector H = PVector.add(L,V);
       //H = H.normalize();  
       //float NdotL = PVector.dot(n,L);
       //NdotL = Math.max(0,NdotL);
       //float NdotH = PVector.dot(n,H);
       //float phong = (float)Math.pow(NdotH,surface.P);
       //float r = surface.Cdr * lightr * NdotL;
       //r += surface.Csr * lightr * max(0, phong);
       //float g = surface.Cdg * lightg * NdotL;
       //g += surface.Csg * lightg * max(0, phong);
       //float b = surface.Cdb * lightb * NdotL;
       //b += surface.Csb * lightb * max(0, phong);
     //  PVector e = ray.o;
     //  e = e.normalize();
     //  PVector l = new PVector(light.x - this.hitP.x, light.y - this.hitP.y, light.z - this.hitP.z);
     //  l = l.normalize();
     //  PVector eAddl = PVector.div(PVector.add(e,l),PVector.add(e,l).mag());
     //  PVector h = eAddl.normalize();
     //  float NL = PVector.dot(n,l);
     //  NL = (float)Math.max(0,NL);
     //  float phong = (float)Math.pow(PVector.dot(h,n), surface.P);
     //  float r = surface.Cdr * lightr * NL;
     //  r += surface.Csr * lightr * phong;
     //  float g = surface.Cdg * lightg * NL;
     //  g += surface.Csg * lightg * phong;
     //  float b = surface.Cdb * lightb * NL;
     //  b += surface.Csb * lightb * phong;
     //  rT += r;
     //  gT += g;
     //  bT += b;
     //}
     //PVector eAddl = PVector.div(PVector.add(e,l), PVector.add(e,l).mag());
     //PVector h = eAddl.normalize();
     //float NL = PVector.dot(n,l);
     //NL = (float)Math.max(0,NL);
     //float phong = (float)Math.pow(PVector.dot(h,n), surface.P);
     //}
    Surface surface = this.shape.surface;
    float rT = surface.Car;
    float gT = surface.Cag;
    float bT = surface.Cab;
    PVector e = ray.o;
    e = e.normalize();
    for(Light light: lightList)
    {
      PVector lightSource = new PVector(light.x,light.y,light.z);
      PVector l = PVector.sub(lightSource,this.hitP);
      l = l.normalize();
      PVector offset = PVector.mult(l,0.001);
      Ray lightRay = new Ray(PVector.add(this.hitP,offset),l);
      float tt;
      float expectedX = Math.abs(light.x - this.hitP.x);
      float expectedY = Math.abs(light.y - this.hitP.y);
      float expectedZ = Math.abs(light.z - this.hitP.z);
      if (expectedX > 0.0001) {tt = (light.x - this.hitP.x) / lightRay.direction.x;}
      else if (expectedY > 0.0001) {tt = (light.y - this.hitP.y) / lightRay.direction.y;}
      else if (expectedZ > 0.0001) {tt = (light.z - this.hitP.z) / lightRay.direction.z;}
      else{tt = 0;}
      float s = 1;
      Hit lightHit = lightRay.cast(shapeList);
      if (lightHit != null)
      {
        float ttt = lightHit.t;
        float offset1 = 0.0001;
        if (ttt + offset1 < tt) {s = 0;}
      }
      PVector eAddl = PVector.add(e,l);
      PVector h = eAddl.normalize();
      float NL = PVector.dot(n,l);
      NL = (float)Math.max(0,NL);
      float phong = (float)Math.pow(PVector.dot(h,n), surface.P);
      float r = surface.Cdr * light.r * NL * s;
      r += surface.Csr * light.r * s * phong;
      float g = surface.Cdg * light.g * NL * s;
      g += surface.Csg * light.g * s * phong;
      float b = surface.Cdb * light.b * NL * s;
      b += surface.Csb * light.b * s * phong;
      rT += r;
      gT += g;
      bT += b;
    }
    
   float refl = shape.surface.K;
   if (refl > 0 && depth < 15) 
   {
     PVector reflVector = PVector.sub(ray.direction, PVector.mult(n, 2 * PVector.dot(ray.direction,n)));
     reflVector = reflVector.normalize();
     PVector offset = PVector.mult(reflVector,0.001);
     Ray reflRay = new Ray(PVector.add(this.hitP,offset), reflVector);
     int rColor = bg;
     Hit rHit = reflRay.cast(shapeList);
     if (rHit != null) {
       rHit.calColor(reflRay, bg, lightList,shapeList,depth+1);
       rColor = rHit.c;
     }
     rT += refl * red(rColor);
     gT += refl * green(rColor);
     bT += refl * blue(rColor); 
   }
   rT = Math.min(rT,1);
   gT = Math.min(gT,1);
   bT = Math.min(bT,1);
   this.c = color(rT,gT,bT);
  }
}


  

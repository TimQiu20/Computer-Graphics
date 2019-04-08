class Ray{
  PVector o;
  PVector direction;
  public Ray(PVector pv1, PVector pv2){
    o = pv1;
    direction = pv2;
}

public Hit cast(List<Shape> shapeList){
  Hit closest = null;
  for (Shape shape : shapeList) {
    Hit hit = null;
    if (shape instanceof Sphere) {
      hit = intersect((Sphere) shape);
    }
    else{
      hit = intersect((Cone) shape);
    }
    if (hit != null) {
      if (closest == null || hit.t < closest.t)
      {
        closest = hit;
      }
    }
  }
  return closest;
}
private Hit intersect(Cone cone) {
   float cap_t = -1;
   Hit cap_hit = null;
   PVector coneCapCenter = new PVector(cone.x,cone.y+cone.h,cone.z);
   PVector eyeorigin = this.o;
   PVector eyedirection = this.direction;
   //PVector normal = PVector.sub(coneCapCenter,new PVector(cone.x,0,cone.z));
   //normal = normal.normalize();
   PVector normal = new PVector(0,1,0);
   float t =(PVector.sub(coneCapCenter,eyeorigin).dot(normal)) / (PVector.dot(eyedirection,normal));
   PVector hitP = new PVector(eyeorigin.x + t * eyedirection.x,eyeorigin.y + t * eyedirection.y,eyeorigin.z + t * eyedirection.z);
   if (t > 0) 
   {
     float hitPToConeCenter = dist(cone.x,cone.h+cone.y,cone.z,
     eyeorigin.x + t * eyedirection.x,
     eyeorigin.y + t * eyedirection.y,
     eyeorigin.z + t * eyedirection.z);
     if (hitPToConeCenter <= cone.h * cone.k){
       cap_t = t;
       cap_hit = new Hit(hitP,cone,cap_t);
     }
   }
   float body_t= -1;
   Hit body_hit = null;
   float dx = this.direction.x;
   float dy = this.direction.y;
   float dz = this.direction.z;
   float eyex = this.o.x;
   float eyey = this.o.y;
   float eyez = this.o.z;
   float centerx = cone.x;
   float centery = cone.y;
   float centerz = cone.z;
   float x = eyex - centerx;
   float y = eyey - centery;
   float z = eyez - centerz;
   float k = cone.k;
   float a = dx * dx + dz * dz - dy * dy * k * k;
   float b = 2 * (x * dx + z * dz - y * dy * k * k);
   float c = x * x + z * z - y * y * k * k;
   float det = b * b - 4 * a * c;
   if (det < 0 && cap_hit !=null) 
   {
     cone.normal = new PVector(0,1,0);
     return cap_hit;
   }
   float t1 = (-b - (float)sqrt(det)) / (2 * a);
   float t2 = (-b + (float)sqrt(det)) / (2 * a);
   if(t1 < 0 || t2 < 0) 
   {
     cone.normal = new PVector(0,1,0);
     return cap_hit;
   }
   float tt = Math.min(t1,t2);
   PVector hitP2 = new PVector(eyex + tt * dx,eyey + tt * dy,eyez + tt * dz);
   PVector coneCenter = new PVector(cone.x,cone.y,cone.z);
   PVector ConeTopCenter = new PVector(cone.x,cone.y + cone.h, cone.z);
   PVector hitP2ConeCent6er = new PVector(cone.x,eyey+tt*dy,cone.z);
   PVector T1 = new PVector(cone.z - (eyez + tt * dz), 0 , (eyex + tt * dx) - cone.x);
   PVector T2 = PVector.sub(coneCenter,hitP2);
   PVector nn = T1.cross(T2);
   nn = nn.normalize();

   if ((eyey + tt * dy) <= cone.h + cone.y && (eyey + tt * dy) >= cone.y)
   {
     body_t = tt;
     body_hit = new Hit(hitP2,cone,body_t);
   }
   if (cap_hit == null && body_hit == null) {return null;}
   else if(cap_hit == null && body_hit != null) 
   {
     cone.normal = nn;
     return body_hit;
   }
   else if(cap_hit != null && body_hit == null)
   {
     cone.normal = new PVector(0,1,0);
     return cap_hit;
   }
   else
   {
     if (cap_t < body_t)
     {
       cone.normal = new PVector(0,1,0);
       return cap_hit;
     }
     else if (cap_t > body_t) 
     {
       cone.normal = nn;
       return body_hit;
     }
     else 
     {  
       cone.normal = nn;
       return body_hit;
     }
   }
   
}
private Hit intersect(Sphere sph) {
  PVector sphCenter = new PVector(sph.x,sph.y,sph.z);
  float radius = sph.r;
  float x0 = this.o.x;
  float y0 = this.o.y;
  float z0 = this.o.z;
  float x1 = sph.x;
  float y1 = sph.y;
  float z1 = sph.z;
  float dx = this.direction.x;
  float dy = this.direction.y;
  float dz = this.direction.z;
  float a = dx * dx + dy * dy + dz * dz;
  float b = 2 * ((x0 * dx - x1 * dx) + (y0 * dy - y1 * dy) + (z0 * dz - z1 * dz));
  float c = (x0 - x1) * (x0 - x1) + (y0 - y1)* (y0 - y1) + (z0 - z1)* (z0 - z1) - radius*radius;
  float det = (b * b) - (4 * a * c);
  if (det < 0 ) {return null;}
  float t1 = (-b - (float)sqrt(det)) / (2 * a);
  float t2 = (-b + (float)sqrt(det)) / (2 * a);
  if(t1 < 0) {return null;}
  if(t2 < 0) {return null;}
  float t = Math.min(t1,t2);
  return new Hit(PVector.add(this.o,PVector.mult(this.direction,t)), sph, t);
}
}

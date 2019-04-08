class Cone extends Shape{
  float x;
  float y;
  float z;
  float h;
  float k;
  Surface surface;
  PVector normal;
  public Cone(float x, float y, float z, float h, float k, Surface surface){
    super(surface,x,y,z);
    this.surface = surface;
    this.x = x;
    this.y = y;
    this.z = z;
    this.k = k;
    this.h = h;
  }
}

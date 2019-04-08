class Sphere extends Shape{
  float r;
  float x;
  float y;
  float z;
  Surface surface;
  public Sphere (float r, float x, float y, float z, Surface surface){
    super(surface,x,y,z);
    this.surface = surface;
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
  }
}

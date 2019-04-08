class Intersect{
  Ray ray;
  float t;
  Shape shape;
  PVector ori;
  PVector end;
  public Intersect(Ray ray, float t, Shape shape, PVector ori, PVector end){
    this.ray = ray;
    this.shape = shape;
    this.t = t;
    this.ori = ori;
    this.end = end;
  }
}

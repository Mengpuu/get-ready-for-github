class Spring extends VerletConstrainedSpring3D {

  Spring(Particle a, Particle b, float d, float e,float limit) {//maximum distance
    super(a, b, d, e,limit);
  }

  void display() {
    stroke(150);
    strokeWeight(1);
    line(a.x, a.y, a.z, b.x, b.y, b.z);

  }

}

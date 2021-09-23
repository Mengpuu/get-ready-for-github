class Particle extends VerletParticle3D{

Particle(float x,float y,float z){
  super(x,y,z);
}

void display(){
pushMatrix();
//translate(x,y,z);
fill(255);
//stroke(2);
noStroke();
fill(255,51);
ellipse(0,0,1.8,1.8);
noStroke();
fill(1,156,255,12);
ellipse(0,0,12,12);
popMatrix();
}




  
}

import toxi.audio.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;

import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

import peasy.*;

VerletPhysics3D physics;
Sphere s;
SphereConstraint sc;
PeasyCam cam;

//ArrayList<Particle> ps;
//ArrayList<Spring> sps;
int cols = 40;
int rows = 30;
Particle[][] p = new Particle[cols][rows] ;
float w = 30;

int click_time=0;//count mouse event time



void setup(){
  size(1200,1000,P3D);
  cam=new PeasyCam(this,200);
  physics = new VerletPhysics3D();
  s=new Sphere(new Vec3D(350,300,40),300);
  sc=new SphereConstraint(s,false);//outside
  physics.addBehavior(new GravityBehavior3D(new Vec3D(0,0,0)));//which direction to set the gravity
  
    
  float x = 0;
 
  
  for(int i = 0;i<cols;i++){
    float z = 0;
    for(int j = 0;j<rows;j++){
    p[i][j] = new Particle(x,z,0);
    physics.addParticle(p[i][j]);
    z += w;
  }
  x += w;
  }
  
  for(int i=0;i<cols;i++){
    p[i][0].lock();
    p[i][rows-1].lock();
  }
  for(int j=0;j<rows;j++){
    p[0][j].lock();
    p[cols-1][j].lock();
  }

  
}

void draw(){
  background(16);
  physics.update();
  for(int i = 0;i<cols-1;i++){
    for(int j = 0;j<rows-1;j++){
      sc.apply(p[i][j]);
    }
  }

  
  for(int i = 0;i<cols-1;i++){
    for(int j = 0;j<rows-1;j++){
    Particle a1 = p[i][j];
    Particle b1 = p[i+1][j];
    Particle b2 = p[i][j+1];
    Particle b3 = p[i+1][j+1];
    Spring s1 = new Spring(a1,b1,w,0.1,20);
    Spring s2 = new Spring(a1,b2,w,0.1,20);
    Spring s3 = new Spring(b2,b3,w,0.1,20);
    Spring s4 = new Spring(b1,b3,w,0.1,20);
    s1.display();
    s2.display();
    s3.display();
    s4.display();
    physics.addSpring(s1);
    physics.addSpring(s2);
    physics.addSpring(s3);physics.addSpring(s4);
  }
  }
  
  
  /*
  if(mouseX>0 & mouseY>0 & mouseX/w<cols & mouseY/w<rows){
    if(mouseButton==LEFT){
      click_time++;
      p[int(mouseX/w)][int(mouseY/w)].addForce(new Vec3D(0,0,-5*click_time));
    }
    else{click_time=0;}
  }*/
  //sphere_pos();
}

// create a sphere
  float radius = -80.0f;
  float divLat = 10.0f;
  float divLon = 20.0;
void sphere_pos(){
  int idx_i=0;
  int idx_j=10;
   for (float lon = 0.0; lon < 180.0; lon += divLon) {//for (float lat = 0.0; lat <= 50.0; lat += divLat) {
   //float radLat = radians(lat);
   idx_i=0;
   float radLon = radians(lon);
   for (float lat = 180.0; lat >= 0.0; lat -= divLat) {//for (float lon = 0.0; lon < 360.0; lon += divLon) {
     //float radLon = radians(lon);
     float radLat = radians(lat);

     float cY = radius * cos(radLon) * sin(radLat);
     float cZ = radius * sin(radLon) * sin(radLat);
     float cX = radius * cos(radLat);
     //println(idx_i);
     //println(idx_j);
     p[idx_i][idx_j].x+=cX;
     p[idx_i][idx_j].y+=cY;
     p[idx_i][idx_j].z+=cZ;
     p[idx_i][idx_j].z-=50;
     idx_i++;
   }
   idx_j++;   
 }
}

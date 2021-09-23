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

VerletPhysics3D physics;

//ArrayList<Particle> ps;
//ArrayList<Spring> sps;
int cols = 40;
int rows = 25;
Particle[][] p = new Particle[cols][rows] ;
float w = 30;

int click_time=0;//count mouse event time

void setup(){
  size(1200,800,P3D);
  
  physics = new VerletPhysics3D();
  physics.addBehavior(new GravityBehavior3D(new Vec3D(0,0,0)));//which direction to set the gravity
  
  
  
  //ps = new ArrayList<Particle>();
  
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
    p[i][rows-2].lock();
  }
  for(int j=0;j<rows;j++){
    p[0][j].lock();
    p[cols-2][j].lock();
  }
  p[0][0].lock();
  p[cols-2][0].lock();
  p[0][rows-2].lock();
  //p[cols-1][rows-1].lock();
  
  p[cols-2][rows-2].lock();
  //p[0][rows-1].lock();
  
  //p[27][0].lock();
  //p[0][27].lock();
  //p[cols-1][27].lock();
  //p[27][rows-1].lock();
  
  
  //for(int j=0;j<ps.size()-1;j++){
  //  Particle a = ps.get(j);
  //  Particle b = ps.get(j+1);
  //  //Spring sp = new Spring(a,b);
  //  //physics.addSpring(sp);
  //}
  
  //ps.get(floor(random(40))).lock();
  //ps.get(floor(random(40))).lock();
  //ps.get(floor(random(40))).lock();
  
}

void draw(){
  background(16);
  //translate(width/2,height/2);//set to the center
  physics.update();
  /*
  float xoff = 0;
  float yoff = 0;
  float zoff = 0;
  float increment = 0.8;*/
  for(int i = 0;i<cols-1;i++){
    for(int j = 0;j<rows-1;j++){
      /*float windx = map(noise(xoff,yoff,zoff),0,1,-5,5);
      float windy = map(noise(xoff+6000,yoff+6000,zoff+6000),0,1,-5,5);
      float windz = map(noise(xoff+3000,yoff+3000,zoff),0,1,-5,5);*/
      p[i][j].display();
      //p[i][j].addForce(new Vec3D(windx,windy,windz));
      //yoff += increment;
  }
  //xoff += increment;
  }
  //zoff += increment;
  
  for(int i = 0;i<cols-1;i++){
    for(int j = 0;j<rows-1;j++){
    Particle a1 = p[i][j];
    Particle b1 = p[i+1][j];
    Particle b2 = p[i][j+1];
    Particle b3 = p[i+1][j+1];
    Spring s1 = new Spring(a1,b1,w,0.1);
    Spring s2 = new Spring(a1,b2,w,0.1);
    Spring s3 = new Spring(b2,b3,w,0.1);
    Spring s4 = new Spring(b1,b3,w,0.1);
    s1.display();
    s2.display();
    s3.display();
    s4.display();
    physics.addSpring(s1);
    physics.addSpring(s2);
    physics.addSpring(s3);physics.addSpring(s4);
  }
  }
  
  
  if(mouseX>0 & mouseY>0 & mouseX/w<cols & mouseY/w<rows){
    if(mouseButton==LEFT){
      click_time++;
      p[int(mouseX/w)][int(mouseY/w)].addForce(new Vec3D(0,0,-5*click_time));
    }
    else{click_time=0;}
    //p[int(mouseX/w)][int(mouseY/w)].addForce(new Vec3D(0,0,-20));
  }
  //p[10][10].addForce(new Vec3D(0,0,-20));
}

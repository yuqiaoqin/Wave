
class Vehicle {


  PVector location;
  PVector prev;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float maxbforce;
  float maxbspeed;
  PVector changeBorder = null;
  PImage img;


 

  Vehicle(PImage img_,PVector l, float ms, float mf, float bms, float bmf) {
    location = l.copy();
    prev = location.copy();
    r = 3.0;
    //mass=1;
    maxspeed = ms;
    maxforce = mf;
    maxbspeed= bms;
    maxbforce = bmf;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();

    velocity.mult(random(0, 6));
    img=img_;
  }

  public void run() {
    update();
    display();
  }


  void follow(FlowField1 flow, int dir) {
    // What is the vector at that spot in the flow field?
    if (location.x > width -30 || location.x < 30 || location.y > height -30 || location.y < 30)
    {
      PVector centerPush = PVector.sub(new PVector(width/2, height/2), location);
      centerPush.limit(maxbforce);
      applyForce(centerPush);
    } else {
      
      PVector desired = flow.lookup(location);
      desired.mult(maxspeed);
      // Steering is desired minus velocity
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);  
      steer.x *= dir;
      applyForce(steer);
    }
    if(dist(abs(location.x),abs(location.y),width/2,height/2)>160){
      PVector pull= PVector.sub(new PVector(width/2, height/2), location);
      pull.limit(0.2);
      applyForce(pull);
    }
    if(dist(abs(location.x),abs(location.y),width/2,height/2)<10){
      PVector push= PVector.sub(new PVector(width/2, height/2),location);
      push.limit(5);
      push.mult(-1);
      applyForce(push);
    }
  }

void follow2(FlowField2 flow, int dir) {
    // What is the vector at that spot in the flow field?
    if (location.x > width -30 || location.x < 30 || location.y > height -30 || location.y < 30)
    {
      PVector centerPush = PVector.sub(new PVector(width/2, height/2), location);
      centerPush.limit(maxbforce);
      applyForce(centerPush);
    } else {
      
      PVector desired = flow.lookup(location);
      desired.mult(10);
      // Steering is desired minus velocity
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);  
      steer.x *= dir;
      applyForce(steer);
    }
    if(dist(abs(location.x),abs(location.y),width/2,height/2)>160){
      PVector pull= PVector.sub(new PVector(width/2, height/2), location);
      pull.limit(0.2);
      applyForce(pull);
    }
    if(dist(abs(location.x),abs(location.y),width/2,height/2)<10){
      PVector push= PVector.sub(new PVector(width/2, height/2),location);
      push.limit(5);
      push.mult(-1);
      applyForce(push);
    }
  }
  //void borders() {
    
  //  if (location.x > width || location.x < 0 || location.y > height || location.y < 0)
  //  {
  //    //changeBorder.normalize();
  //    //changeBorder.mult(maxbspeed);
  //    PVector centerPush = PVector.sub(new PVector(width/2, height/2), location);
  //    centerPush.limit(maxbforce);
  //    applyForce(centerPush);
      
      
  //  }

/*
    if (location.x < 0 ) {
      location.x=width;
      
      changeBorder= new PVector(maxbspeed, abs(velocity.y));
    } else if (location.x > width) {
      location.x=0;
      changeBorder = new PVector(maxbspeed, abs(velocity.y));
      
    }
    if (location.y < 0) {
      location.y=prev.y;
      changeBorder = new PVector(abs(velocity.x), maxbspeed);
    } else if (location.y > height) {
      changeBorder = new PVector(abs(velocity.x) , maxbspeed);
     location.y=prev.y;
    }
*/
    //if (changeBorder!=null) {

    //  changeBorder.normalize();
    //  changeBorder.mult(maxbspeed);
    //  PVector centerPush = PVector.sub(new PVector(width/2, height/2), location);
    //  centerPush.limit(maxbforce);
    //  applyForce(centerPush);
    //} 
  //}


  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    //noFill();
    //strokeWeight(1.5);
    //stroke(255, 20);
 
    pushMatrix();
    //float d = PVector.dist(prev, location);
    //if (d >30) {
    //  point(location.x, location.y);
    //} else {
    //  line(prev.x, prev.y, location.x, location.y);
    //}
    noStroke();
    fill(255,20);
    ellipse(location.x,location.y,img.width,img.height);
    prev.set(location);
    popMatrix();
  }
}  
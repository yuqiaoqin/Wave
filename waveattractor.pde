// QuadTree, Spatial Subdivision

boolean debug = false;
int state=0;
float l;

// Flowfield object
FlowField1 flowfield1;
FlowField2 flowfield2;
// An ArrayList of vehicles
ArrayList<Vehicle> vehicles1;
ArrayList<Vehicle> vehicles2;

void setup() {
  size(1000, 400, P2D);
  //frameRate(100);
  noiseSeed(2);

  flowfield1 = new FlowField1(10);
  flowfield2 = new FlowField2(10);
  
  //flowfield.update();
  vehicles1 = new ArrayList<Vehicle>();
  vehicles2 = new ArrayList<Vehicle>();
   PImage img=loadImage("particle3.png");

  for (int i = 0; i < 8000; i++) {
    PVector start1 = new PVector(10, height/2);
    //PVector start = new PVector(random(width),random(height));
    vehicles1.add(new Vehicle(img,start1, random(0, 8), random(0.01, 0.5),3,1));
  }

  for (int j=0; j<8000; j++) {
    PVector start2 = new PVector(width-10, height/2);
    vehicles2.add(new Vehicle(img,start2, random(0, 8), random(0.1, 0.5),3,0.9));
  }
 
   
}

void draw() {

  background(0,50);

  flowfield1.update();
  flowfield2.update();

  //flowfield.display();
 // PVector wind1= new PVector(10, 0);
 // PVector wind2= new PVector(-10, 0);
  PVector gravity= new PVector(0,0.3);
  
  


  for (Vehicle v : vehicles1) {
    if(v.location.x<width/2+30){
     v.follow(flowfield1, 1); 
    }else if (v.location.x>width/2){
     v.follow2(flowfield2, 1);
    }
    
    v.run();
    
    
  }

  for (Vehicle v2 : vehicles2) {
   if(v2.location.x<width/2-30){
     v2.follow2(flowfield2, -1); 
    }else if (v2.location.x>width/2){
     v2.follow(flowfield1, -1);
    }
    v2.run();
   
  }
}
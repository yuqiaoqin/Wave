
class FlowField2 {

  // A flow field is a two dimensional array of PVectors
  PVector[][] field;
  int cols, rows; // Columns and Rows
  int resolution; // How large is each "cell" of the flow field
  float zoff = 0;
  float angle = 0;
  FlowField2(int r) {
    resolution = r;
    // Determine the number of columns and rows based on sketch's width and height
    cols = width/resolution;
    rows = height/resolution*30;
    field = new PVector[cols][rows];
    //noiseSeed((int)random(10000));
  }

  void update() {
    // Reseed noise so we get a new flow field every time
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff, 0.01*frameCount), 0, 1, 0, TWO_PI);
       
         
      
        field[i][j] = new PVector(random(-1,-0.1), sin(theta)*(-1));
        //field[i][j] = new PVector(cos(theta), sin(theta));
        
        
        yoff += 0.05;
      }
      xoff += 0.05;
    }
    //zoff+=0.001;
    
    //angle += 0.01;
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        stroke(255);
        drawVector(field[i][j], i*resolution, j*resolution, 6);
      }
    }
  }

  // Renders a vector object 'v' as an arrow and a location 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    // Translate to location to render vector
    translate(x, y);
    stroke(255,100);
    rotate(v.heading());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0, 0, len, 0);
   
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }
}
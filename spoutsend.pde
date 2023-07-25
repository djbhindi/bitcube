
// IMPORT THE SPOUT LIBRARY
import spout.*;

PImage img; // image to use for the rotating cube
PGraphics pgr; // Graphics for demo

// DECLARE A SPOUT OBJECT
Spout spout;

void setupSpoutSend() {

  // Initial window size
  //size(640, 360, P3D);
  textureMode(NORMAL);
  
  // Screen text size
  //textSize(16);
  
  // Create a graphics object
  //pgr = createGraphics(w * pixel_size, h * pixel_size, P3D);
  pgr = createGraphics(w, h, P3D);
  
  // Load an image
  //img = loadImage("SpoutLogoMarble3.bmp");
  
  // The dimensions of graphics or image objects
  // do not have to be the same as the sketch window
    
  // CREATE A NEW SPOUT OBJECT
  spout = new Spout(this);
  
  // GIVE THE SENDER A NAME
  // A sender can be given any name.
  // Otherwise the sketch folder name is used
  // the first time "sendTexture" is called.  
  spout.setSenderName("Spout Processing Sender");
  
  // Option - set the sketch frame rate.
  // Receivers 2.007 or higher will detect this rate
  //frameRate(30);
  
} 

void sendSpoutData()  { 

    //background(0, 90, 100);
    //noStroke();

    pgr.beginDraw();
    //pgr.lights();
    //pgr.background(0, 90, 100);
    //pgr.fill(255);
    //pushMatrix();
    //pgr.translate(pgr.width/2, pgr.height/2);
    //pgr.rotateX(frameCount/60.0);
    //pgr.rotateY(frameCount/60.0);
    //pgr.fill(192);
    //pgr.box(pgr.width/4); // box is not textured
    //popMatrix();
    
    pgr.loadPixels();
    
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        //pgr.fill(grid[i][j]);
        //pgr.fill(color(255,0,0));
        //pgr.pixels[i] = color(255,0,0);
        pgr.pixels[i + j*w] = grid[i][j];
        //pgr.box(pgr.width/4);
        //pgr.square(i * pixel_size, j * pixel_size, pixel_size);
      }
    }
    
    pgr.updatePixels();
    
    pgr.endDraw();
    //image(pgr, 0, 0, width, height);
    // Send at the size of the graphics
    spout.sendTexture(pgr);
    
    
    /*
    // OPTION 3: SEND THE TEXTURE OF AN IMAGE
    image(img, 0, 0, width, height);
    // Send at the size of the image
    spout.sendTexture(img);
    */

    // Display info
    //text("Sending as : "
    //  + spout.getSenderName() + " ("
    //  + spout.getSenderWidth() + "x"
    //  + spout.getSenderHeight() + ") - fps : "
    //  + spout.getSenderFps() + " : frame "
    //  + spout.getSenderFrame(), 15, 30);  
   
}

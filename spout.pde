////spout
////TODO handle different sizes and aspect ratios when sampling the grid
////ie resize first or check size or some other way that is a best practice.

//import spout.*;

//PImage img; // Image to receive a texture
//PGraphics pgr; // Canvas to receive a texture

//Spout spout;

//void setupSpout() {
//  spout = new Spout(this);
//} 

//void drawSpout() {
//  img = spout.receiveImage(img);
//  if(img.loaded)
//    image(img, 0, 0, width, height);
//    updateGridFromTexture(img);
//}

//void updateGridFromTexture(PImage img) {
//  img.loadPixels();
  
//  int wStep = img.width / w;
//  int hStep = img.height / h;

//  for (int i = 0; i < w; i++) {
//    for (int j = 0; j < h; j++) {
//      grid[i][j] = img.get(i * wStep, j * hStep);
//    }
//  }
//}

//// RH click to select a sender
//void mousePressed() {
//  // SELECT A SPOUT SENDER
//  if (mouseButton == RIGHT) {
//    // Bring up a dialog to select a sender.
//    // SpoutSettings must have been run at least once
//    // to establish the location of "SpoutPanel"
//    spout.selectSender();
//  }
//}

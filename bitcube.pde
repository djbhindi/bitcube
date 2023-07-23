//Bitcube is a 32x8 display.
//This is a processing sketch that consists of multiple files.
//Bitcube is the main file and is for the overall flow of the program
//It also sets up a grid for the color data and renders it to the screen.
//Artnet sends the data over the network to the leds.
//Spout allows processing to receive a texture and fills the color array grid. 
//The other files are individual effects that write to the grid in the draw loop.
//You will need to install dependancy libraries incuding spout and artnet.


//Main

final int w = 32;
final int h = 8;
final int pixel_size = 40;

final int NUM_MODES = 3;
int mode = 8;

color[][] grid = new color[w][h];

String artnetIP = "bitcube2.local"; //saw issues with lag evey 30 seconds. when it looks up the mdns name?
//String artnetIP = "127.0.0.1"; //test locally
//String artnetIP = "192.168.1.144";
//String artnetIP = "10.0.7.62";

// Modify setup() to include setupMatrixRain()
void setup() {
  //frameRate(16);
  size(1280, 320, P3D);
  noStroke();
  setupGrid();
  //setupReactive();
  setupArtNet();
  //setupSpout();
  setupLaserAttackBlue();
  setupSauron();
  setupRainbow();
  setupTetris();

}

// Modify draw() to include drawMatrixRain()
void draw() {
  background(0);
  
  switch(mode) {
    case 0:
      drawLightningBolt();
      break;
    case 1:
      drawRaindrops();
      break;
    case 2:
      drawReactive();
      break;
    case 3:
      drawGrowingMoss();
      break;
    case 4:
      drawLaserAttackBlue();
      break;
    case 5:
      drawLaserStrike();
      break;
    case 6:
      drawRainfall();
      break;
    case 7:
      drawSauron1();
      break;
    case 8:
      drawBlueDrip();
      break;
    case 9:
      drawRainbow();
      break;
    case 10:
      drawTetris();
      break;
    default: 
      break;
  }
  
  drawGrid();
  updateDMX();
  //updateDMXserpentine();
}

public abstract class BitDrawing {
   abstract public void renderDrawing(color[][] grid);
   
   public void setupDrawing() {
     // Default; can be overriden by subclasses.
     frameRate(30);  
   }
   
}

void stop() {
  stopArtNet();
  super.stop();
}

void setupGrid() {
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      grid[i][j] = color(0, 0, 0);
    }
  }
}

void drawGrid() {
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      fill(grid[i][j]);
      square(i * pixel_size, j * pixel_size, pixel_size);
    }
  }
}

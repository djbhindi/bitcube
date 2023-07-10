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
final int pixel_size = 20;

color[][] grid = new color[w][h];

//String artnetIP = "bitcube.local"; //saw issues with lag evey 30 seconds. when it looks up the mdns name?
//String artnetIP = "127.0.0.1"; //test locally
//String artnetIP = "192.168.1.144";
String artnetIP = "10.0.7.62";

void setup() {
  size(640, 160, P3D);
  noStroke();
  setupGrid();
  setupReactive();
  setupArtNet();
  //setupSpout();
}


void draw() {
  background(0);
  //Uncomment desired effect
  //drawLightningBolt();
  //drawRaindrops();
  drawReactive();
  //drawSpout();
  drawGrid();
  //updateDMX();
  updateDMXserpentine();
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

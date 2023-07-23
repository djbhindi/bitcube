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
color[][] grid = new color[w][h];

// Controls which drawing we render.
int mode = 0;
ArrayList<BitDrawing> modes = new ArrayList<BitDrawing>();

String artnetIP = "bitcube2.local"; //saw issues with lag evey 30 seconds. when it looks up the mdns name?
//String artnetIP = "127.0.0.1"; //test locally
//String artnetIP = "192.168.1.144";
//String artnetIP = "10.0.7.62";

void settings() {
  size(w * pixel_size, h * pixel_size, P3D);
}

// Modify setup() to include setupMatrixRain()
void setup() {
  //frameRate(30);
  noStroke();
  setupGrid();
  setupArtNet();
  //setupSpout();
  //setupTetris();

  modes.add(new LightningBoltDrawing());
  modes.add(new RaindropsDrawing());
  modes.add(new GrowingMossDrawing());
  modes.add(new BlueDripDrawing());
  modes.add(new LaserAttackDrawing(200, 5));
  modes.add(new LaserAttackDrawing(120, 10));
  modes.add(new SauronDrawing());
  //modes.add(new ReactiveDrawing(this));
  modes.add(new RainbowDrawing());
  //modes.add(new RainfallDrawing());
  
  // This runs a one-time setup for each sketch.
  for (BitDrawing drawing : modes) {
    drawing.setupDrawing();
  }
  modes.get(mode).onSwitch();
}

// Modify draw() to include drawMatrixRain()
void draw() {
  background(0);
  
  modes.get(mode).renderDrawing(grid);

  drawGrid();
  //updateDMX();
  //updateDMXserpentine();
}

public abstract class BitDrawing {
  abstract public void renderDrawing(color[][] grid);

  public void setupDrawing() {};
  
  public void onSwitch() {
    frameRate(30);
  }
  
  public void keyHandle(char key) {}
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

// The main sketch handles switches between drawings with [ and ].
// Apart from those keys, any key pressed will be passed through to the sketch.
// TODO: Create an indexSearch class that handles the wraparound-to-0 logic and re-use it (e.g. in reactive).
void keyPressed() {
  if (key == ']') {
    mode = (mode + 1) % modes.size();
  } else if (key == '[') {
    mode = mode == 0 ? modes.size() - 1 : mode - 1;
  } else {
    modes.get(mode).keyHandle(key);
    return;
  }
  
  modes.get(mode).onSwitch();
}

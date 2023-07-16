int cols = 32;
int rows = 8;
int pixelSize = 20;
int gap = 2;

color[] palette = { #231C07, #392A16, #634133, #FF4800, #FF6000, #FF7900, #FF9100, #FFB600, #FBF2C0, #048BA8 };
int[][] fire;
float[][] brightness;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  frameRate(10);  // Slow down the sketch
  fire = new int[cols][rows];
  brightness = new float[cols][rows];
}

void draw() {
  background(0);
  
  // Ignite the bottom row randomly
  for (int i = 0; i < cols; i++) {
    fire[i][rows - 1] = int(random(3, palette.length));
    brightness[i][rows - 1] = random(0.5, 1);
  }

  // Fire propagation
  for (int x = 0; x < cols; x++) {
    for (int y = rows - 2; y >= 0; y--) {
      int dx = int(random(3)) - 1;
      int nx = constrain(x + dx, 0, cols - 1);
      int ny = y + 1;
      
      fire[x][y] = constrain(fire[nx][ny] - int(random(2)), 0, palette.length - 1);
      brightness[x][y] = constrain(brightness[nx][ny] - random(0.05), 0, 1);
    }
  }
  
  // Draw fire
  noStroke();
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      fill(red(palette[fire[x][y]]) * brightness[x][y], green(palette[fire[x][y]]) * brightness[x][y], blue(palette[fire[x][y]]) * brightness[x][y]);
      rect(x * pixelSize, y * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }
}

int cols = 28;
int rows = 8;
int pixelSize = 20;
int gap = 0;

color skyColor = color(20, 178, 232); // Sky blue color

float xOff, yOff, zOff;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  xOff = 0;
  yOff = 0;
  zOff = 0;
  frameRate(10);
}

void draw() {
  background(skyColor);
  zOff += 0.03; // controls the speed of the "drift"
  yOff = 0;

  for (int y = 0; y < rows; y++) {
    xOff = 0;
    for (int x = 0; x < cols; x++) {
      float noiseVal = noise(xOff, yOff, zOff);
      // increased contrast and brightness of the clouds
      color cloudColor = color(255, 192, 203, noiseVal * 255 * 1.5);
      
      fill(cloudColor);
      // remove the condition to ensure stroke is always solid
      noStroke();
      rect(x * pixelSize, y * pixelSize, pixelSize - gap, pixelSize - gap);
      
      xOff += 0.1; // increase the rate of change in the x-axis
    }
    yOff += 0.1; // increase the rate of change in the y-axis
  }
}

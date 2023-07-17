int cols = 32;
int rows = 8;
int cellSize = 20;

float movementSpeed = 0.03;   // Adjust the speed at which the dot moves
float stopTime = 3.0;         // Adjust the time the dot stops for (in seconds)
float pulseSpeed = 0.05;      // Adjust the speed of the pulsing glow
float trailLength = 50;       // Adjust the length of the trail
float trailBrightness = 0;   // Adjust the brightness of the trail
float movementRange = 64;     // Adjust the range of movement

float dotX;
float targetX;
float trailEndX;
int stopFrame;

void settings() {
  size(cols * cellSize, rows * cellSize);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  stroke(255);
  fill(255);

  dotX = cols / 2.0;
  targetX = random(cols / 2 - movementRange / 2, cols / 2 + movementRange / 2);
  trailEndX = dotX;
  stopFrame = floor(random(60 * stopTime));
}

void draw() {
  // Clear the screen at the start of each frame
  fill(0);
  rect(0, 0, width, height);

  // Create a flickering faint red and black static background
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(random(10), random(100), random(20));
      rect(i * cellSize, j * cellSize, cellSize, cellSize);
    }
  }

  if (frameCount % stopFrame == 0) {
    targetX = random(cols / 2 - movementRange / 2, cols / 2 + movementRange / 2);
    stopFrame = floor(random(60 * stopTime));
  }

  dotX = lerp(dotX, targetX, movementSpeed);

  if (abs(dotX - targetX) < 0.1) {
    trailEndX = lerp(trailEndX, dotX, pulseSpeed);
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float d = dist(i, j, dotX, rows / 2);
      if (d < 1) {
        fill(0);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      } else if (d < 2) {
        fill(0, 100, 100);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      } else if (d < 3) {
        float b = map(sin(frameCount * pulseSpeed + d), -1, 1, 0, 100);
        fill(0, 100, b);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      } else if (i > trailEndX && i < dotX) {
        fill(0, 100, trailBrightness);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
}

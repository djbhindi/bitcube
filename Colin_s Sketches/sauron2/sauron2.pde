int cols = 32;
int rows = 8;
int cellSize = 20;

float movementSpeed = 0.01;   // Adjust the speed at which the dot moves
float stopTime = 3.0;         // Adjust the time the dot stops for (in seconds)
float pulseSpeed = 0.05;      // Adjust the speed of the pulsing glow
float glowRadius = 2.0;       // Adjust the radius of the glow around the "eye"
float glowBrightness = 100;    // Adjust the brightness of the glow
float outerGlowRadius = 4.0;  // Adjust the radius of the outer glow
float outerGlowBrightness = 100; // Adjust the brightness of the outer glow
float movementRange = 40;     // Adjust the range of movement

int outerGlowColor = color(255, 255, 255); // Adjust the color of the outer glow

float dotX;
float targetX;
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
  stopFrame = floor(random(60 * stopTime)) + 1;
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
    stopFrame = floor(random(60 * stopTime)) + 1;
  }

  dotX = lerp(dotX, targetX, movementSpeed) % cols;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float d = dist(i, j, dotX, rows / 2);
      if (d < 1) {
        fill(0);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      } else if (d < glowRadius) {
        fill(0, 100, glowBrightness);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      } else if (d < outerGlowRadius) {
        fill(outerGlowColor, outerGlowBrightness);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
}

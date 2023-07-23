// Sauron 1
//int cols = 32;
//int rows = 8;
//int cellSize = 20;

//float movementSpeed = 0.03;   // Adjust the speed at which the dot moves
//float stopTime = 3.0;         // Adjust the time the dot stops for (in seconds)
//float pulseSpeed = 0.05;      // Adjust the speed of the pulsing glow
//float trailLength = 50;       // Adjust the length of the trail
//float trailBrightness = 0;   // Adjust the brightness of the trail
//float movementRange = 64;     // Adjust the range of movement

//float dotX;
//float targetX;
//float trailEndX;
//int stopFrame;

//void setupSauron() {
//  dotX = cols / 2.0;
//  targetX = random(cols / 2 - movementRange / 2, cols / 2 + movementRange / 2);
//  trailEndX = dotX;
//  stopFrame = floor(random(60 * stopTime));
//}

// sauron's eye

public class SauronDrawing extends BitDrawing {
  int cols = 32;
  int rows = 8;
  //int cellSize = 20;

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
  
  void setupDrawing() {
    dotX = cols / 2.0;
    targetX = random(cols / 2 - movementRange / 2, cols / 2 + movementRange / 2);
    trailEndX = dotX;
    stopFrame = floor(random(60 * stopTime));
  }

  public void renderDrawing(color[][] grid) {
    colorMode(HSB, 360, 100, 100);


    // Create a flickering faint red and black static background
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = color(random(10), random(100), random(20));
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
          grid[i][j] = color(0);
        } else if (d < 2) {
          grid[i][j] = color(0, 100, 100);
        } else if (d < 3) {
          float b = map(sin(frameCount * pulseSpeed + d), -1, 1, 0, 100);
          grid[i][j] = color(0, 100, b);
        } else if (i > trailEndX && i < dotX) {
          grid[i][j] = color(0, 100, trailBrightness);
        }
      }
    }
    colorMode(RGB, 255);
  }
}

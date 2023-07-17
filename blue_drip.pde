float dripSpeed = 0.05;
float dripLength = 2;

void drawBlueDrip() {
  colorMode(HSB, 360, 100, 100, 100); // Use HSB color space
  background(200, 20, 10, 100); // Dark blue-grey background

  // Calculate and draw each cell's color
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float h = map(sin((y + time) / dripLength), -1, 1, 200, 220);
      float s = 100;
      float b = map(sin((y + time) / dripLength), -1, 1, 50, 100);

      grid[x][y] = color(h, s, b, 100);
    }
  }

  time += dripSpeed;
  colorMode(RGB, 255);
}

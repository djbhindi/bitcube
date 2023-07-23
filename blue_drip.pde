// blue drip

public class BlueDripDrawing extends BitDrawing {
  private float dripSpeed = 0.05;
  private float dripLength = 2;
  private float time = 0;

  void renderDrawing(color[][] grid) {
    colorMode(HSB, 360, 100, 100, 100); // Use HSB color space
    background(200, 20, 10, 100); // Dark blue-grey background

    // Calculate and draw each cell's color
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        float h = map(sin((y + time) / dripLength), -1, 1, 200, 220);
        float s = 100;
        float b = map(sin((y + time) / dripLength), -1, 1, 50, 100);

        grid[x][y] = color(h, s, b, 100);
      }
    }

    time += dripSpeed;
    colorMode(RGB, 255);
  }
}

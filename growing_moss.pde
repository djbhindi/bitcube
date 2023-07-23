// growing moss

public class GrowingMossDrawing extends BitDrawing {
  private color[] colorScheme = { #20C9A2, #6EF7AF, #BDFEAF, #86D278, #43D856, #51FA23, #64D43E, #42C11D, #3A6738 };
  private float time = 0;
  private float increment = 0.002;
  private float scale = 0.1;  // New variable to adjust the Perlin Noise scale

  void renderDrawing(color[][] grid) {
    background(0);
    time += increment;

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        // Adjusted the Perlin Noise input to include the scale variable
        int index = int(map(noise(i * scale, j * scale, time), 0, 1, 0, colorScheme.length));
        grid[i][j] = colorScheme[index];
      }
    }
  }
}

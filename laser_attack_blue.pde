// Add these global variable declarations

public class LaserAttackDrawing extends BitDrawing {
  protected float[][] brightnessArr;
  protected boolean[][] isFadingArr;
  protected int[][] countdownArr;
  protected float[][] staticArr;
  protected int laserColor;
  protected int frameGap;
  
  public LaserAttackDrawing(int laserColor, int frameGap) {
    this.laserColor = laserColor;
    this.frameGap = frameGap;
  }

  // Add this function
  void setupDrawing() {
    // Initialize arrays
    brightnessArr = new float[w][h];
    isFadingArr = new boolean[w][h];
    countdownArr = new int[w][h];
    staticArr = new float[w][h];

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        brightnessArr[i][j] = 0;
        isFadingArr[i][j] = false;
        countdownArr[i][j] = 0;
        staticArr[i][j] = random(10, 30);
      }
    }
  }

  // Add this function
  void renderDrawing(color[][] grid) {
    colorMode(HSB, 360, 100, 100);

    // Every 5 frames start a new "laser"
    if (frameCount % frameGap == 0) {
      int i = floor(random(w));
      brightnessArr[i][0] = 100;
      countdownArr[i][0] = int(random(8, 15)); // Make the lasers a bit longer
    }

    // Process colors and trails
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {

        if (countdownArr[i][j] > 0) {
          if (j < h - 1) {
            countdownArr[i][j + 1] = countdownArr[i][j] - 1;
          }
          brightnessArr[i][j] = 100;
          isFadingArr[i][j] = true;
          countdownArr[i][j] = 0;
        }

        if (isFadingArr[i][j]) {
          brightnessArr[i][j] -= 2;
          if (brightnessArr[i][j] <= 0) {
            isFadingArr[i][j] = false;
          }
        }

        // The leading pixel is flickering white, trailing pixels are a cooler blue with shimmer
        boolean isLeading = (j < h - 1 && brightnessArr[i][j + 1] == 100);
        if (isLeading) {
          grid[i][j] = color(0, 0, brightnessArr[i][j] + random(0, 20));
        } else {
          grid[i][j] = color(laserColor, 100, brightnessArr[i][j] + random(0, 20)); // Changed from green to blue
        }
      }
    }

    colorMode(RGB, 255);
  }
}

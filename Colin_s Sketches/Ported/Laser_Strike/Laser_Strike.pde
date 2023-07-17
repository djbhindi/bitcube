int pixelSize = 20;
int cols = 32;
int rows = 8;
int gap = 2;

float[][] brightnessArr;
boolean[][] isFadingArr;
int[][] countdownArr;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  noStroke();

  // Initialize color and trail arrays
  brightnessArr = new float[cols][rows];
  isFadingArr = new boolean[cols][rows];
  countdownArr = new int[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      brightnessArr[i][j] = 0;
      isFadingArr[i][j] = false;
      countdownArr[i][j] = 0;
    }
  }
}

void draw() {
  background(0);

  // Every 10 frames start a new "drip"
  if (frameCount % 10 == 0) {
    int i = floor(random(cols));
    brightnessArr[i][0] = 100;
    countdownArr[i][0] = 8; 
  }

  // Process colors and trails
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      if (countdownArr[i][j] > 0) {
        if (j < rows - 1) {
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

      // The leading pixel is flickering white, trailing pixels are green with shimmer
      boolean isLeading = (j < rows - 1 && brightnessArr[i][j + 1] == 100);
      if (isLeading) {
        fill(0, 0, brightnessArr[i][j] + random(0, 20));
      } else {
        fill(120, 100, brightnessArr[i][j] + random(0, 20));
      }

      rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }
}

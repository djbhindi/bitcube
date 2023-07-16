// Our canvas size
int canvasWidth = 32;
int canvasHeight = 8;

// Array to store the state of each pixel
int[][] pixels = new int[canvasHeight][canvasWidth];

void settings() {
  // Size of the window, each pixel is 40x40 for visibility
  size(canvasWidth * 40, canvasHeight * 40, P2D);

  // Using P2D (2D rendering) for better performance
  pixelDensity(1);
}

void setup() {
  // Initialize all pixels to off (0)
  for (int i = 0; i < canvasHeight; i++) {
    for (int j = 0; j < canvasWidth; j++) {
      pixels[i][j] = 0;
    }
  }
}

void draw() {
  // Clear the screen
  background(0);

  // Shift all pixels down and randomly turn on pixels at the top
  for (int j = 0; j < canvasWidth; j++) {
    // Shift down
    for (int i = canvasHeight-1; i > 0; i--) {
      pixels[i][j] = pixels[i-1][j];
    }

    // Randomly turn on top pixels
    pixels[0][j] = (random(1) < 0.1) ? 255 : 0;
  }

  // Draw the state of each pixel
  noStroke();
  for (int i = 0; i < canvasHeight; i++) {
    for (int j = 0; j < canvasWidth; j++) {
      fill(pixels[i][j]);
      rect(j * 40, i * 40, 40, 40);
    }
  }
}

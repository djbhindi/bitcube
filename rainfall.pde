//int[][] pixels = new int[h][w];


void drawRainfall() {
  // Clear the screen
  background(0);

  // Shift all pixels down and randomly turn on pixels at the top
  for (int j = 0; j < w; j++) {
    // Shift down
    for (int i = h-1; i > 0; i--) {
      grid[j][i] = grid[j][i-1];
    }

    // Randomly turn on top pixels
    grid[j][0] = (random(1) < 0.1) ? color(255, 255, 255) : color(0, 0, 0);
  }
  
  
 //for (int i = 0; i < w; i++) {
 // for (int j = 0; j < h; j++) {
 //   grid[i][j] = pixels[j][i];
 //   }
 // }
}

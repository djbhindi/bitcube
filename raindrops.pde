//raindrops

void generateRandomDrops() {
  if (random(1) < 0.1) {
    int x = floor(random(w));
    grid[x][0] = color(random(255), random(255), random(255));
  }
}

void animateRaindrops() {
  for (int i = 0; i < w; i++) {
    for (int j = h - 1; j >= 0; j--) {
      if (grid[i][j] != color(0, 0, 0)) {
        if (j < h - 1) {
          grid[i][j + 1] = grid[i][j];  // move down
          grid[i][j] = color(red(grid[i][j]) * 0.25, green(grid[i][j]) * 0.25, blue(grid[i][j]) * 0.25);  // fade color
        } else {
          grid[i][j] = color(0, 0, 0);  // remove drop at the bottom
        }
      }
    }
  }
}

void drawRaindrops() {
  generateRandomDrops();
  animateRaindrops();
}

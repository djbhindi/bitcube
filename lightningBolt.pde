//lightningBolt

int boltTimer = -1;
int boltDuration = 10; // Adjust as needed
ArrayList<PVector> boltPath = new ArrayList<PVector>();

void triggerBolt() {
  boltPath.clear();

  int x = floor(random(w));
  int y = 0;
  
  // Create a zigzag path for the bolt
  while (y < h) {
    boltPath.add(new PVector(x, y));
    x += int(random(3)) - 1; // -1, 0, or 1
    x = constrain(x, 0, w - 1);
    y++;
  }
  
  boltTimer = boltDuration;
}

void animateBolt() {
  // Fade out all pixels
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      float r = red(grid[i][j]) * 0.9;
      float g = green(grid[i][j]) * 0.9;
      float b = blue(grid[i][j]) * 0.9;
      grid[i][j] = color(r, g, b);
    }
  }
  
  if (boltTimer >= 0) {
    // Light up the bolt path
    for (PVector p : boltPath) {
      grid[int(p.x)][int(p.y)] = color(255, 255, 255);
    }
    // Decrease the timer
    boltTimer--;
  }
}

void drawLightningBolt() {
  triggerBolt();
  animateBolt();
}

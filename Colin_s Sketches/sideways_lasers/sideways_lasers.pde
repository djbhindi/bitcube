int pixelSize = 20;
int cols = 32;
int rows = 8;
int gap = 2;

float[][] pulseArr;
int[][] pulseProgressArr;
float[][] staticArr;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  noStroke();

  // Initialize arrays
  pulseArr = new float[cols][rows];
  pulseProgressArr = new int[cols][rows];
  staticArr = new float[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      pulseArr[i][j] = 0;
      pulseProgressArr[i][j] = -1;
      staticArr[i][j] = random(10, 30);
    }
  }
}

void draw() {
  background(0);

  // Add some static
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(0, 0, staticArr[i][j]);
      rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }

  // Every 60 frames start a new "pulse" on a random row
  if (frameCount % 60 == 0) {
    int j = floor(random(rows));
    pulseArr[0][j] = 80; // Lower maximum pulse intensity
    pulseProgressArr[0][j] = 0;
  }

  // Process colors and trails
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      if (pulseProgressArr[i][j] >= 0) {
        pulseArr[i][j] -= 4; // Increase rate of fade-out

        if (pulseArr[i][j] <= 0) {
          pulseProgressArr[i][j] = -1;
          pulseArr[i][j] = 0;
        }
        else if (i < cols - 1) {
          pulseArr[i+1][j] = 80; // Lower maximum pulse intensity
          pulseProgressArr[i+1][j] = 0;
          pulseProgressArr[i][j]++;
        }

        fill(200, 100, pulseArr[i][j] + random(0, 20)); // Pulse is a cool blue with shimmer
        rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
      }
    }
  }
}

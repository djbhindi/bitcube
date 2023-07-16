int cols = 32;
int rows = 8;
int pixelSize = 20;
int gap = 2;

color[] palette = {
  color(227, 99, 151), 
  color(188, 141, 160), 
  color(191, 179, 184), 
  color(216, 216, 216), 
  color(242, 239, 240)
};

float[][] noiseSeed;
int[][] grid;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  noiseSeed = new float[cols][rows];
  grid = new int[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      noiseSeed[i][j] = random(1000);
      grid[i][j] = int(noise(noiseSeed[i][j]) * palette.length);
    }
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      noiseSeed[i][j] += 0.02;
      grid[i][j] = int(noise(noiseSeed[i][j]) * palette.length);

      fill(palette[grid[i][j]]);
      rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }
}

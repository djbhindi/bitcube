int cols = 32;
int rows = 8;
int pixelSize = 20;
int gap = 2;

color[] palette = {color(227,99,151), color(188,141,160), color(191,179,184), color(216,216,216), color(242,239,240)};

int[][] grid;
ArrayList<PVector> walkers;

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  grid = new int[cols][rows];
  walkers = new ArrayList<PVector>();

  // Initialize the grid with color indices
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = floor(random(palette.length));
    }
  }

  // Start with one walker
  walkers.add(new PVector(floor(random(cols)), floor(random(rows))));
}

void draw() {
  background(255);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(palette[grid[i][j]]);
      rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }

  // Each walker takes a random step
  for (PVector walker : walkers) {
    int xStep = floor(random(-1, 2));
    int yStep = floor(random(-1, 2));

    walker.x = constrain(walker.x + xStep, 0, cols - 1);
    walker.y = constrain(walker.y + yStep, 0, rows - 1);

    // The walker changes the color of the grid cell it lands on
    grid[(int)walker.x][(int)walker.y] = (grid[(int)walker.x][(int)walker.y] + 1) % palette.length;
  }

  // Occasionally add a new walker
  if (random(1) < 0.01) {
    walkers.add(new PVector(floor(random(cols)), floor(random(rows))));
  }

  // Occasionally remove a walker
  if (random(1) < 0.01 && walkers.size() > 1) {
    walkers.remove(floor(random(walkers.size())));
  }
}

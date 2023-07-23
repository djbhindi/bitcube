
// Tetris block patterns
int[][][] blocks = {
  {
    {1, 1, 1, 1}
  },
  {
    {1, 1},
    {1, 1}
  },
  {
    {1, 1, 0},
    {0, 1, 1}
  },
  {
    {0, 1, 1},
    {1, 1}
  },
  {
    {1, 1, 1},
    {0, 1, 0}
  },
};

// We will keep track of two blocks for each 8x8 area
int[][][][] currentBlocks = new int[4][2][][];
int[][] blockRows = new int[4][2];
int[][] blockCols = new int[4][2];
color[][] blockColors = new color[4][2];
final int cellSize = 20;

void setupTetris() {
  colorMode(HSB, 360, 100, 100);
  stroke(255);
  frameRate(2);

  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 2; j++) {
      spawnBlock(i, j);
      blockRows[i][j] = -j * 4;  // Stagger starting positions and increase space
    }
  }
}

void drawTetris() {
  background(0);

  for (int b = 0; b < 4; b++) {
    for (int s = 0; s < 2; s++) {
      fill(blockColors[b][s]);
      // Draw the current block
      for (int i = 0; i < currentBlocks[b][s].length; i++) {
        for (int j = 0; j < currentBlocks[b][s][i].length; j++) {
          if (currentBlocks[b][s][i][j] == 1) {
            rect((blockCols[b][s] + j) * cellSize, (blockRows[b][s] + i) * cellSize, cellSize, cellSize);
          }
        }
      }

      // Move the block down
      blockRows[b][s]++;

      // If the block has reached the bottom, spawn a new one
      if (blockRows[b][s] + currentBlocks[b][s].length > h) {
        spawnBlock(b, s);
        blockRows[b][s] = -s * 4;  // Reset staggered position and increase space
      }

      for (int i = 0; i < currentBlocks[b][s].length; i++) {
        for (int j = 0; j < currentBlocks[b][s][i].length; j++) {
          if (currentBlocks[b][s][i][j] == 1) {
            int row = blockRows[b][s] + i;
            int col = blockCols[b][s] + j;
            grid[row][col] = blockColors[b][s];
          }
        }
      }
    }
  }
}

void spawnBlock(int b, int s) {
  currentBlocks[b][s] = blocks[(int)random(blocks.length)];
  blockCols[b][s] = (int)random(6 - currentBlocks[b][s][0].length) + b * 8 + 2;  // Add space between blocks
  blockColors[b][s] = color(random(360), 100, 100); // Assign random color
}

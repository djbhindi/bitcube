

// Define the colors
color[] rainbowColors = new color[24];


void setupRainbow() {
  // Define the rainbow colors
  for (int i = 0; i < 24; i++) {
    float t = i / 24.0;
    rainbowColors[i] = color(127 + 127 * sin(TWO_PI * t),
                             127 + 127 * sin(TWO_PI * t + TWO_PI / 3),
                             127 + 127 * sin(TWO_PI * t + 2 * TWO_PI / 3));
  }
}

void drawRainbow() {
  background(0); // Black background

  // Increase the fade speed by 2
  int fadeSpeed = 24;
  int adjustedFadeSpeed = fadeSpeed / 2;

  // Draw a rainbow gradient from the two black cells
  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 8; j++) {
      // Calculate distance from the black cells
      int dist1 = abs(i - 4) + abs(j - 7); // Distance from bottom black cell
      int dist2 = abs(i - 4) + abs(j - 6); // Distance from second to bottom black cell

      // Use the smaller distance
      int dist = min(dist1, dist2);

      // Calculate color index based on distance and frameCount
      int colorIndex = (dist + (frameCount / adjustedFadeSpeed)) % 24;
      int nextColorIndex = (colorIndex + 1) % 24;

      // Calculate the blend factor
      float blend = (frameCount % adjustedFadeSpeed) / (float)adjustedFadeSpeed;

      // Blend the two colors
      color c = lerpColor(rainbowColors[colorIndex], rainbowColors[nextColorIndex], blend);

      // Draw the two black cells
      if (i == 4 && (j == 6 || j == 7)) {
        fill(0);
      }
      // Set the color for the other cells
      else {
        fill(c);
      }

      // Draw the cell
      //rect(i * cellSize, j * cellSize, cellSize, cellSize);
      grid[i][j] = c;
    }
  }
}

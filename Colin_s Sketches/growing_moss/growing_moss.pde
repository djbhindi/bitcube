int cols = 32;
int rows = 8;
int pixelSize = 20;
int gap = 2;
color[] colorScheme = { #20C9A2, #6EF7AF, #BDFEAF, #86D278, #43D856, #51FA23, #64D43E, #42C11D, #3A6738 };
float time = 0;
float increment = 0.002;  
float scale = 0.1;  // New variable to adjust the Perlin Noise scale

void settings() {
  size(cols * pixelSize, rows * pixelSize);
}

void setup() {
  noStroke();
}

void draw() {
  background(0);
  time += increment;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Adjusted the Perlin Noise input to include the scale variable
      int index = int(map(noise(i * scale, j * scale, time), 0, 1, 0, colorScheme.length));
      fill(colorScheme[index]);
      rect(i * pixelSize, j * pixelSize, pixelSize - gap, pixelSize - gap);
    }
  }
}

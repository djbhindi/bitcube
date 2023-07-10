import processing.sound.*;
SoundFile file;
FFT fft;
AudioIn in;
BeatDetector beat_detect;
final int BANDS = 512;
float[] spectrum = new float[BANDS];


// Sizing
final int PIXEL_SIZE = 20;
final int PIXEL_WIDTH = 32 * PIXEL_SIZE;
final int PIXEL_HEIGHT = 8 * PIXEL_SIZE;
final int SIDES = 4;
final int CELL_HEIGHT = 8;
final int CELL_WIDTH = CELL_HEIGHT * SIDES;

// Colors
final color[] orange_blue_scheme = {#8ECAE6, #219EBC, #FFB703, #FB8500, #023047};
final color[] marine_layer_scheme = {#0081A7, #00AFB9, #FDFCDC, #FED9B7, #F07167};
final color[] summer_scheme = {#F72585, #B5179E, #FDFCDC, #7209B7, #480CA8, #3A0CA3, #3F37C9, #4361EE, #4895EF, #4CC9F0};
final color[][] schemes = {
  orange_blue_scheme,
  summer_scheme,
  marine_layer_scheme
};
int color_scheme_index = 0;

// Parameters
int energy = 50;

color pickColor() {
  int index = int(random(0, schemes[color_scheme_index].length));
  return schemes[color_scheme_index][index];
}

color bkg = pickColor();
color fore = pickColor();

void switchScheme() {
  color_scheme_index = (color_scheme_index+ 1) % schemes.length;
}

int bpm = -1;
String str_num = "";

void keyPressed() {
  if ( key >= '0' && key <= '9' ) {
    str_num += key;
  }
  if ( key == ENTER || key == RETURN ) {
    bpm = int( str_num );
    str_num = "";
    println("BPM set to: ", bpm );
  }
  if (key == 'c' || key == 'C') {
    switchScheme();
  }
  if (key == 'w' || key == 'W') {
    energy = min(400, energy + 20);
  }
  if (key == 's' || key == 'S') {
    energy = max(50, energy - 20);
  }
  if (key == 'f' || key == 'F') {
    screenClear(false);
  } else if (key == 'g' || key == 'G') {
    screenClear(true);
  }

  if (key == ']') {
    mode = (mode + 1) % NUM_MODES;
  }
  if (key == '[') {
    mode = mode == 0 ? NUM_MODES - 1 : mode - 1;
  }
}

void screenClear(boolean random) {
  for (int i = 0; i < CELL_WIDTH; i++) {
    for (int j = 0; j < CELL_HEIGHT; j++) {
      if (random) {
        grid[i][j] = pickColor();
      } else {
        grid[i][j] = bkg;
      }
    }
  }
}

void setupReactive() {
  frameRate(16);

  fft = new FFT(this, BANDS);
  beat_detect = new BeatDetector(this);

  // Load a soundfile from the /data folder of the sketch and play it back
  //boolean recording = true;
  boolean recording = true;

  if (recording) {
    file = new SoundFile(this, "owl.wav");
    //file.rate(1.09);
    file.play();
    fft.input(file);
    beat_detect.input(file);
  } else {
    // patch the AudioIn
    in = new AudioIn(this, 0);
    in.start();
    in.play();
    fft.input(in);
    beat_detect.input(in);
  }

  grid = new color[CELL_WIDTH][CELL_HEIGHT];
}

void renderVisualizerSuite(float[] spectrum) {
  bkg = pickColor();

  for (int i = 0; i < CELL_WIDTH; i++) {
    int freq_index = (i % (CELL_WIDTH / SIDES)) * (BANDS / (CELL_HEIGHT * 8));

    // Decide how many boxes we'll color in for this.
    int boxes = int(min(spectrum[freq_index] * energy, CELL_HEIGHT));

    // Color in foreground, changing color every two columns.
    if (i % 2 == 0) {
      fore = pickColor();
    }
    for (int j = 0; j < boxes; j++) {
      grid[i][j] = fore;
    }

    // Color in background on beats for a neater effect.
    if (beat_detect.isBeat()) {
      println("BEAT", frameCount);
      for (int j2 = boxes; j2 < CELL_HEIGHT; j2 ++) {
        grid[i][j2] = bkg;
      }
    }
  }
}

void drawReactive() {
  // Maybe only draw on frames that are on-beat?
  if (bpm > 0) {
    println("mod is: ", int(frameRate / (bpm / 60)));
    if (frameCount % int(frameRate / (bpm / 60)) != 0) {
      return;
    }
  }


  fft.analyze(spectrum);
  renderVisualizerSuite(spectrum);
}

// reactive
import processing.sound.*;

public class ReactiveDrawing extends BitDrawing {
  // Sizing
  final int SIDES = 4;
  final int CELL_HEIGHT = 8;
  final int CELL_WIDTH = CELL_HEIGHT * SIDES;
  final int BANDS = 512;

  // Sound setup
  FFT fft;
  SoundFile file;
  AudioIn in;
  BeatDetector beat_detect;
  float[] spectrum = new float[BANDS];

  public ReactiveDrawing(PApplet p) {
    // TODO: Put this in a try/catch.
    file = new SoundFile(p, "wilay.wav");
    fft = new FFT(p, BANDS);
    in = new AudioIn(p, 0);
    beat_detect = new BeatDetector(p);
  }

  // Colors
  final color[] orange_blue_scheme = {#8ECAE6, #219EBC, #FFB703, #FB8500, #023047};
  final color[] marine_layer_scheme = {#0081A7, #00AFB9, #FDFCDC, #FED9B7, #F07167};
  final color[] summer_scheme = {#F72585, #B5179E, #FDFCDC, #7209B7, #480CA8, #3A0CA3, #3F37C9, #4361EE, #4895EF, #4CC9F0};
  final color[][] schemes = {
    summer_scheme,
    orange_blue_scheme,
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

  void keyHandle(char key) {
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
  }



  int bpm = -1;
  String str_num = "";

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

  void setupDrawing() {
    // TODO: Refactor this to the per-scheme initialization.
    frameRate(16);

    // Load a soundfile from the /data folder of the sketch and play it back
    boolean recording = true;

    if (recording) {
      file.play();
      fft.input(file);
      beat_detect.input(file);
    } else {
      in.start();
      in.play();
      fft.input(in);
      beat_detect.input(in);
    }
  }

  void renderVisualizerSuite(float[] spectrum, color[][] grid) {
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

  public void renderDrawing(color[][] grid) {
    // Maybe only draw on frames that are on-beat?
    if (bpm > 0) {
      println("mod is: ", int(frameRate / (bpm / 60)));
      if (frameCount % int(frameRate / (bpm / 60)) != 0) {
        return;
      }
    }


    fft.analyze(spectrum);
    renderVisualizerSuite(spectrum, grid);
  }
}

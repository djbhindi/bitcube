//ArtNet
//TODO Handle aribitrary numbers of universes

import ch.bildspur.artnet.*;

ArtNetClient artnet;
byte[][] dmxData = new byte[2][512]; // Two universes

void setupArtNet() {
  artnet = new ArtNetClient(null);
  artnet.start();
}

void updateDMX() {
  int universe = 0;
  int index = 0;
  for (int i = 0; i < w * h; i++) {
    if (index / 3 >= 170) {
      universe = 1;
      index = 0;
    }

    int x = i % w;
    int y = i / w;

    dmxData[universe][index++] = (byte)red(grid[x][y]);
    dmxData[universe][index++] = (byte)green(grid[x][y]);
    dmxData[universe][index++] = (byte)blue(grid[x][y]);
  }

  artnet.unicastDmx(artnetIP, 0, 0, dmxData[0]);
  artnet.unicastDmx(artnetIP, 0, 1, dmxData[1]);
}

void stopArtNet() {
  artnet.stop();
}

void updateDMXserpentine() {
  // Clear previous DMX data
  for (int u = 0; u < 2; u++) {
    for (int i = 0; i < 512; i++) {
      dmxData[u][i] = 0;
    }
  }

  int universe = 0;
  int index = 0;
  for (int i = 0; i < w; i++) {
    for (int j = (i % 2 == 0) ? 0 : h - 1; (i % 2 == 0) ? j < h : j >= 0; j += (i % 2 == 0) ? 1 : -1) {
      // If we exceed 170 values (170 * 3 = 510 because 3 values per pixel), switch to the second universe
      if (index / 3 >= 170) {
        universe = 1;
        index = 0;
      }

      // Update DMX data
      dmxData[universe][index++] = (byte) red(grid[i][j]);
      dmxData[universe][index++] = (byte) green(grid[i][j]);
      dmxData[universe][index++] = (byte) blue(grid[i][j]);
    }
  }

  // Send DMX data to two different universes
  artnet.unicastDmx(artnetIP, 0, 0, dmxData[0]);
  artnet.unicastDmx(artnetIP, 0, 1, dmxData[1]); // universe 1
  artnet.unicastDmx(artnetIP, 0, 999, dmxData[1]); // universe 1
}

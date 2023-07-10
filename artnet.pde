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

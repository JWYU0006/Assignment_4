//initialization function
//There are a * b tiles, so a binary function is used.
TileGrass[][] tileGrassArray = new TileGrass[tileNumberXSetting][tileNumberYSetting];
void tileGrassArrayInitialization() {
  for (int a = 0; a < tileNumberXSetting; a++) {
    for (int b = 0; b < tileNumberYSetting; b++) {
      tileGrassArray[a][b] = new TileGrass();
      tileGrassArray[a][b].generateThreeGrass();
    }
  }
}

//one grass
class Grass {
  int grassX;        //center point of the grass
  int grassY;

  void generateGrassPosition() {
    grassX = (int)random(grassWidthSetting/2, 21 - grassWidthSetting/2);        //The center point of the grass must be at least half the width away from the edge of the tile.
    grassY = (int)random(0, 21);
  }
}

//three grass in each tile
class TileGrass {
  Grass[] grassArray = new Grass[grassDensitySetting];

  void generateThreeGrass() {
    for (int i = 0; i < grassDensitySetting; i++) {
      grassArray[i] = new Grass();
      grassArray[i].generateGrassPosition();
    }
  }

  void drawThreeGrass(int tileXPosition, int tileYPosition) {
    //Use the sine function to simulate left and right movement.
    for (Grass g : grassArray) {
      fill(80, 140, 60);          //grass color
      rect(tileXPosition + g.grassX - grassWidthSetting/2, tileYPosition + g.grassY - grassHeightSetting/3, grassWidthSetting, grassHeightSetting/3);
      rect(tileXPosition + g.grassX - grassWidthSetting/2 + grassWidthSetting/4 + grassWidthSetting/4*sin(frameCount/20), tileYPosition + g.grassY - grassHeightSetting/1.5, grassWidthSetting/2, grassHeightSetting/3);
      rect(tileXPosition + g.grassX - grassWidthSetting/2 + grassWidthSetting/4*1.5 + grassWidthSetting/4*1.5*sin(frameCount/20), tileYPosition + g.grassY - grassHeightSetting, grassWidthSetting/4, grassHeightSetting/3);
      fill(0, 20);        //shadow color
      rect(tileXPosition + g.grassX - grassWidthSetting/2, tileYPosition + g.grassY, grassWidthSetting, 2);
    }
  }
}

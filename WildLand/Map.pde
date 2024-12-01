int mapStartPositionX = 400 - tileNumberXSetting/2*20;        //top left border point
int mapStartPositionY = 400 - tileNumberYSetting/2*20;
int mapCenterPositionX = tileNumberXSetting/2*20 - 400;        //center point
int mapCenterPositionY = tileNumberYSetting/2*20 - 400;

void drawMap() {
  //draw ground tile
  //Use two nested for loops to draw a square map made up of multiple tiles
  background(200, 100, 100);
  fill(60, 110, 40);        //ground color
  mapStartPositionX -= player.playerVelocityPV.x;        //Move the ground to make the character appear to be moving
  mapStartPositionY -= player.playerVelocityPV.y;
  mapCenterPositionX -= player.playerVelocityPV.x;
  mapCenterPositionY -= player.playerVelocityPV.y;

  for (int a = 0; a < tileNumberXSetting; a++) {
    for (int b = 0; b < tileNumberYSetting; b++) {
      fill(60, 110, 40);        //ground color
      rect(mapStartPositionX + a*20, mapStartPositionY + b*20, 20, 20);        //draw ground
      tileGrassArray[a][b].drawThreeGrass(mapStartPositionX + a*20, mapStartPositionY + b*20);        //draw grass
    }
  }
}

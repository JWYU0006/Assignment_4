//It is just a born place showing on the map
float rectX = 200;
float rectY = 200;

class Environment {
  //call in draw()
  void environmentFunction() {
    drawGroundMap(player.playerPV.x, player.playerPV.y);
  }

  void drawGroundMap(float vectorX, float vectorY) {
    rectX -= vectorX;
    rectY -= vectorY;
    fill(200, 100, 100);
    rect(rectX, rectY, 50, 50);
    fill(100, 200, 100);
    rect(rectX, rectY, 20, 20);
  }
}

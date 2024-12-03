ArrayList<Tower> towerArrayList;

//initialize a new tower arraylist to store towers that would be built
void towerArrayListInitialization() {
  towerArrayList = new ArrayList<Tower>();
}

class Tower {
  PVector towerPositionPV = new PVector();
  int towerAttackframeRecord;
  float distanceMonster;

  Tower (float x, float y) {
    towerPositionPV.x = x;
    towerPositionPV.y = y;
    distanceMonster = 0;
  }

  void towerFunction() {
    drawTower();
  }

  void drawTower() {
    fill(150);
    towerPositionPV.x -= player.playerVelocityPV.x;
    towerPositionPV.y -= player.playerVelocityPV.y;
    rect(towerPositionPV.x - towerWidthSetting/2, towerPositionPV.y - towerHeightSetting, towerWidthSetting, towerHeightSetting);
  }

  void attackMonster() {
    for (Monster m : monsterArrayList) {
      float tempDistance = dist(towerPositionPV.x, towerPositionPV.y, m.monsterCurrentCenterXI, m.monsterGenerationYI);
      if (tempDistance > distanceMonster) {
        distanceMonster = tempDistance;
      }
    }
  }
}

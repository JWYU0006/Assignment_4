ArrayList<Tower> towerArrayList; //<>//

//initialize a new tower arraylist to store towers that would be built
void towerArrayListInitialization() {
  towerArrayList = new ArrayList<Tower>();
}

class Tower {
  PVector towerPositionPV = new PVector();        //tower bottem center point position
  int towerAttackframeRecord;        //last attack frame number

  Tower (float x, float y) {
    towerPositionPV.x = x;
    towerPositionPV.y = y;
  }

  //called in draw()
  void towerFunction() {
    drawTower();
    if (frameCount - towerAttackframeRecord >= 30) {        //trigger attack function per 30 frame
      attackMonster();
      towerAttackframeRecord = frameCount;        //store frame when attack
    }
  }

  void drawTower() {
    fill(150);
    towerPositionPV.x -= player.playerVelocityPV.x;        //when player move, tower move opposite
    towerPositionPV.y -= player.playerVelocityPV.y;
    rect(towerPositionPV.x - towerWidthSetting/2, towerPositionPV.y - towerHeightSetting, towerWidthSetting, towerHeightSetting);        //draw tower, calculate top left point position.
    fill(200, 50, 50);
    ellipse(towerPositionPV.x, towerPositionPV.y - towerHeightSetting, 20, 20);        //draw red ball on the top of the tower
  }

  void attackMonster() {
    Monster tempM = null;        //declare a monster to store the monster object needed
    float tempDistance = 0;        //store each distance
    float distanceMonster = 10000;        //store nearest monster distance, default value ensure functioning correct
    for (Monster m : monsterArrayList) {
      tempDistance = dist(towerPositionPV.x, towerPositionPV.y - towerHeightSetting, m.monsterCurrentCenterXI, m.monsterCurrentCenterYI);
      if (tempDistance < distanceMonster) {        //search the nearest monster
        distanceMonster = tempDistance;
        tempM = m;
      }
    }
    Bullet b = new Bullet(towerPositionPV.x, towerPositionPV.y - towerHeightSetting);
    b.bulletCurrentPositionPV.set(towerPositionPV.x, towerPositionPV.y - towerHeightSetting);
    b.bulletSpeedPV.set(10/distanceMonster*(tempM.monsterCurrentCenterXI - towerPositionPV.x), 10/distanceMonster*(tempM.monsterCurrentCenterYI - towerPositionPV.y + towerHeightSetting));        //calculate the speed by triangle ratio
    b.bulletAcceleration.set(b.bulletSpeedPV.x/300, b.bulletSpeedPV.y/300);
    bulletArrayList.add(b);
    println(distanceMonster);
    println(tempM.monsterCurrentCenterXI, tempM.monsterCurrentCenterYI);
  }
}

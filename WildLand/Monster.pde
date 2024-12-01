ArrayList<Monster> monsterArrayList;

//call once
//first wave of monster
void monsterArrayInitialization() {
  monsterArrayList = new ArrayList<Monster>(monsterAmountSetting);
  for (int i = 0; i < monsterAmountSetting; i++) {
    monsterArrayList.add(new Monster());
    monsterArrayList.get(i).monsterID = i;
    monsterArrayList.get(i).monsterInitialization();
  }
}

//add new monster into monsterArrayList
void newMonsterWave(int amount) {
  for (int i = 1; i <= amount; i++) {
    Monster m = new Monster();
    m.monsterID = monsterAmountSetting + i;
    m.monsterInitialization();
    monsterArrayList.add(m);
  }
}

class Monster {
  int monsterID;
  //int monsterMaxHPI = monsterHPSetting;
  //int monsterCurrentHPI = monsterMaxHPI;
  int lastAttackTime = 0;
  int monsterSpeedI = monsterSpeedSetting;
  int monsterGenerationXI;        //generateMonsterPosition()
  int monsterGenerationYI;
  int monsterDirectionXI = 0;        //direction in x, y axis, these ints can be 1, 0, -1
  int monsterDirectionYI = 0;
  float monsterVectorXF = 0;        //equals to monsterVector
  float monsterVectorYF = 0;
  PVector monsterPV = new PVector(0, 0);
  int monsterCurrentCenterXI;        //current monster center position
  int monsterCurrentCenterYI;
  int monsterCollisionPlayerDetectionXI;        //which edge is used for collision detection with player
  int monsterCollisionPlayerDetectionYI;
  int monsterCollisionMonsterDetectionXI;        //which edge is used for collision detection with other monsters
  int monsterCollisionMonsterDetectionYI;
  boolean monsterBlockedX = true;
  boolean monsterBlockedY = true;
  int playerCollisionCenterXI = 400;        //current player center position, monster continuously move towards player's position
  int playerCollisionCenterYI = 380 + playerHeightSetting/2 - playerWidthSetting/2;        //player's collision box is a square with a side length of 20 (player's width)
  int playerCollisionDetectionXI;        //which edge is used for collision detection
  int playerCollisionDetectionYI;

  //call once
  void monsterInitialization() {
    generateMonsterPosition();
  }

  //call in draw()
  void monsterFunction() {
    setMonsterDirection();
    setMonsterVector();
    drawMonster();
  }

  //where the monster spawns
  void generateMonsterPosition() {
    switch((int)random(1, 5)) {        //4 borders of the map
    case 1:        //top
      monsterGenerationYI = mapStartPositionY;
      monsterGenerationXI = (int)random(mapStartPositionX, mapStartPositionX + tileNumberXSetting*20 - monsterWidthSetting);
      break;
    case 2:        //bottom
      monsterGenerationYI = mapStartPositionY + tileNumberYSetting*20;
      monsterGenerationXI = (int)random(mapStartPositionX, mapStartPositionX + tileNumberXSetting*20 - monsterWidthSetting);
      break;
    case 3:        //left
      monsterGenerationXI = mapStartPositionX;
      monsterGenerationYI = (int)random(mapStartPositionY, mapStartPositionY + tileNumberYSetting*20 - monsterHeightSetting);
      break;
    case 4:        //right
      monsterGenerationXI = mapStartPositionX + tileNumberXSetting*20;
      monsterGenerationYI = (int)random(mapStartPositionY, mapStartPositionY + tileNumberYSetting*20 - monsterHeightSetting);
      break;
    }
    monsterCurrentCenterXI = monsterGenerationXI + monsterWidthSetting/2;
    monsterCurrentCenterYI = monsterGenerationYI + monsterHeightSetting/2;
  }

  //this part is shown in the image
  void setMonsterDirection() {
    //detect collision with other monsters
    for (Monster m : monsterArrayList) {        //x blocked or not
      if (m.monsterID == monsterID) {        //don't detect collision with itself
        continue;
      }
      if (m.monsterCurrentCenterYI > monsterCurrentCenterYI - monsterHeightSetting && m.monsterCurrentCenterYI < monsterCurrentCenterYI + monsterHeightSetting) {
        if (monsterCurrentCenterXI > playerCollisionDetectionXI        //monster is to the right of the player
          && m.monsterCurrentCenterXI >= monsterCurrentCenterXI - monsterWidthSetting && m.monsterCurrentCenterXI <= monsterCurrentCenterXI) {
          monsterBlockedX = true;
          break;
        } else if (monsterCurrentCenterXI < playerCollisionDetectionXI        //monster is to the left of the player
          && m.monsterCurrentCenterXI <= monsterCurrentCenterXI + monsterWidthSetting && m.monsterCurrentCenterXI >= monsterCurrentCenterXI) {
          monsterBlockedX = true;
          break;
        }
      }
      monsterBlockedX = false;
    }

    for (Monster m : monsterArrayList) {        //y blocked or not
      if (m.monsterID == monsterID) {        //don't detect collision with itself
        continue;
      }
      if (m.monsterCurrentCenterXI > monsterCurrentCenterXI - monsterWidthSetting && m.monsterCurrentCenterXI < monsterCurrentCenterXI + monsterWidthSetting) {
        if (monsterCurrentCenterYI < playerCollisionDetectionYI        //monster is above the player
          && m.monsterCurrentCenterYI <= monsterCurrentCenterYI + monsterHeightSetting && m.monsterCurrentCenterYI >= monsterCurrentCenterYI) {
          monsterBlockedY = true;
          break;
        } else if (monsterCurrentCenterYI > playerCollisionDetectionYI        //monster is below the player
          && m.monsterCurrentCenterYI >= monsterCurrentCenterYI - monsterHeightSetting && m.monsterCurrentCenterYI <= monsterCurrentCenterYI) {
          monsterBlockedY = true;
          break;
        }
      }
      monsterBlockedY = false;
    }

    //detect collision with player
    if (monsterCurrentCenterXI > playerCollisionCenterXI) {
      monsterCollisionPlayerDetectionXI = monsterCurrentCenterXI - monsterWidthSetting/2;        //monster is to the right of the player
      playerCollisionDetectionXI = playerCollisionCenterXI + playerWidthSetting/2;
      if (monsterCollisionPlayerDetectionXI > playerCollisionDetectionXI && !monsterBlockedX) {
        monsterDirectionXI = -1;        //move left
      } else {
        monsterDirectionXI = 0;
      }
    } else if (monsterCurrentCenterXI < playerCollisionCenterXI) {
      monsterCollisionPlayerDetectionXI = monsterCurrentCenterXI + monsterWidthSetting/2;        //monster is to the left of the player
      playerCollisionDetectionXI = playerCollisionCenterXI - playerWidthSetting/2;
      if (monsterCollisionPlayerDetectionXI < playerCollisionDetectionXI && !monsterBlockedX) {
        monsterDirectionXI = 1;        //move right
      } else {
        monsterDirectionXI = 0;
      }
    } else {
      monsterDirectionXI = 0;
    }
    if (monsterCurrentCenterYI > playerCollisionCenterYI) {
      monsterCollisionPlayerDetectionYI = monsterCurrentCenterYI - monsterHeightSetting/2;        //monster is below the player
      playerCollisionDetectionYI = playerCollisionCenterYI + playerWidthSetting/2;
      if (monsterCollisionPlayerDetectionYI > playerCollisionDetectionYI && !monsterBlockedY) {
        monsterDirectionYI = -1;        //move up
      } else {
        monsterDirectionYI = 0;
      }
    } else if (monsterCurrentCenterYI < playerCollisionCenterYI) {
      monsterCollisionPlayerDetectionYI = monsterCurrentCenterYI + monsterHeightSetting/2;        //monster is above the player
      playerCollisionDetectionYI = playerCollisionCenterYI - playerWidthSetting/2;
      if (monsterCollisionPlayerDetectionYI < playerCollisionDetectionYI && !monsterBlockedY) {
        monsterDirectionYI = 1;        //move down
      } else {
        monsterDirectionYI = 0;
      }
    } else {
      monsterDirectionYI = 0;
    }
    //If the monster collides with the player, it can attack.
    if (monsterDirectionXI == 0 && monsterDirectionYI == 0 && millis() >= lastAttackTime + 2000
      && abs(monsterCurrentCenterXI - 400) <= playerWidthSetting/2 + monsterWidthSetting/2
      && abs(monsterCurrentCenterYI - (380 + playerHeightSetting/2 - playerWidthSetting/2)) <= playerWidthSetting/2 + monsterHeightSetting/2) {
      lastAttackTime = millis();
      player.playerCurrentHPI = constrain(player.playerCurrentHPI - 20, 0, player.playerMaxHPI);
    }
  }

  void setMonsterVector() {
    if (monsterDirectionXI == 0 && monsterDirectionYI != 0) {
      monsterVectorYF = monsterSpeedI;
    } else if (monsterDirectionYI == 0 && monsterDirectionXI != 0) {
      monsterVectorXF = monsterSpeedI;
    } else if (monsterDirectionXI != 0 && monsterDirectionYI != 0) {
      monsterVectorXF = monsterVectorYF = monsterSpeedI;
    } else {
      monsterVectorXF = monsterVectorYF = 0;
    }
    monsterPV.set(monsterDirectionXI * monsterVectorXF, monsterDirectionYI * monsterVectorYF);        //multiply speed by 1 or -1
  }

  void drawMonster() {
    monsterCurrentCenterXI -= player.playerVelocityPV.x - monsterPV.x;
    monsterCurrentCenterYI -= player.playerVelocityPV.y - monsterPV.y;
    int x = monsterCurrentCenterXI - monsterWidthSetting/2;        //top left point of the collision box
    int y = monsterCurrentCenterYI - monsterHeightSetting/2;
    for (MonsterPixel mpEach : mp) {
      fill(mpEach.monsterPixelColor);
      rect(x - 1 + mpEach.monsterPixelRowPixels[0], y - 1 + mpEach.monsterPixelRowNumber, mpEach.monsterPixelRowPixels[1] - mpEach.monsterPixelRowPixels[0] + 1, 1);
    }
  }
}

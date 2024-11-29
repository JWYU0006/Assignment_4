class Player {
  int playerMaxHPI = 100;
  int playerCurrentHPI = playerMaxHPI;
  float playerSpeedF = playerSpeedSetting;        //characterSpeed input value
  int playerDirectionXI = 0;        //direction in x, y axis, these ints can be 1, 0, -1
  int playerDirectionYI = 0;
  float playerVectorXF = 0;        //a point on circle corresponding to an x and y (= characterVectorSpeed)
  float playerVectorYF = 0;
  //vector = direction * speed
  PVector playerPV = new PVector(0, 0);
  int mouseXToPlayerI;
  int mouseYToPlayerI;
  float weaponEndPointXF;
  float weaponEndPointYF;
  int weaponLength = 20;

  //run this function make Character system work
  void playerFunction() {
    playerSpeedF = playerSpeedSetting;
    drawPlayer();
    setPlayerVector();
  }

  void drawPlayer() {
    //hp
    fill(255);
    rect(180, 170, 40, 10);
    fill(150, 0, 0);
    rect(180, 170, map(playerCurrentHPI, 0, playerMaxHPI, 0, 40), 10);
    //body
    fill(255);
    if (playerCurrentHPI == 0) {
      fill(150, 0, 0);
    }
    rect(200 - playerWidthSetting/2, 200 - playerHeightSetting/2, playerWidthSetting, playerHeightSetting);
    //weapon
    strokeWeight(10);
    stroke(100);
    mouseXToPlayerI = mouseX - 200;
    mouseYToPlayerI = mouseY - 200;
    weaponEndPointXF = mouseXToPlayerI * weaponLength / sqrt(mouseXToPlayerI*mouseXToPlayerI + mouseYToPlayerI*mouseYToPlayerI);
    weaponEndPointYF = mouseYToPlayerI * weaponLength / sqrt(mouseXToPlayerI*mouseXToPlayerI + mouseYToPlayerI*mouseYToPlayerI);
    line(200, 200, 200 +  weaponEndPointXF, 200 + weaponEndPointYF);
    noStroke();
  }

  //when moving 45° up-right, x and y = √((characterSpeed^2)/2), when moving right, x = characterSpeed;
  void setPlayerVector() {
    if (playerDirectionXI == 0 && playerDirectionYI != 0) {
      playerVectorYF = playerSpeedF;
    } else if (playerDirectionYI == 0 && playerDirectionXI != 0) {
      playerVectorXF = playerSpeedF;
    } else if (playerDirectionXI != 0 && playerDirectionYI != 0) {
      //Due to float precision errors causing gaps at the edges, the diagonal speed must be changed to an integer.
      //characterVectorSpeedX = characterVectorSpeedY = 1.4;        //sqrt(characterSpeed*characterSpeed/2) ≈ 1.4
      playerVectorXF = playerVectorYF = playerSpeedF;
    } else {
      playerVectorXF = playerVectorYF = 0;
    }
    playerPV.set(playerDirectionXI * playerVectorXF, playerDirectionYI * playerVectorYF);
  }

  //detect key, set playerDirection
  void movementKeyPressed() {
    switch(key) {
    case 'w' :
      playerDirectionYI = -1;
      break;
    case 's':
      playerDirectionYI = 1;
      break;
    case 'a' :
      playerDirectionXI = -1;
      break;
    case 'd':
      playerDirectionXI = 1;
      break;
    }
    if (key == CODED && keyCode == SHIFT) {
      playerSpeedSetting = 4;
    }
  }

  //detect key, initialize playerDirection
  void movementKeyReleased() {
    switch(key) {
    case 'w' :
      if (playerDirectionYI == -1)        //When press another key before release the key, player will stop.
        playerDirectionYI = 0;            //For example, press a, move left, press d, move right, release a, player stops, but d is still pressed.
      break;
    case 's':
      if (playerDirectionYI == 1)
        playerDirectionYI = 0;
      break;
    case 'a' :
      if (playerDirectionXI == -1)
        playerDirectionXI = 0;
      break;
    case 'd':
      if (playerDirectionXI == 1)
        playerDirectionXI = 0;
      break;
    }
    if (key == CODED && keyCode == SHIFT) {
      playerSpeedSetting = 2;
    }
  }

  //shoot
  void shoot() {
    if (mouseButton == LEFT) {
      Bullet b = new Bullet();
      b.generateBullet(weaponEndPointXF, weaponEndPointYF);
      bulletArrayList.add(b);
    }
  }
}

class Player { //<>// //<>// //<>//
  int playerMaxHPI = 100;
  int playerCurrentHPI = playerMaxHPI;
  PVector playerDirectionPV = new PVector(0, 0);        //determine which direction of image is used
  PVector playerVelocityPV = new PVector(0, 0);        //player move's direction and speed, it's player's velocity
  int mouseXToPlayerI;
  int mouseYToPlayerI;
  float weaponEndPointXF;
  float weaponEndPointYF;
  int weaponLength = 20;

  PImage playerImage;        //show player's current image
  String playerImageFileName = "player_front_idle.png";        //which image fine should be used, default value is front idle
  PVector imageCenterOffset = new PVector(-15, -44);        //store image offset to make image in center, default value is offset of default image
  int startMeleeAttack = 0;        //store frameCount - when player start melee attack animation
  Boolean meleeAttackBoolean = false;        //player's melee attack state, is in melee attack animation or not

  Boolean buildModeB = false;

  //run this function make Character system work
  void playerFunction() {
    drawPlayer();
    if (buildModeB) {        //if buildMode is on, activate function
      buildMode();
    }
  }

  void drawPlayer() {
    //calculate direction, y=x and y = -x +800, two lines intersect at (400,400), divide screen into 4 area
    if (mouseY <= mouseX && mouseY >= -mouseX + 800) {        //right area, set direction to right, which means x=1, y=0
      playerDirectionPV.x = 1;
      playerDirectionPV.y = 0;
      playerImageFileName = "player_right_idle.png";        //set corresponding image
    } else if (mouseY <= -mouseX + 800 && mouseY >= mouseX) {        //left area
      playerDirectionPV.x = -1;
      playerDirectionPV.y = 0;
      playerImageFileName = "player_left_idle.png";
    } else if (mouseX >= mouseY && mouseX <= 800-mouseY) {        //top area
      playerDirectionPV.y = -1;
      playerDirectionPV.x = 0;
      playerImageFileName = "player_back_idle.png";
    } else {        //bottom area
      playerDirectionPV.y = 1;
      playerDirectionPV.x = 0;
      playerImageFileName = "player_front_idle.png";
    }
    //hp bar
    fill(255);
    rect(380, 340, 40, 10);        //hp limit bar
    fill(150, 0, 0);
    rect(380, 340, map(playerCurrentHPI, 0, playerMaxHPI, 0, 40), 10);        //current hp
    //body - collision box
    //fill(255);
    //rect(400 - playerWidthSetting/2, 380 - playerHeightSetting/2, playerWidthSetting, playerHeightSetting);
    //trigger player melee attack
    playerMeleeAttackAnimation();
    playerImage = loadImage(playerImageFileName);
    image(playerImage, 400 + imageCenterOffset.x, 400 + imageCenterOffset.y);
    //weapon - gun
    strokeWeight(10);
    stroke(100);
    mouseXToPlayerI = mouseX - 400;
    mouseYToPlayerI = mouseY - 380;
    weaponEndPointXF = mouseXToPlayerI * weaponLength / sqrt(mouseXToPlayerI*mouseXToPlayerI + mouseYToPlayerI*mouseYToPlayerI);
    weaponEndPointYF = mouseYToPlayerI * weaponLength / sqrt(mouseXToPlayerI*mouseXToPlayerI + mouseYToPlayerI*mouseYToPlayerI);
    line(400, 380, 400 +  weaponEndPointXF, 380 + weaponEndPointYF);
    noStroke();
  }

  //detect key, set playerDirection
  void movementKeyPressed() {
    switch(key) {
    case 'w' :
      playerVelocityPV.y = -2;
      break;
    case 's':
      playerVelocityPV.y = 2;
      break;
    case 'a' :
      playerVelocityPV.x = -2;
      break;
    case 'd':
      playerVelocityPV.x = 2;
      break;
    }
  }

  //detect key, initialize playerDirection
  void movementKeyReleased() {
    switch(key) {
    case 'w' :
      if (playerVelocityPV.y == -2)        //When press another key before release the key, player will stop.
        playerVelocityPV.y = 0;            //For example, press a, move left, press d, move right, release a, player stops, but d is still pressed.
      break;
    case 's':
      if (playerVelocityPV.y == 2)
        playerVelocityPV.y = 0;
      break;
    case 'a' :
      if (playerVelocityPV.x == -2)
        playerVelocityPV.x = 0;
      break;
    case 'd':
      if (playerVelocityPV.x == 2)
        playerVelocityPV.x = 0;
      break;
    case 'r':
      if (buildModeB == false && material >= 20) {
        buildModeB = true;        //if buildMode is off and have enough material, press r to turn it on
      } else {
        buildModeB= false;        //if buildMode is on, press r to turn it off.
      }
      break;
    }
  }

  //shoot
  void shoot() {
    if (mouseButton == LEFT) {
      Bullet b = new Bullet(weaponEndPointXF, weaponEndPointYF);
      bulletArrayList.add(b);
      gunSound.play();        //play gun shot sound
    }
  }

  void buildMode() {
    fill(150, 150);        //draw a transparent tower to preview position
    rect(mouseX - towerWidthSetting/2, mouseY - towerHeightSetting, towerWidthSetting, towerHeightSetting);
    if (keyPressed && key == ' ') {        //if press space in build mode, create a new tower stored in towerArrayList
      Tower t = new Tower(mouseX, mouseY);        //create a tower object and pass the mouse position into constructor
      towerArrayList.add(t);        //add the tower into towerArrayList to iterate
      buildModeB = false;        //turn build mode off after build one tower
      material -= 20;        //subtract 20 material points after build one tower
    }
  }

  //melee attack animation and function
  void playerMeleeAttackAnimation() {
    //when press right and player is not in attack animation
    if (mousePressed && mouseButton == RIGHT && meleeAttackBoolean == false
      && (playerImageFileName == "player_front_idle.png" || playerImageFileName == "player_back_idle.png"
      || playerImageFileName == "player_left_idle.png" || playerImageFileName == "player_right_idle.png")) {
      startMeleeAttack = frameCount;        //store when start attack animation by frameCount
      meleeAttackBoolean = true;
    }
    if (playerDirectionPV.y == 1 && meleeAttackBoolean == true) {        //when player face down and trigger melee attack, totally 4 direction if, same logic
      if (0<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 1) {        //change animation image per 2 frame
        playerImageFileName = "player_front_attack_0.png";
        imageCenterOffset.x = -33;        //offset to locate center point and align collision box with image
        imageCenterOffset.y = -46;
      } else if (2<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 3) {
        playerImageFileName = "player_front_attack_1.png";
        imageCenterOffset.x = -43;
        imageCenterOffset.y = -42;
      } else if (4<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 5) {
        playerImageFileName = "player_front_attack_2.png";
        imageCenterOffset.x = -39;
        imageCenterOffset.y = -40;
      } else if (6<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 7) {
        playerImageFileName = "player_front_attack_3.png";
        imageCenterOffset.x = -39;
        imageCenterOffset.y = -42;
      } else if (8<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 9) {
        playerImageFileName = "player_front_attack_4.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (10<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 11) {
        playerImageFileName = "player_front_attack_5.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (12<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 13) {
        playerImageFileName = "player_front_attack_6.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        //playerMeleeAttackDamage(playerDirectionPV);        //trigger damage function
      } else {
        playerImageFileName = "player_front_idle.png";        //animation ends, resume idle
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        meleeAttackBoolean = false;
      }
    } else if (playerDirectionPV.y == -1 && meleeAttackBoolean == true) {        //when player face up and trigger melee attack
      if (0<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 1) {
        playerImageFileName = "player_back_attack_0.png";
        meleeAttackBoolean = true;
        imageCenterOffset.x = -17;
        imageCenterOffset.y = -42;
      } else if (2<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 3) {
        playerImageFileName = "player_back_attack_1.png";
        imageCenterOffset.x = -33;
        imageCenterOffset.y = -62;
      } else if (4<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 5) {
        playerImageFileName = "player_back_attack_2.png";
        imageCenterOffset.x = -37;
        imageCenterOffset.y = -64;
      } else if (6<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 7) {
        playerImageFileName = "player_back_attack_3.png";
        imageCenterOffset.x = -37;
        imageCenterOffset.y = -64;
      } else if (8<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 9) {
        playerImageFileName = "player_back_attack_4.png";
        imageCenterOffset.x = -37;
        imageCenterOffset.y = -44;
      } else if (10<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 11) {
        playerImageFileName = "player_back_attack_5.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (12<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 13) {
        playerImageFileName = "player_back_attack_6.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        //playerMeleeAttackDamage(playerDirectionPV);
      } else {
        playerImageFileName = "player_back_idle.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        meleeAttackBoolean = false;
      }
    } else if (playerDirectionPV.x == -1 && meleeAttackBoolean == true) {        //when player face left and trigger melee attack
      if (0<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 1) {
        playerImageFileName = "player_left_attack_0.png";
        meleeAttackBoolean = true;
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (2<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 3) {
        playerImageFileName = "player_left_attack_1.png";
        imageCenterOffset.x = -57;
        imageCenterOffset.y = -44;
      } else if (4<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 5) {
        playerImageFileName = "player_left_attack_2.png";
        imageCenterOffset.x = -59;
        imageCenterOffset.y = -44;
      } else if (6<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 7) {
        playerImageFileName = "player_left_attack_3.png";
        imageCenterOffset.x = -59;
        imageCenterOffset.y = -44;
      } else if (8<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 9) {
        playerImageFileName = "player_left_attack_4.png";
        imageCenterOffset.x = -37;
        imageCenterOffset.y = -44;
      } else if (10<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 11) {
        playerImageFileName = "player_left_attack_5.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (12<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 13) {
        playerImageFileName = "player_left_attack_6.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        //playerMeleeAttackDamage(playerDirectionPV);
      } else {
        playerImageFileName = "player_left_idle.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        meleeAttackBoolean = false;
      }
    } else if (playerDirectionPV.x == 1 && meleeAttackBoolean == true) {        //when player face left and trigger melee attack
      if (0<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 1) {
        playerImageFileName = "player_right_attack_0.png";
        meleeAttackBoolean = true;
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (2<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 3) {
        playerImageFileName = "player_right_attack_1.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (4<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 5) {
        playerImageFileName = "player_right_attack_2.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (6<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 7) {
        playerImageFileName = "player_right_attack_3.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (8<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 9) {
        playerImageFileName = "player_right_attack_4.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
      } else if (10<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 11) {
        playerImageFileName = "player_right_attack_5.png";
        imageCenterOffset.x = -19;
        imageCenterOffset.y = -44;
      } else if (12<= frameCount - startMeleeAttack && frameCount - startMeleeAttack <= 13) {
        playerImageFileName = "player_right_attack_6.png";
        imageCenterOffset.x = -29;
        imageCenterOffset.y = -44;
        //playerMeleeAttackDamage(playerDirectionPV);
      } else {
        playerImageFileName = "player_right_idle.png";
        imageCenterOffset.x = -15;
        imageCenterOffset.y = -44;
        meleeAttackBoolean = false;
      }
    }
  }

  //void playerMeleeAttackDamage(PVector direction) {
  //  float x = direction.x;
  //  float y = direction.y;
  //  for (Monster m : monsterArrayList) {
  //    if (m.monsterCurrentCenterXI >= 360 && m.monsterCurrentCenterXI <= 440) {        //if monster is in horizontal range
  //      if (y == 1 && m.monsterCurrentCenterYI >= 400 && m.monsterCurrentCenterYI <= 450) {        //if face down and monster is in vertical range
  //        monsterArrayList.remove(m);
  //        material++;
  //        continue;
  //      } else if (y == -1 && m.monsterCurrentCenterYI <= 400 && m.monsterCurrentCenterYI >= 350) {        //if face up and monster is in vertical range
  //        monsterArrayList.remove(m);
  //        material++;
  //        continue;
  //      }
  //    } else if (m.monsterCurrentCenterYI >= 360 && m.monsterCurrentCenterYI <= 440) {        //if monster is in vertical range
  //      if (x == 1 && m.monsterCurrentCenterXI >= 400 && m.monsterCurrentCenterXI <= 450) {        //if face down and monster is in horizontal range
  //        monsterArrayList.remove(m);
  //        material++;
  //        continue;
  //      } else if (x == -1 && m.monsterCurrentCenterXI <= 400 && m.monsterCurrentCenterXI >= 350) {        //if face up and monster is in horizontal range
  //        monsterArrayList.remove(m);
  //        material++;
  //        continue;
  //      }
  //    }
  //  }
  //}
}

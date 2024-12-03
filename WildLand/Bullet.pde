class Bullet {
  PVector bulletCurrentPositionPV = new PVector();        //bullet center point, convert old code into PVector
  PVector bulletSpeedPV = new PVector(0, 0);        //bullet speed
  PVector bulletAcceleration = new PVector(0, 0);

  Bullet(float weaponEndPointXF, float weaponEndPointYF) {
    bulletCurrentPositionPV.x = 400 + weaponEndPointXF;        //200 is screen center point, which is also player's center point
    bulletCurrentPositionPV.y = 380 + weaponEndPointYF;        //use to calculate real weapon end point, the point where the bullet was fired
    bulletSpeedPV.x = weaponEndPointXF * bulletSpeedSetting / player.weaponLength;
    bulletSpeedPV.y = weaponEndPointYF * bulletSpeedSetting / player.weaponLength;
    bulletAcceleration.x = bulletSpeedPV.x/300;
    bulletAcceleration.y = bulletSpeedPV.y/300;
  }

  void drawBullet() {
    bulletSpeedPV.x -= bulletAcceleration.x;        //bullet speed slow 1/300 per frame
    bulletSpeedPV.y -= bulletAcceleration.y;
    fill(200, 100, 0);
    bulletCurrentPositionPV.x += bulletSpeedPV.x - player.playerVelocityPV.x;        //Bullet movement needs to take the player's movement into account.
    bulletCurrentPositionPV.y += bulletSpeedPV.y - player.playerVelocityPV.y;
    ellipse(bulletCurrentPositionPV.x, bulletCurrentPositionPV.y, 10, 10);
  }
}

ArrayList<Bullet> bulletArrayList = new ArrayList<Bullet>();

//draw and detect collision
void bulletArrayListFunction() {
  if (bulletArrayList.size()>=1) {
    for (int i = bulletArrayList.size() - 1; i >= 0; i--) {
      Bullet b = bulletArrayList.get(i);
      if (abs(b.bulletSpeedPV.x) <= 1) {        //if bullet speed lower than 0, remove it from bullet array list
        bulletArrayList.remove(i);
        continue;
      }
      for (int j = monsterArrayList.size() - 1; j >= 0; j--) {
        Monster m = monsterArrayList.get(j);
        //If the center point of the bullet is within the distance of the monster's edge plus the bullet's radius, it is considered a collision.
        if (b.bulletCurrentPositionPV.x >= m.monsterCurrentCenterXI - monsterWidthSetting - bulletRadius && b.bulletCurrentPositionPV.x <= m.monsterCurrentCenterXI + monsterWidthSetting + bulletRadius
          && b.bulletCurrentPositionPV.y >= m.monsterCurrentCenterYI - monsterHeightSetting - bulletRadius && b.bulletCurrentPositionPV.y <= m.monsterCurrentCenterYI + monsterHeightSetting + bulletRadius) {
          bulletArrayList.remove(i);
          monsterArrayList.remove(j);
          break;
        }
      }
      b.drawBullet();        //After removing the bullets that have disappeared, draw the remaining bullets.
    }
  }
}

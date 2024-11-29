class Bullet {
  float bulletCurrentXF;        //bullet center point
  float bulletCurrentYF;
  float bulletSpeedXF;        //bullet speed on x and y, used for PVector
  float bulletSpeedYF;
  PVector bulletSpeedPV = new PVector(0, 0);

  void generateBullet(float weaponEndPointXF, float weaponEndPointYF) {
    bulletCurrentXF = 200 + weaponEndPointXF;        //200 is screen center point, which is also player's center point
    bulletCurrentYF = 200 + weaponEndPointYF;        //use to calculate real weapon end point, the point where the bullet was fired
    bulletSpeedXF = weaponEndPointXF * bulletSpeed / player.weaponLength;        //x/a = speed/r, x=a*speed/r
    bulletSpeedYF = weaponEndPointYF * bulletSpeed / player.weaponLength;        //y=b*speed/r
    bulletSpeedPV.x = bulletSpeedXF;
    bulletSpeedPV.y = bulletSpeedYF;
  }

  void drawBullet() {
    fill(200, 100, 0);
    bulletCurrentXF += bulletSpeedPV.x - player.playerPV.x;        //Bullet movement needs to take the player's movement into account.
    bulletCurrentYF += bulletSpeedPV.y - player.playerPV.y;
    ellipse(bulletCurrentXF, bulletCurrentYF, 10, 10);
  }
}

ArrayList<Bullet> bulletArrayList = new ArrayList<Bullet>();

//draw and detect collision
void bulletArrayListFunction() {
  if (bulletArrayList.size()>=1) {
    for (int i = bulletArrayList.size() - 1; i >= 0; i--) {
      Bullet b = bulletArrayList.get(i);
      for (int j = monsterArrayList.size() - 1; j >= 0; j--) {
        Monster m = monsterArrayList.get(j);
        //If the center point of the bullet is within the distance of the monster's edge plus the bullet's radius, it is considered a collision.
        if (b.bulletCurrentXF >= m.monsterCurrentCenterXI - monsterWidthSetting - bulletRadius && b.bulletCurrentXF <= m.monsterCurrentCenterXI + monsterWidthSetting + bulletRadius
          && b.bulletCurrentYF >= m.monsterCurrentCenterYI - monsterHeightSetting - bulletRadius && b.bulletCurrentYF <= m.monsterCurrentCenterYI + monsterHeightSetting + bulletRadius) {
          bulletArrayList.remove(i);
          monsterArrayList.remove(j);
          break;
        }
      }
      b.drawBullet();        //After removing the bullets that have disappeared, draw the remaining bullets.
    }
  }
}

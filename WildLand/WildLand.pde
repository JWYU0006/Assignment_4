//settings
//map settings
int tileNumberXSetting = 40;    //tile number, world size
int tileNumberYSetting = 40;

//environment settings
int grassDensitySetting = 3;
int grassWidthSetting = 2*2*2;        //a multiple of 2
int grassHeightSetting = 3*2;        //a multiple of 3

//player settings
int playerWidthSetting = 20;        ////player width and height settings, can change player's visual size and collision box size
int playerHeightSetting = 36;
int playerSpeedSetting = 2;
int endTime = 0;

//weapon settings
int bulletSpeed = 10;        //linear velocity (hypotenuse of a right triangle)
int bulletDiameter = 10;        //bullet is a ellipse
int bulletRadius = bulletDiameter/5;
int fireRate = 10;        //bullets per second

//monster settings
int monsterAmountSetting = 50;        //initial monster amount
int monsterWidthSetting = 30;        //monster width and height settings, can change monster's collision box size
int monsterHeightSetting = 20;
int monsterSpeedSetting = 1;
int monsterHPSetting = 100;

//creating objects
Environment environment = new Environment();
Player player = new Player();

void setup() {
  size(400, 400);
  noFill();
  noStroke();
  //initialization function (All initialization function should be called once)
  tileGrassArrayInitialization();
  monsterArrayInitialization();
}

int lastTimeShoot = 0;
int currentTimeShoot = 0;
int lastWave = 0;
void draw() {
  drawMap();
  environment.environmentFunction();
  player.playerFunction();
  //add new wave of monster per 5 seconds
  if ( (int)(millis() / 5000) != lastWave) {
    lastWave++;
    newMonsterWave(monsterAmountSetting * (1 + lastWave/10));        ///*1.1, *1.2 and so on
  }
  //run all monsters' function
  for (Monster m : monsterArrayList) {
    m.monsterFunction();
  }
  bulletArrayListFunction();
  //shoot function start
  currentTimeShoot = millis();
  if (mousePressed) {
    if (currentTimeShoot - lastTimeShoot >= 1000 / fireRate) {        //whether the firing cooldown time is met
      player.shoot();
      lastTimeShoot = currentTimeShoot;
    }
  }
  //shoot function end
  //if hp = 0
  if (player.playerCurrentHPI == 0) {
    fill(150, 0, 0);
    textSize(100);
    textAlign(CENTER);
    text("Wasted", 200, 200);
    //timer
    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    if (endTime == 0) {
      endTime = millis()/1000;
    }
    text(endTime, 350, 0);
  } else {
    //show monster amount
    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    text(monsterArrayList.size(), 200, 0);
    //timer
    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    text(millis()/1000, 350, 0);
  }
}

void keyPressed() {
  player.movementKeyPressed();
}

void keyReleased() {
  player.movementKeyReleased();
}

import processing.sound.*;
//import gifAnimation.*;

//settings
//map settings
int tileNumberXSetting = 40;    //tile number - world size
int tileNumberYSetting = 40;

//environment settings
int grassDensitySetting = 3;        //the number of grass in one tile
int grassWidthSetting = 2*2*2;        //a multiple of 2
int grassHeightSetting = 3*2;        //a multiple of 3

//player settings
int playerWidthSetting = 20;        //player width and height settings, can change player's visual size and collision box size
int playerHeightSetting = 36;
int playerSpeedSetting = 2;        //pixel player move per frame
int endTime = 0;        //how many seconds have the player play

//weapon settings
int bulletSpeedSetting = 10;        //The linear velocity of the bullet
int bulletRadius = 2;        //bullet is a ellipse, the radius of the round
int fireRate = 10;        //the max number of bullets per second

//monster settings
int monsterAmountSetting = 50;        //first wave monster amount
int monsterWidthSetting = 30;        //monster width and height settings, can change monster's collision box size
int monsterHeightSetting = 20;
int monsterSpeedSetting = 1;        //pixel monster move per frame

//tower settings
int towerWidthSetting = 30;
int towerHeightSetting = 60;

//creating objects
Environment environment = new Environment();
Player player = new Player();

//load file
//Gif splatter;        //monster death gif
SoundFile gunSound;        //player gun shot sound

void setup() {
  size(800, 800);
  noFill();
  noStroke();
  //initialization function (All initialization function should be called once)
  tileGrassArrayInitialization();
  monsterArrayInitialization();
  towerArrayListInitialization();
  //load file
  //splatter = new Gif(this, "splatter.gif");
  gunSound = new SoundFile(this, "762x54r Single Isolated MP3.mp3");
}

//in game stats
int gameStartTime = 0;        //store when new game start
int lastTimeShoot = 0;        //calculate shoot gap to check if the gun can shoot or not
int currentTimeShoot = 0;
int lastWave = 0;        //last monster wave time record
int material = 0;        //how many monsters are killed, use this points to build tower

void draw() {
  drawMap();
  environment.environmentFunction();
  //add new wave of monster per 5 seconds
  if ( millis() - gameStartTime - lastWave >= 5000) {        //millis() - gameStartTime is the recent game lasting time
    lastWave = millis();
    monsterAmountSetting = (int)(monsterAmountSetting*1.5);        //the amount of monsters is 1.5 time of last wave
    newMonsterWave(monsterAmountSetting);
  }
  //run all monsters' function
  for (Monster m : monsterArrayList) {
    m.monsterFunction();
  }
  //run all tower's function
  for (Tower t : towerArrayList) {
    t.towerFunction();
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
  player.playerFunction();        //run player function
  //if hp = 0
  if (player.playerCurrentHPI == 0) {
    fill(150, 0, 0);
    textSize(100);
    textAlign(CENTER);
    text("Failed", width/2, height/2);
    //timer
    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    if (endTime == 0) {
      endTime = (millis() - gameStartTime)/1000;
    }
    text(endTime, 350, 0);
    if (keyPressed && key == ' ') {
      initializeGame();        //restart game when game is end and press space
    }
  } else {
    //show monster amount
    fill(255);
    textAlign(LEFT, TOP);
    textSize(40);
    text("Monster: " + monsterArrayList.size(), 300, 0);        //amount of monsters remain in game
    text("Time: " + (millis()-gameStartTime)/1000, 600, 0);        //timer
    text("Material: " + material, 50, 0);        //material amount
  }
}

void keyPressed() {
  player.movementKeyPressed();
}

void keyReleased() {
  player.movementKeyReleased();
}

//initialize game to replay
void initializeGame() {
  gameStartTime = millis();        //store the millis when game restart
  endTime = 0;
  monsterAmountSetting = 50;
  player = new Player();
  lastTimeShoot = 0;
  currentTimeShoot = 0;
  lastWave = 0;
  material = 0;
  bulletArrayList = new ArrayList<Bullet>();
  tileGrassArrayInitialization();
  monsterArrayInitialization();
  towerArrayListInitialization();
}

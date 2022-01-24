//game vars
int screenIndex = 0; //0 = game, 1 = title, 2 = level select, 3 = visual novel story stuff
int levelIndex = 0; //what level the player is playing, 0 is test level
int levelType = 1; //0 = over land, 1 = over water, 2 = space
boolean enemiesPlaced = false; //used to only place enemies once per level load
int enemyIndex = 0; //used for enemy gen
int bulletCount = 500; //total bullet objects
int basicECount = 100; //total enemy objects
int dmgCount = 200; //total damage (readout) objects
int starCount = 300; //how many stars to display
int timing = 0; //used for various timings, namely the players weapon firing timer
int secondTiming = 0; //used for timing secondary weapons
int screenX = 1280;
int screenY = 720;
float autoScroll = -2; //controls how fast the enemies move to the left

//player vars
float playerX = 200;
float playerY = 250;
int playerHitX = 30;
int playerHitY = 7;
int playerBulletOffsetX = 45; //offset for where bullet is generated relative to player model
int playerBulletOffsetY = 5; //offset for where bullet is generated relative to player model
int playerMoveX = 3;
int playerMoveY = 3;
int playerWeapon = 2;
int playerSecondWeapon = 0;
int playerState = 0; //0 = normal, 1 = hurt
int bulletIndex = 0;
float playerShield = 20;
float playerShieldMax = 100;
float playerShieldRegen = 0.5;
float playerHP = 100;
float playerHPMax = 100;

//player weapon vars
//machine gun
int playerWeaponCooldown0 = 10;
float playerWeaponPower0 = 5;
int playerWeaponHitX0 = 10;
int playerWeaponHitY0 = 10;
//spread shot
int playerWeaponCooldown1 = 40;
float playerWeaponPower1 = 3.5;
//dual beam cannon
int playerWeaponCooldown2 = 20;
float playerWeaponPower2 = 3.5;
//snipe shot
int playerWeaponCooldown4 = 30;
float playerWeaponPower4 = 5;
//basic secondary missile
int playerWeaponCooldown100 = 40;
float playerWeaponPower100 = 10;

//input vars
boolean keyInput[] = new boolean [15];

//visual novel vars
int eventIndex = 0; //index value for events
int textIndex = 0; //index value for which line of dialogue should be displayed
int bgIndex = 0; //background index
int textTiming = 0; //used for rendering each letter individually, ie it looks like its being typed out
String[] textLines = new String[999]; //used for each line of dialogue
int[][] vnInfo = new int[999][5]; //used for stuff like who should be rendered, tint, etc

//animation timing vars
int playerEngineTimer = 0;

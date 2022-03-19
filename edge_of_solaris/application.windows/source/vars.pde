//game vars
int buildNumber = 73;
int screenIndex = 1; //0 = game, 1 = title, 2 = level select, 3 = visual novel story stuff, 4 = settings menu, 5 = status
int levelIndex = 0; //what level the player is playing, 0 is test level
int areaIndex = 0; //index for what area the player is at
int levelType = 1; //0 = over land, 1 = over water, 2 = space
int enemyIndex = 0; //used for enemy gen
int bulletCount = 500; //total bullet objects
int basicECount = 100; //total enemy objects
int dmgCount = 200; //total damage (readout) objects
int starCount = 100; //how many stars to display
int timing = 0; //used for various timings, namely the players weapon firing timer
int secondTiming = 0; //used for timing secondary weapons
int screenX = 1280; //screen size x
int screenY = 720; //screen size y
float autoScroll = -2; //controls how fast the enemies move to the left
float enemyBalanceHP = 1; //multiplier for enemy hp
float enemyBalanceDMG = 1; //multiplier for enemy shot power
float enemyBalanceBump = 5; //multipler for damage to deal when player bumps into an enemy, it is enemyHP * this multiplier
boolean paused = false; //if gameplay is paused this is true

//player vars
float playerX = 200; //player x pos
float playerY = 250; //player y pos
int playerHitX = 60; //player x hitbox
int playerHitY = 14; //player y hitbox
int playerBulletOffsetX = 45; //offset for where bullet is generated relative to player model
int playerBulletOffsetY = 13; //offset for where bullet is generated relative to player model
int playerMoveX = 4; //player move speed x
int playerMoveY = 4; //player move speed y
int playerWeapon = 2; //player weapon selected
int playerSecondWeapon = 0; //0 = basic missiles
int playerState = 0; //0 = normal, 1-10 = hurt anim, 255 = dead
int playerAnimTiming = 0; //used for the death anim
int bulletIndex = 0;

float playerShield = 0; //current shield
float playerShieldMax = 50; //max shield
float playerShieldRegen = 0.5; //shield regen per frame
float playerShieldRegenBoost = 1;//percentage boost for regen
float playerHP = 100; //current hp
float playerHPMax = 100; //max hp
float playerDefense = 1.1; //percentage damage reduction, goes down
float playerDMGReduction = 1; //calculated from playerDefense
float playerAttack = 1; //percentage boost to all player wpn dmg
float playerCooldown = 1; //percentage boost to defense (reduces damage taken)
float enemyDrop = 1; //percentage of time enemies drop items
float moneyValueDrop = 1; //percentage boost of money dropped
float hpValueDrop = 1; //percentage boost of hp dropped
float xpValueDrop = 1; //percentage boost of xp dropped
float playerMoveBoost = 1; //boost to player speed
float playerXP = 0; //amount of xp player has
int playerLevel = 1; //level of player
float playerMoney = 0; //amount of money player has
int playerStatPoints = 100; //stat points to allocate


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
float playerWeaponPower2 = 5;
//snipe shot
int playerWeaponCooldown4 = 30;
float playerWeaponPower4 = 5;
//basic secondary missile
int playerWeaponCooldown100 = 40;
float playerWeaponPower100 = 10;

//input vars
boolean keyInput[] = new boolean [15];

//visual novel vars
int eventIndex = 0; //index value for events (1 indexed for ease of text editor use)
int textIndex = 1; //index value for which line of dialogue should be displayed, this is 1 indexed
int bgIndex = 0; //background index
int textTiming = 0; //used for rendering each letter individually, ie it looks like its being typed out
String[] textLines = new String[999]; //used for each line of dialogue, this is the raw text in
String[] textLinesO = new String[999]; //used for each line of dialogue, this is after the commands are stripped
int[][] vnInfo = new int[999][5]; //used for stuff like who should be rendered, tint, etc
int commandIndex = 0; //used by the vn command handler to define which level should be skipped to

//animation timing vars
int playerEngineTimer = 0;

//settings vars
boolean oneHitMode = true; //whether to set game to paused when player dies
boolean damageOnTop = false; //whether or not to render to damage on top of the player

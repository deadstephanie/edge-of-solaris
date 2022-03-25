//game vars
int buildNumber = 106; //the current build number, should be incremented manually each commit
int screenIndex = 2; //0 = game, 1 = title, 2 = level select, 3 = visual novel story stuff, 4 = settings menu, 5 = status, 6 = mess hall
//7 = hanger, 8 = engineering, 9 = level editor
int levelIndex = 0; //what level the player is playing, 98/99 is test level
int levelType = 1; //0 = over land, 1 = over water, 2 = space
int areaIndex = 1; //tells the level select what options to have, 0 is debug
int enemyIndex = 0; //used for enemy gen
int bulletCount = 500; //total bullet objects
int basicECount = 300; //total enemy objects
int dmgCount = 200; //total damage (readout) objects
int starCount = 100; //how many stars to display
int timing = 0; //used for various timings, namely the players weapon firing timer
int secondTiming = 0; //used for timing secondary weapons
int screenX = 1280; //screen size x
int screenY = 720; //screen size y
float autoScroll = -1.5; //controls how fast the enemies move to the left
float enemyBalanceHP = 2; //multiplier for enemy hp
float enemyBalanceDMG = 2; //multiplier for enemy shot power
float enemyBalanceBump = 3; //multipler for damage to deal when player bumps into an enemy, it is enemyHP * this multiplier
float moneyBalance = 1; //multiplier for balancing money gained from enemies
float xpBalance = 0.1; //multiplier for balancing xp gained from enemies
boolean paused = false; //if gameplay is paused this is true
File file; //file used for loading files
boolean useCWD = false; //whether or not to use CWD for file loading/saving (linux only)
int levelEndCheckTimer = 0; //timer to check periodically to see if all enemies are dead
boolean levelEnd = false; //true when on the level end screen
int shadowFactor = 0; //don't ask
boolean level0Completed; //if level0 has been completed or not
boolean level1Completed; //if level1 has been completed or not

//player var
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
int bulletIndex = 0; //used for indexing bullets

float playerShield = 0; //current shield
float playerShieldMax = 50; //max shield
float playerShieldRegen = 0.5; //shield regen per frame
float playerShieldRegenBoost = 1;//percentage boost for regen
float playerHP = 100; //current hp
float playerHPMax = 100; //max hp
float playerDefense = 1.1; //percentage damage reduction, goes down
float playerDMGReduction = 1; //calculated from playerDefense
float playerAttack = 1; //percentage boost to all player wpn dmg
float playerCooldown = 1; //percentage boost to all wpn cooldown
float enemyDrop = 1; //percentage of time enemies drop items
float moneyValueDrop = 1; //percentage boost of money dropped
float hpValueDrop = 1; //percentage boost of hp dropped
float xpValueDrop = 1; //percentage boost of xp dropped
float playerMoveBoost = 1; //boost to player speed
float playerXP; //amount of xp player has
int playerLevel; //level of player
float playerMoney; //amount of money player has
int playerStatPoints; //stat points to allocate
int playerWeaponsUnlocked; //how many weapons have been unlocked 0-3


//player weapon vars
//machine gun
int playerWeaponCooldown0 = 2;
float playerWeaponPower0;
float playerWeaponBasePower0 = 0.5;
int playerWeaponHitX0 = 10;
int playerWeaponHitY0 = 10;
float playerWeaponMove0 = 0;
int playerWeaponLevel0;
int playerWeaponCost0;
//spread shot
int playerWeaponCooldown1 = 30;
float playerWeaponPower1;
float playerWeaponBasePower1 = 12;
int playerWeaponLevel1;
int playerWeaponCost1;
//dual beam cannon
int playerWeaponCooldown2 = 20;
float playerWeaponPower2;
float playerWeaponBasePower2 = 5;
int playerWeaponLevel2;
int playerWeaponCost2;
//snipe shot
int playerWeaponCooldown4 = 30;
float playerWeaponPower4;
float playerWeaponBasePower4 = 5;
int playerWeaponLevel4;
int playerWeaponCost4;
//basic secondary rocket
int playerWeaponCooldown100 = 40;
float playerWeaponPower100 = 10;
float playerWeaponBasePower100 = 10;
int playerWeaponLevel100;
//tracking missile
int playerWeaponCooldown101 = 40;
float playerWeaponPower101 = 10;
float playerWeaponBasePower101 = 10;
int playerWeaponLevel101;

//input vars
boolean keyInput[] = new boolean [45];

//visual novel vars
int eventIndex = 0; //index value for events (1 indexed for ease of text editor use)
int textIndex = 2; //index value for which line of dialogue should be displayed, this is 1 indexed, first line is the first start point so start after that
int bgIndex = 0; //background index
int textTiming = 0; //used for rendering each letter individually, ie it looks like its being typed out
String[] textLines = new String[999]; //used for each line of dialogue, this is the raw text in
String[] textLinesO = new String[999]; //used for each line of dialogue, this is after the commands are stripped
String[] levelEndCommands = new String[999]; //used for commands be ran at the end of each level
int[][] vnInfo = new int[999][5]; //used for stuff like who should be rendered, tint, etc
int commandIndex = 0; //used by the vn command handler to define which level should be skipped to
boolean vnScreenChanges = true; //used to denote whether or not a screen update is needed on the vn segments as to not render frames when nothing has changed
int scriptLength = 0; //used to determine length of script file when its loaded
int[] scriptStartPoints = new int[999]; //used to determine the start point of each script

//animation timing vars
int playerEngineTimer = 0;

//settings vars
boolean oneHitMode = true; //whether to set game to paused when player dies
boolean damageOnTop = false; //whether or not to render to damage on top of the player

//level editor vars
int scrollX = 0; //used for the scroll on the level editor
int[] levelEnemyType = new int[999]; //used to store the enemy types
int[] levelEnemyX = new int[999]; //used to store enemy x pos
int[] levelEnemyY = new int[999]; //used to store enemy y pos
int levelEnemyIndex = 0; //used for writing to the arrays
int levelEnemyTypeSelected = 0; //used to know which enemy type is selected
float displayX; //used for scrolling enemies
boolean levelEditorMode; //used for playtesting the level

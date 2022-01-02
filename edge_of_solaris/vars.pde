//game vars
int screenIndex = 0; //0 = game, 1 = title, 2 = level select
int bulletCount = 500;
int basicECount = 20;
int starCount = 300;
int timing = 0;
int screenX = 1280;
int screenY = 720;

//player vars
int playerX = 200;
int playerY = 250;
int playerHitX = 60;
int playerHitY = 20;
int playerMoveX = 2;
int playerMoveY = 2;
int playerWeapon = 0;
int playerState = 0; //0 = normal, 1 = hurt
int bulletIndex = 0;
float playerShield = 20;
float playerShieldMax = 100;
float playerShieldRegen = 1;
float playerHP = 50;
float playerHPMax = 100;

//input vars
boolean keyInput[] = new boolean [15];

void placeEnemies() {
  if (levelIndex == 0) {
    genEnemy(0, 700, 200);
    genEnemy(0, 500, 400);
    genEnemy(0, 900, 400);
    genEnemy(0, 1100, 20);
    genEnemy(0, 1000, 20);
    genEnemy(1, 900, 200);
    genEnemy(1, 1100, 650);
    genEnemy(2, 800, 500);
    genEnemy(0, 1700, 100);
    genEnemy(0, 1500, 400);
    genEnemy(0, 1400, 600);
  }
}

void genEnemy(int type, int x, int y) { //used for placing enemies easier, pass in enemy type and position x/y
  if (type == 0) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = -1;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = 0;
    basicE[enemyIndex].enemyHitX = 25;
    basicE[enemyIndex].enemyHitY = 25;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  } else if (type == 1) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = -1;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 40;
    basicE[enemyIndex].enemyHitY = 40;
    basicE[enemyIndex].enemyHP = 30;
    basicE[enemyIndex].enemyHPMax = 30;
  } else if (type == 2) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = -1;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 40;
    basicE[enemyIndex].enemyHitY = 15;
    basicE[enemyIndex].enemyHP = 30;
    basicE[enemyIndex].enemyHPMax = 30;
  } else if (type == 3) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = -1;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 25;
    basicE[enemyIndex].enemyHitY = 25;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  }
  enemyIndex++;
}

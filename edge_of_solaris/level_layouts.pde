void placeEnemies() {
  if (levelIndex == 0) {
    //temp layout
    /*genEnemy(0, 700, 200);
    genEnemy(0, 500, 400);
    genEnemy(0, 900, 400);
    genEnemy(0, 1100, 20);
    genEnemy(0, 1000, 20);
    genEnemy(1, 900, 200);
    genEnemy(1, 1100, 650);
    genEnemy(2, 800, 500);
    genEnemy(0, 1700, 100);
    genEnemy(0, 1500, 400);
    genEnemy(0, 1400, 600);*/
    
    genEnemy(0, 1000, 300);
    
    genEnemy(2, 1600, 50);
    genEnemy(2, 1600, 225);
    genEnemy(2, 1600, 400);
    genEnemy(2, 1600, 575);
    
    genEnemy(0, 1800, 100);
    genEnemy(0, 1800, 300);
    genEnemy(0, 1800, 500);
    
    genEnemy(1, 2000, 50);
    genEnemy(1, 2000, 225);
    genEnemy(1, 2000, 400);
    genEnemy(1, 2000, 575);
  }
}

void genEnemy(int type, int x, int y) { //used for placing enemies easier, pass in enemy type and position x/y
  if (type == 0) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = 0;
    basicE[enemyIndex].enemyHitX = 50;
    basicE[enemyIndex].enemyHitY = 50;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  } else if (type == 1) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 100;
    basicE[enemyIndex].enemyHitY = 38;
    basicE[enemyIndex].enemyHP = 30;
    basicE[enemyIndex].enemyHPMax = 30;
  } else if (type == 2) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 80;
    basicE[enemyIndex].enemyHitY = 30;
    basicE[enemyIndex].enemyHP = 30;
    basicE[enemyIndex].enemyHPMax = 30;
  } else if (type == 3) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 25;
    basicE[enemyIndex].enemyHitY = 25;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  }
  enemyIndex++;
}

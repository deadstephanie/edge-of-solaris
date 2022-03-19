void placeEnemies() {
  if (levelIndex == 2) {
    //temp layout
    genEnemy(0, 1000, 300);
    
    genEnemy(0, 1200, 200);
    genEnemy(0, 1200, 400);
    genEnemy(0, 1200, 100);
    genEnemy(0, 1200, 500);
    genEnemy(0, 1200, 600);
    
    genEnemy(3, 1300, 50);
    genEnemy(3, 1300, 225);
    genEnemy(3, 1300, 400);
    genEnemy(3, 1300, 575);
    
    genEnemy(0, 1400, 100);
    genEnemy(0, 1400, 300);
    genEnemy(0, 1400, 500);
    
    genEnemy(1, 1600, 50);
    genEnemy(1, 1600, 225);
    genEnemy(1, 1600, 400);
    genEnemy(1, 1600, 575);
    
    genEnemy(0, 1800, 100);
    genEnemy(0, 1800, 300);
    genEnemy(0, 1800, 500);
    
    genEnemy(3, 2000, 50);
    genEnemy(3, 2000, 225);
    genEnemy(3, 2000, 400);
    genEnemy(3, 2000, 575);
    
    genEnemy(1, 2200, 100);
    genEnemy(2, 2200, 300);
    genEnemy(1, 2200, 500);
    
    genEnemy(0, 2400, 50);
    genEnemy(0, 2400, 225);
    genEnemy(0, 2400, 400);
    genEnemy(0, 2400, 575);
    
    genEnemy(4, 3000, 50);
    genEnemy(4, 3000, 150);
    genEnemy(4, 3000, 250);
    genEnemy(4, 3000, 350);
    genEnemy(4, 3000, 450);
    genEnemy(4, 3000, 550);
  } else if (levelIndex == 1) {
    genEnemy(6, 1000, 350);
    genEnemy(6, 800, 150);
    genEnemy(6, 800, 550);
    
    genEnemy(0, 1400, 350);
    genEnemy(0, 1400, 500);
    genEnemy(0, 1400, 200);
    
    genEnemy(3, 1700, 350);
    genEnemy(3, 1750, 400);
    genEnemy(3, 1750, 300);
    genEnemy(3, 1800, 450);
    genEnemy(3, 1800, 250);
    
    genEnemy(6, 2000, 450);
    genEnemy(6, 2050, 500);
    genEnemy(6, 2100, 550);
    
    genEnemy(6, 2200, 250);
    genEnemy(6, 2250, 200);
    genEnemy(6, 2300, 150);
    
    genEnemy(4, 2500, 300);
  } else if (levelIndex == 0) {
    genEnemy(6, 1000, 400);
    genEnemy(6, 1100, 500);
    genEnemy(6, 1200, 600);
    genEnemy(6, 1500, 300);
    genEnemy(6, 1600, 200);
    genEnemy(6, 1700, 100);
    
    genEnemy(6, 2100, 350);
    genEnemy(6, 2200, 450);
    genEnemy(6, 2200, 250);
    genEnemy(6, 2300, 550);
    genEnemy(6, 2300, 150);
    
    genEnemy(6, 2800, 350);
    genEnemy(6, 2850, 400);
    genEnemy(6, 2850, 300);
    genEnemy(6, 2900, 450);
    genEnemy(6, 2900, 250);
    genEnemy(6, 2950, 500);
    genEnemy(6, 2950, 200);
    genEnemy(6, 3000, 550);
    genEnemy(6, 3000, 150);
    
    genEnemy(6, 3200, 350);
    genEnemy(6, 3300, 450);
    genEnemy(6, 3300, 250);
    genEnemy(6, 3400, 550);
    genEnemy(6, 3400, 150);
    
    genEnemy(6, 3600, 350);
    genEnemy(6, 3650, 400);
    genEnemy(6, 3650, 300);
    genEnemy(6, 3700, 450);
    genEnemy(6, 3700, 250);
    genEnemy(6, 3750, 500);
    genEnemy(6, 3750, 200);
    genEnemy(6, 3800, 550);
    genEnemy(6, 3800, 150);
    
    //genEnemy(999, 4000, -500); //level complete enemy
  }
}

void genEnemy(int type, int x, int y) { //used for placing enemies easier, pass in enemy type and position x/y
  enemyIndex = findEnemy();
  basicE[enemyIndex].enemyState = 0;
  if (type == 0) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = 0;
    basicE[enemyIndex].enemyHitX = 110;
    basicE[enemyIndex].enemyHitY = 110;
    basicE[enemyIndex].enemyHP = 10 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 10 * enemyBalanceHP;
  } else if (type == 1) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 210;
    basicE[enemyIndex].enemyHitY = 86;
    basicE[enemyIndex].enemyHP = 30 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 30 * enemyBalanceHP;
  } else if (type == 2) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 170;
    basicE[enemyIndex].enemyHitY = 70;
    basicE[enemyIndex].enemyHP = 40 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 40 * enemyBalanceHP;
  } else if (type == 3) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 190;
    basicE[enemyIndex].enemyHitY = 58;
    basicE[enemyIndex].enemyHP = 10 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 10 * enemyBalanceHP;
  } else if (type == 4) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 252;
    basicE[enemyIndex].enemyHitY = 102;
    basicE[enemyIndex].enemyHP = 100 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 100 * enemyBalanceHP;
  } else if (type == 6) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 170;
    basicE[enemyIndex].enemyHitY = 70;
    basicE[enemyIndex].enemyHP = 10 * enemyBalanceHP;
    basicE[enemyIndex].enemyHPMax = 10 * enemyBalanceHP;
  } else if (type == 999) { //level end enemy
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 0;
    basicE[enemyIndex].enemyHitY = 0;
    basicE[enemyIndex].enemyHP = 9999;
    basicE[enemyIndex].enemyHPMax = 9999;
  }
}

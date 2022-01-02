bullet[] blts;
enemy[] basicE;
starsBG[] stars;

void setup() {
  size(1280, 720);
  blts = new bullet[bulletCount];
  basicE = new enemy[basicECount];
  stars = new starsBG[starCount];
  initObjects();
}

void draw() {
  background(0);
  processInput();
  drawFrame();
  drawUI();
  if (screenIndex == 0) {
    basicE[0].enemyX = 500;
    basicE[0].enemyY = 200;
    basicE[0].enemySpeedX = 0;
    basicE[0].enemySpeedY = 0;
    basicE[0].enemyType = 0;
    basicE[0].enemyHitX = 25;
    basicE[0].enemyHitY = 25;
    basicE[0].enemyState = 0;
        
    basicE[1].enemyX = 300;
    basicE[1].enemyY = 400;
    basicE[1].enemySpeedX = 0;
    basicE[1].enemySpeedY = 0;
    basicE[1].enemyType = 0;
    basicE[1].enemyHitX = 25;
    basicE[1].enemyHitY = 25;
    basicE[1].enemyState = 0;
    
    basicE[2].enemyX = 700;
    basicE[2].enemyY = 400;
    basicE[2].enemySpeedX = 0;
    basicE[2].enemySpeedY = 0;
    basicE[2].enemyType = 0;
    basicE[2].enemyHitX = 25;
    basicE[2].enemyHitY = 25;
    basicE[2].enemyState = 0;
    
    basicE[3].enemyX = 9000;
    basicE[3].enemyY = 20;
    basicE[3].enemySpeedX = 0;
    basicE[3].enemySpeedY = 0;
    basicE[3].enemyType = 0;
    basicE[3].enemyHitX = 25;
    basicE[3].enemyHitY = 25;
    basicE[3].enemyState = 0;
    
    basicE[4].enemyX = 600;
    basicE[4].enemyY = 20;
    basicE[4].enemySpeedX = 0;
    basicE[4].enemySpeedY = 0;
    basicE[4].enemyType = 0;
    basicE[4].enemyHitX = 25;
    basicE[4].enemyHitY = 25;
    basicE[4].enemyState = 0;
  }
  if (timing < 255) timing++;
}

void drawFrame() {
  if (screenIndex == 0) {
    for (starsBG stars : stars) {
      stars.update();
      stars.display();
    }
    for (enemy basicE : basicE) {
      basicE.collision();
      basicE.shoot();
      basicE.update();
      basicE.display();
    }
    for (bullet blts : blts) {
      blts.update();
      blts.display();
    }
    
    //draw player
    playerCollision();
    if (playerShield < playerShieldMax) playerShield = playerShield + playerShieldRegen;
    if (playerShield > playerShieldMax) playerShield = playerShieldMax;
    if (playerState == 0) setRect(1);
    else if (playerState == 1) setRect(2);
    rect(playerX, playerY, 60, 20);
    playerState = 0; // reset player state after hit/render
  } else if (screenIndex == 1) {
    resetObjects();
    
  }
}

void drawUI() {
  if (screenIndex == 0) {
    textSize(64);
    fill(255);
    text("Q and E switch weapons", 50, 600);
    setRect(3);
    rect(20, 650, 200, 50);
    rect(235, 650, 200, 50);
    setRect(4);
    rect(23, 653, (194 * (playerHP / playerHPMax)), 44);
    setRect(5);
    rect(238, 653, (194 * (playerShield / playerShieldMax)), 44);
  } else if (screenIndex == 1) {
    fill(200, 200, 255, 120);
    textSize(130);
    text("Edge Of Solaris", 240, 120);
    text("Edge Of Solaris", 248, 120);
    fill(200, 200, 255, 255);
    textSize(128);
    text("Edge Of Solaris", 250, 120);
    fill(200, 200, 255);
    textSize(90);
    text("random bullshit in space", 200, 240);
    textSize(64);
    text("new game", 500, 400);
    text("continue", 500, 500);
    text("press space to continue (temp)", 50, 650);
  } else if (screenIndex == 2) {
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    rect(950, 25, 300, 75);
    rect(950, 125, 300, 75);
    rect(950, 225, 300, 75);
    rect(950, 325, 300, 75);
    noStroke();
    fill(255);
    textSize(48);
    text("status", 975, 75);
    text("mess hall", 975, 175);
    text("hanger", 975, 275);
    text("engineering", 975, 375);
    text("press w to continue (temp)", 50, 650);
  }
}

void setRect(int colorIndex) {
  if (colorIndex == 0) {
    strokeWeight(1);
    noStroke();
    fill(0);
  } else if (colorIndex == 1) { //used for player ship rendering
    strokeWeight(1);
    noStroke();
    fill(255);
  } else if (colorIndex == 2) { //used for player hurt rendering
    strokeWeight(5);
    stroke(200, 0, 0, 100);
    fill(255, 200, 200);
  } else if (colorIndex == 3) { //used for hp surround
    strokeWeight(6);
    fill(0);
    stroke(255);
  } else if (colorIndex == 4) { //used for hp bar fill
    noStroke();
    fill(20, 255, 20);
  } else if (colorIndex == 5) {
    noStroke();
    fill(20, 20, 255);
  }
}

void initObjects() {
  for (int i = 0; i < bulletCount; i++) {
    blts[i] = new bullet(-20, -20, 0, 0, 255, 0, 0, 0);
  }
  for (int i = 0; i < basicECount; i++) {
    basicE[i] = new enemy(-200, -200, 0, 0, 99, 0, 0, 10, 10, 0, 2);
  }
  for (int i = 0; i < starCount; i++) {
    stars[i] = new starsBG(int(random(screenX + 20)), int(random(screenY)), int(-1 * (random(10) + 1)), 0);
  }
}

void resetObjects() {
    for (starsBG stars : stars) {
      stars.reset();
    }
    for (enemy basicE : basicE) {
      basicE.reset();
    }
    for (bullet blts : blts) {
      blts.reset();
    }
}

void playerCollision() {
    for (int i = 0; i < bulletCount; i++) {
   if (blts[i].bulletType != 255) { //check to ensure bullet is not inactive (for efficiency)
    if (playerX <= blts[i].bulletX + (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((playerX + (playerHitX / 1)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (playerY <= blts[i].bulletY + (blts[i].bulletHitY / 2)) {
          if ((playerY + (playerHitY / 1)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            if (blts[i].bulletType == 200 || blts[i].bulletType == 201) {
              playerState = 1;
              if (playerShield > 0) playerShield = playerShield - blts[i].bulletPower;
            }
            if (blts[i].bulletType == 200) blts[i].reset();
          }
        }
      }
    }
  }
  }
}

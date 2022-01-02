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
        
    basicE[1].enemyX = 300;
    basicE[1].enemyY = 400;
    basicE[1].enemySpeedX = 0;
    basicE[1].enemySpeedY = 0;
    basicE[1].enemyType = 0;
    basicE[1].enemyHitX = 25;
    basicE[1].enemyHitY = 25;
    
    basicE[2].enemyX = 700;
    basicE[2].enemyY = 400;
    basicE[2].enemySpeedX = 0;
    basicE[2].enemySpeedY = 0;
    basicE[2].enemyType = 0;
    basicE[2].enemyHitX = 25;
    basicE[2].enemyHitY = 25;
    
    basicE[3].enemyX = 9000;
    basicE[3].enemyY = 20;
    basicE[3].enemySpeedX = 0;
    basicE[3].enemySpeedY = 0;
    basicE[3].enemyType = 0;
    basicE[3].enemyHitX = 25;
    basicE[3].enemyHitY = 25;
    
    basicE[4].enemyX = 600;
    basicE[4].enemyY = 20;
    basicE[4].enemySpeedX = 0;
    basicE[4].enemySpeedY = 0;
    basicE[4].enemyType = 0;
    basicE[4].enemyHitX = 25;
    basicE[4].enemyHitY = 25;
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
    setRect(1);
    rect(playerX, playerY, 60, 20);
  } else if (screenIndex == 1) {
    resetObjects();
    
  }
}

void drawUI() {
  if (screenIndex == 0) {
    textSize(64);
    fill(255);
    text("Q and E switch weapons", 50, 650);
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
  } else if (colorIndex == 1) {
    strokeWeight(1);
    noStroke();
    fill(255);
  }
}

void initObjects() {
  for (int i = 0; i < bulletCount; i++) {
    blts[i] = new bullet(-20, -20, 0, 0, 255, 0, 0);
  }
  for (int i = 0; i < basicECount; i++) {
    basicE[i] = new enemy(-200, -200, 0, 0, 99, 0, 0, 1, 0);
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

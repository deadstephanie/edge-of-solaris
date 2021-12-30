bullet[] blts;
enemy[] basicE;
starsBG[] stars;

void setup() {
  size(1280, 720);
  blts = new bullet[playerBulletCount];
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
    basicE[0] = new enemy(500, 200, 0, 0, 0, 25, 25);
    basicE[1] = new enemy(400, 300, 0, 0, 0, 25, 25);
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
  } else if (screenIndex == 1) {
    fill(200, 200, 255, 120);
    textSize(136);
    text("Edge Of Solaris", 200, 120);
    fill(200, 200, 255, 255);
    textSize(128);
    text("Edge Of Solaris", 200, 120);
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
  for (int i = 0; i < playerBulletCount; i++) {
    blts[i] = new bullet(-20, -20, 0, 0, 0, 0, 0);
  }
  for (int i = 0; i < basicECount; i++) {
    basicE[i] = new enemy(-200, -200, 0, 0, 0, 0, 0);
  }
  for (int i = 0; i < starCount; i++) {
    stars[i] = new starsBG(int(random(1300)), int(random(720)), int(-1 * (random(10) + 1)), 0);
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

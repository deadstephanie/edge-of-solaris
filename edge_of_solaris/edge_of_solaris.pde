bullet[] blts;
enemy[] basicE;
starsBG[] stars;

void setup() {
  size(640, 480);
  blts = new bullet[playerBulletCount];
  basicE = new enemy[basicECount];
  stars = new starsBG[starCount];
  initObjects();
}

void draw() {
  background(0);
  processInput();
  drawUI();
  basicE[0] = new enemy(500, 200, 0, 0, 0, 25, 25);
  basicE[1] = new enemy(400, 300, 0, 0, 0, 25, 25);
}

void drawUI() {
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
  }
}

void setRect(int colorIndex) {
  if (colorIndex == 0) {
    fill(0);
  } else if (colorIndex == 1) {
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
    stars[i] = new starsBG(700, int(i * random(120)), int(-1 * (random(10) + 1)), 0);
  }
}

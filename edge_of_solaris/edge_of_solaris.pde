bullet[] blts;

void setup() {
  size(640, 480);
  blts = new bullet[200];
  initObjects();
}

void draw() {
  background(0);
  processInput();
  drawUI();
}

void drawUI() {
  if (screenIndex == 0) {
    setRect(1);
    rect(playerX, playerY, 60, 20);
    for (bullet blts : blts) {
      blts.update();
      blts.display();
    }
  }
}

void setRect(int colorIndex) {
  if (colorIndex == 0) {
    fill(0);
  } else if (colorIndex == 1) {
    fill(255);
  }
}

void processInput() {
  if (screenIndex == 0) {
      if (keyInput[0] == true) { //w
        playerY = playerY - playerMoveY;
      }
      if (keyInput[1] == true) { //s
        playerY = playerY + playerMoveY;
      }
      if (keyInput[2] == true) { //d
        playerX = playerX + playerMoveX;
      }
      if (keyInput[3] == true) { //a
        playerX = playerX - playerMoveX;
      }
      if (keyInput[4] == true) { //space
        playerShoot();
      }
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W')  keyInput[0] = true;
  if (key == 's' || key == 'S')  keyInput[1] = true;
  if (key == 'd' || key == 'D')  keyInput[2] = true;
  if (key == 'a' || key == 'A')  keyInput[3] = true;
  if (key == ' ') keyInput[4] = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W')  keyInput[0] = false;
  if (key == 's' || key == 'S')  keyInput[1] = false;
  if (key == 'd' || key == 'D')  keyInput[2] = false;
  if (key == 'a' || key == 'A')  keyInput[3] = false;
  if (key == ' ') keyInput[4] = false;
}

void playerShoot() {
  if (playerWeapon == 0) {
    blts[playerBulletIndex] = new bullet(playerX + 55, playerY + 18, 10, 0);
    playerBulletIndex++;
    if (playerBulletIndex == 200) playerBulletIndex = 0;
  }
}

void initObjects() {
  for (int i = 0; i < 200; i++) {
    blts[i] = new bullet(-20, -20, 0, 0);
  }
}

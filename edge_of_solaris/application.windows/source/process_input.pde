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
    blts[playerBulletIndex] = new bullet(playerX + 55, playerY + 18, 10, 0, 0, 5, 5);
    playerBulletIndex++;
    if (playerBulletIndex == playerBulletCount) playerBulletIndex = 0;
  }
}

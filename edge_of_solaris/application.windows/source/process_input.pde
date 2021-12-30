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
      if (keyInput[5] == true) { //q, prev weapon
        playerWeapon = 0;
      }
      if (keyInput[6] == true) { //q, next weapon
        playerWeapon = 4;
      }
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W')  keyInput[0] = true;
  if (key == 's' || key == 'S')  keyInput[1] = true;
  if (key == 'd' || key == 'D')  keyInput[2] = true;
  if (key == 'a' || key == 'A')  keyInput[3] = true;
  if (key == ' ') keyInput[4] = true;
  if (key == 'q' || key == 'Q')  keyInput[5] = true;
  if (key == 'e' || key == 'E')  keyInput[6] = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W')  keyInput[0] = false;
  if (key == 's' || key == 'S')  keyInput[1] = false;
  if (key == 'd' || key == 'D')  keyInput[2] = false;
  if (key == 'a' || key == 'A')  keyInput[3] = false;
  if (key == ' ') keyInput[4] = false;
  if (key == 'q' || key == 'Q')  keyInput[5] = false;
  if (key == 'e' || key == 'E')  keyInput[6] = false;
}

void playerShoot() {
  if (playerWeapon == 0) { //machine gun
    if (timing > 5) {
    blts[playerBulletIndex] = new bullet(playerX + 55, playerY + 18, 5, 0, playerWeapon, 5, 5);
    playerBulletIndex++;
    if (playerBulletIndex == playerBulletCount) playerBulletIndex = 0;
    timing = 0;
    }
  }
  if (playerWeapon == 4) { //sniper shot
    if (timing > 30) {
    blts[playerBulletIndex] = new bullet(playerX + 55, playerY + 18, 25, 0, playerWeapon, 50, 5);
    playerBulletIndex++;
    if (playerBulletIndex == playerBulletCount) playerBulletIndex = 0;
    timing = 0;
    }
  }
}

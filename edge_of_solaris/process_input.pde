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
  if (screenIndex == 1) {
    if (keyInput[4] == true) screenIndex = 2;
  }
  if (screenIndex == 2) {
    if (keyInput[0] == true) {
      screenIndex = 0;
      initObjects();
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
    if (timing > 10) {
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (blts[i].bulletType == 255) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > bulletCount) {
        bulletIndex = 0;
        exit = true;
      }
    }
    blts[bulletIndex] = new bullet(playerX + 45, playerY + 5, 5, 0, playerWeapon, 10, 10, 5);
    timing = 0;
    }
  }
  if (playerWeapon == 4) { //sniper shot
    if (timing > 30) {
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (blts[i].bulletType == 255) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > bulletCount) {
        bulletIndex = 0;
        exit = true;
      }
    }
    blts[bulletIndex] = new bullet(playerX + 45, playerY + 5, 25, 0, playerWeapon, 100, 10, 10);
    timing = 0;
    }
  }
}

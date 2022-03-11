void processInput() {
  if (screenIndex == 0 && paused == false) {
      if (keyInput[0] == true) { //w
      if (playerY > 10)
        playerY = playerY - (playerMoveY * playerMoveBoost);
      }
      if (keyInput[1] == true) { //s
      if (playerY < 600)
        playerY = playerY + (playerMoveY * playerMoveBoost);
      }
      if (keyInput[2] == true) { //d
      if (playerX < 1200)
        playerX = playerX + (playerMoveX * playerMoveBoost);
      }
      if (keyInput[3] == true) { //a
      if (playerX > 20)
        playerX = playerX - (playerMoveX * playerMoveBoost);
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
      if (keyInput[7] == true) { //q, next weapon
        playerWeapon = 1;
      }
      if (keyInput[8] == true) { //p, pause game
        paused = true;
        keyInput[8] = false;
      }
  } else if (screenIndex == 0 && paused == true) { //if game is paused
        if (playerState != 255) { //check to ensure player is not dead
          if (keyInput[8] == true) { //p key
            paused = false;
            keyInput[8] = false;
          } 
        } else {
          if (keyInput[7] == true || keyInput[4] == true) { //r key or space key
            levelStart(levelIndex); //restart the current level
            paused = false;
            keyInput[4] = false; //unset space key
          } else if (keyInput[5] == true) { //q key
            //TODO LEVEL EXIT HERE
          }
        }
        
  } else if (screenIndex == 1) {
    if (keyInput[4] == true) screenIndex = 2;
  } else if (screenIndex == 2) {
  
  } else if (screenIndex == 3) {
    if (keyInput[4] == true) {
      textIndex++;
      if (scanVNCommands() == 0) {//load level
          levelStart(commandIndex); //load a level
      }
      keyInput[4] = false;
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
  if (key == 'r' || key == 'R')  keyInput[7] = true;
  if (key == 'p' || key == 'P')  keyInput[8] = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W')  keyInput[0] = false;
  if (key == 's' || key == 'S')  keyInput[1] = false;
  if (key == 'd' || key == 'D')  keyInput[2] = false;
  if (key == 'a' || key == 'A')  keyInput[3] = false;
  if (key == ' ') keyInput[4] = false;
  if (key == 'q' || key == 'Q')  keyInput[5] = false;
  if (key == 'e' || key == 'E')  keyInput[6] = false;
  if (key == 'r' || key == 'R')  keyInput[7] = false;
  if (key == 'p' || key == 'P')  keyInput[8] = false;
}

void playerShoot() {
  if (playerWeapon == 0) { //machine gun
    if (timing > playerWeaponCooldown0) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 0, playerWeapon, 10, 10, playerWeaponPower0 * playerAttack);
      timing = 0;
    }
  } else if (playerWeapon == 1) { //spread shot
    if (timing > playerWeaponCooldown1) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 0, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 1, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 2, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, -2, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, -1, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack);
      timing = 0;
    }
  } else if (playerWeapon == 2) { //dual beam cannon
      if (timing > playerWeaponCooldown2) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY + 7, 20, 0, playerWeapon, 80, 10, playerWeaponPower2 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY - 7, 20, 0, playerWeapon, 80, 10, playerWeaponPower2 * playerAttack);
      timing = 0;
    }
  } else if (playerWeapon == 4) { //sniper shot
      if (timing > playerWeaponCooldown4) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 25, 0, playerWeapon, 100, 5, playerWeaponPower4 * playerAttack);
      timing = 0;
    }
  }
  if (playerSecondWeapon == 0) { //basic secondary missile
    if (secondTiming > playerWeaponCooldown100) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, +10, playerSecondWeapon + 100, 20, 10, playerWeaponPower100 * playerAttack);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, -10, playerSecondWeapon + 100, 20, 10, playerWeaponPower100 * playerAttack);
      secondTiming = 0;
    }
  }
}

void mousePressed() {
  if (screenIndex == 2) {//menu screen
    if (areaIndex == 0) {
      if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 5; //status button
      else if (mouseX > 950 && mouseX < 1250 && mouseY > 125 && mouseY < 200); //mess hall button
      else if (mouseX > 950 && mouseX < 1250 && mouseY > 225 && mouseY < 300); //hanger button
      else if (mouseX > 950 && mouseX < 1250 && mouseY > 325 && mouseY < 400); //engineering buttton
      else if (mouseX > 50 && mouseX < 450 && mouseY > 25 && mouseY < 100) screenIndex = 3; //story button
      else if (mouseX > 50 && mouseX < 450 && mouseY > 125 && mouseY < 200) levelStart(0); //level 00
      else if (mouseX > 50 && mouseX < 450 && mouseY > 225 && mouseY < 300) levelStart(1); //level 01
      else if (mouseX > 1000 && mouseX < 1200 && mouseY > 450 && mouseY < 650) screenIndex = 4; //settings button
    }
  } else if (screenIndex == 4) {
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) {screenIndex = 2; saveSettings();} //back button (also saves settings)
    else if (mouseX > 50 && mouseX < 450 && mouseY > 25 && mouseY < 100) oneHitMode = !oneHitMode; //pause on restart button
    else if (mouseX > 50 && mouseX < 450 && mouseY > 225 && mouseY < 300) {image(shadow, 500, 500); image(shadow2, 1000, 500); image(shadow3, 500, 200);} //shadow
    else if (mouseX > 50 && mouseX < 450 && mouseY > 125 && mouseY < 200) damageOnTop = !damageOnTop; //damage on top button
  } else if (screenIndex == 5) {
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 2; //back button
    else if (mouseX > 625 && mouseX < 700 && mouseY > 125 && mouseY < 200) if (playerStatPoints > 0) {playerHPMax = playerHPMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 225 && mouseY < 300) if (playerStatPoints > 0) {playerShieldMax = playerShieldMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 325 && mouseY < 400) if (playerStatPoints > 0) {playerDefense = playerDefense * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 425 && mouseY < 500) if (playerStatPoints > 0) {playerAttack = playerAttack * 1.05; playerStatPoints--;}
  }
}

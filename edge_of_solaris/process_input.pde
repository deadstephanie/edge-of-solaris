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
      if (keyInput[5] == true) { //q, mg weapon
        playerWeapon = 0;
      }
      if (keyInput[6] == true) { //e, snipe weapon
        playerWeapon = 4;
      }
      if (keyInput[7] == true) { //r, spread weapon
        playerWeapon = 1;
      }
      if (keyInput[8] == true) { //p, pause game
        paused = true;
        keyInput[8] = false;
      }
      if (keyInput[9] == true) { //z, secondary weapon 1
        playerSecondWeapon = 0;
      }
      if (keyInput[10] == true) { //x secondary weapon 2
        playerSecondWeapon = 1;
      }
      if (keyInput[11] == true) { //1, beam cannon primary weapon
        playerWeapon = 2;
      }
      if (keyInput[12] == true) { //2, mg primary weapon
        playerWeapon = 0;
      }
      if (keyInput[13] == true) { //3, snipe primary weapon
        playerWeapon = 4;
      }
      if (keyInput[14] == true) { //4, spread primary weapon
        playerWeapon = 1;
      }
  } else if (screenIndex == 0 && paused == true && levelEnd == false) { //if game is paused and level is not complete
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
      advanceVNText();
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
  if (key == 'z' || key == 'Z')  keyInput[9] = true;
  if (key == 'x' || key == 'X')  keyInput[10] = true;
  if (key == '1') keyInput[11] = true;
  if (key == '2') keyInput[12] = true;
  if (key == '3') keyInput[13] = true;
  if (key == '4') keyInput[14] = true;
  if (key == '5') keyInput[15] = true;
  if (key == '6') keyInput[16] = true;
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
  if (key == 'z' || key == 'Z')  keyInput[9] = false;
  if (key == 'x' || key == 'X')  keyInput[10] = false;
  if (key == '1') keyInput[11] = false;
  if (key == '2') keyInput[12] = false;
  if (key == '3') keyInput[13] = false;
  if (key == '4') keyInput[14] = false;
  if (key == '5') keyInput[15] = false;
  if (key == '6') keyInput[16] = false;
}

void playerShoot() {
  if (playerWeapon == 0) { //machine gun
    if (timing > playerWeaponCooldown0) {
      playerWeaponMove0 = random(2) - 1;
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, playerWeaponMove0, playerWeapon, 10, 10, playerWeaponPower0 * playerAttack, 0);
      timing = 0;
    }
  } else if (playerWeapon == 1) { //spread shot
    if (timing > playerWeaponCooldown1) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 0, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY + 0.2, 10, 0.2, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY + 0.4, 10, 0.5, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY - 0.2, 10, -0.2, playerWeapon, 10, 10, playerWeaponPower1 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY - 0.4, 10, -0.5 , playerWeapon, 10, 10, playerWeaponPower1 * playerAttack, 0);
      timing = 0;
    }
  } else if (playerWeapon == 2) { //dual beam cannon
      if (timing > playerWeaponCooldown2) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY + 7, 20, 0, playerWeapon, 80, 10, playerWeaponPower2 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY - 7, 20, 0, playerWeapon, 80, 10, playerWeaponPower2 * playerAttack, 0);
      timing = 0;
    }
  } else if (playerWeapon == 4) { //sniper shot
      if (timing > playerWeaponCooldown4) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 50, 0, playerWeapon, 200, 10, playerWeaponPower4 * playerAttack, 0);
      timing = 0;
    }
  }
  if (playerSecondWeapon == 0) { //basic secondary rockets
    if (secondTiming > playerWeaponCooldown100) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, +10, playerSecondWeapon + 100, 20, 10, playerWeaponPower100 * playerAttack, 0);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, -10, playerSecondWeapon + 100, 20, 10, playerWeaponPower100 * playerAttack, 0);
      secondTiming = 0;
    }
  } else if (playerSecondWeapon == 1) { //tracking missile
    if (secondTiming > playerWeaponCooldown101) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 5, 0, playerSecondWeapon + 100, 10, 10, playerWeaponPower101 * playerAttack, 0);
      secondTiming = 0;
    }
  }
}

void mousePressed() {
  if (screenIndex == 2) {//menu screen
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 5; //status button
    else if (mouseX > 950 && mouseX < 1250 && mouseY > 125 && mouseY < 200); //mess hall button
    else if (mouseX > 950 && mouseX < 1250 && mouseY > 225 && mouseY < 300); //hanger button
    else if (mouseX > 950 && mouseX < 1250 && mouseY > 325 && mouseY < 400) screenIndex = 8; //engineering buttton
    else if (mouseX > 950 && mouseX < 1250 && mouseY > 425 && mouseY < 500) screenIndex = 4; //settings button 
    else if (mouseX > 950 && mouseX < 1250 && mouseY > 525 && mouseY < 600) saveSave(); //save button 
    else if (mouseX > 50 && mouseX < 450 && mouseY > 25 && mouseY < 100) screenIndex = 3; //story button
    else if (mouseX > 50 && mouseX < 450 && mouseY > 125 && mouseY < 200) levelStart(0); //level 00
    else if (mouseX > 50 && mouseX < 450 && mouseY > 225 && mouseY < 300) levelStart(1); //level 01
    else if (mouseX > 50 && mouseX < 450 && mouseY > 325 && mouseY < 400) levelStart(2); //performance test level
  } else if (screenIndex == 3) { //vn segments
    if (mouseX > 1150 && mouseX < 1250 && mouseY > 650 && mouseY < 690) { //next button
      advanceVNText();
    }
    else if (mouseX > 1040 && mouseX < 1140 && mouseY > 650 && mouseY < 690); //skip button (currently doesnt do anything
  } else if (screenIndex == 4) { //settings menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) {screenIndex = 2; saveSettings();} //back button (also saves settings)
    else if (mouseX > 50 && mouseX < 450 && mouseY > 25 && mouseY < 100) oneHitMode = !oneHitMode; //pause on restart button
    else if (mouseX > 50 && mouseX < 450 && mouseY > 225 && mouseY < 300) {image(shadow, 500, 500); image(shadow2, 1000, 500); image(shadow3, 500, 200); shadowFactor++;} //shadow
    else if (mouseX > 50 && mouseX < 450 && mouseY > 125 && mouseY < 200) damageOnTop = !damageOnTop; //damage on top button
  } else if (screenIndex == 5) { //stats menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 2; //back button
    else if (mouseX > 625 && mouseX < 700 && mouseY > 125 && mouseY < 200) if (playerStatPoints > 0) {playerHPMax = playerHPMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 225 && mouseY < 300) if (playerStatPoints > 0) {playerShieldMax = playerShieldMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 325 && mouseY < 400) if (playerStatPoints > 0) {playerDefense = playerDefense * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 425 && mouseY < 500) if (playerStatPoints > 0) {playerAttack = playerAttack * 1.05; playerStatPoints--;}
  } else if (screenIndex == 8) { //engineering menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 2; //back button
    else if (mouseX > 60 && mouseX < 445 && mouseY > 170 && mouseY < 195 && playerMoney >= playerWeaponCost2) {playerMoney = playerMoney - playerWeaponCost2; playerWeaponLevel2++; calcWeaponStats();} //upgrade beam weapon
    else if (mouseX > 60 && mouseX < 445 && mouseY > 370 && mouseY < 395 && playerMoney >= playerWeaponCost0) {playerMoney = playerMoney - playerWeaponCost0; playerWeaponLevel0++; calcWeaponStats();} //upgrade mg weapon
    else if (mouseX > 60 && mouseX < 445 && mouseY > 570 && mouseY < 595 && playerMoney >= playerWeaponCost4) {playerMoney = playerMoney - playerWeaponCost4; playerWeaponLevel4++; calcWeaponStats();} //upgrade snipe weapon
    else if (mouseX > 485 && mouseX < 870 && mouseY > 170 && mouseY < 195 && playerMoney >= playerWeaponCost1) {playerMoney = playerMoney - playerWeaponCost1; playerWeaponLevel1++; calcWeaponStats();} //upgrade shotgun weapon
  }
}

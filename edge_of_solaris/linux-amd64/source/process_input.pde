void processInput() {
  if (keyInput[4] == true) intentConfirm(); //space key pressed
  if (usingDPAD == false && usingStick == false) { //do not process keyboard movement if other movement being used
    if (keyInput[0] == true) intentMove(0); //W key pressed
    if (keyInput[2] == true) intentMove(1); //D key pressed
    if (keyInput[1] == true) intentMove(2); //S key pressed
    if (keyInput[3] == true) intentMove(3); //A key pressed
  }
  if (keyInput[8] == true) intentPause(); //P key pressed
  if (keyInput[7] == true) intentRestart(); //R key pressed
  if (keyInput[5] == true) intentWeaponSwitchDown(); //Q key pressed
  if (keyInput[6] == true) intentWeaponSwitchUp(); //E key pressed
  if (keyInput[9] == true) intentSecondarySwitchDown(); //Z key pressed
  if (keyInput[10] == true) intentSecondarySwitchUp(); //X key pressed
  if (keyInput[20] == true) intentCancel(); //BACKSPACE pressed
  
  if (screenIndex == 0 && paused == false) { //in game and not paused
      if (mousePressed && (mouseButton == LEFT)) { //shoot with LMB
        playerShoot();
      }
      if (keyInput[0] == true) { //w
      //if (playerY > 10)
        //playerY = playerY - (playerMoveY * playerMoveBoost);
      }
      if (keyInput[1] == true) { //s
      //if (playerY < 600)
        //playerY = playerY + (playerMoveY * playerMoveBoost);
      }
      if (keyInput[2] == true) { //d
      //if (playerX < 1200)
        //playerX = playerX + (playerMoveX * playerMoveBoost);
      }
      if (keyInput[3] == true) { //a
      //if (playerX > 20)
        //playerX = playerX - (playerMoveX * playerMoveBoost);
      }
      if (keyInput[4] == true) { //space
        //playerShoot();
      }
      if (keyInput[5] == true && playerWeaponsUnlocked >= 1) { //q, mg weapon
        //playerWeapon = 0;
      }
      if (keyInput[6] == true && playerWeaponsUnlocked >= 2) { //e, snipe weapon
        //playerWeapon = 4;
      }
      if (keyInput[7] == true && playerWeaponsUnlocked >= 3) { //r, spread weapon
        //playerWeapon = 1;
      }
      if (keyInput[8] == true) { //p, pause game
        //paused = true;
        //keyInput[8] = false;
      }
      if (keyInput[9] == true) { //z, secondary weapon 1
        //playerSecondWeapon = 0;
      }
      if (keyInput[10] == true) { //x secondary weapon 2
        //playerSecondWeapon = 1;
      }
      if (keyInput[11] == true) { //1, beam cannon primary weapon
        playerWeapon = 2;
      }
      if (keyInput[12] == true && playerWeaponsUnlocked >= 1) { //2, mg primary weapon
        playerWeapon = 0;
      }
      if (keyInput[13] == true && playerWeaponsUnlocked >= 2) { //3, snipe primary weapon
        playerWeapon = 3;
      }
      if (keyInput[14] == true && playerWeaponsUnlocked >= 3) { //4, spread primary weapon
        playerWeapon = 1;
      }
  } else if (screenIndex == 0 && paused == true && levelEnd == false) { //if game is paused and level is not complete
        if (playerState != 255) { //check to ensure player is not dead
          if (keyInput[8] == true) { //p key
            //paused = false;
            //keyInput[8] = false;
          } 
        } else {
          if (keyInput[7] == true || keyInput[4] == true) { //r key or space key
            if (levelEditorMode == true) {
              loadLevel();
            }
            else levelStart(levelIndex); //restart the current level
            paused = false;
            keyInput[4] = false; //unset space key
          } else if (keyInput[5] == true) { //q key
            //TODO LEVEL EXIT HERE
            if (levelEditorMode == true) {
              playerHP = playerHPMax; //restore player hp
              playerX = 200;
              playerY = 250;
              screenIndex = 9; //set to level editor screen
              //redraw enemies
              initObjects(); //reset all enemies
              for(int i = 0; i < levelEnemyIndex; i++) {
                genEnemy(levelEnemyType[i], levelEnemyX[i], levelEnemyY[i]);
              }
            }
          }
        }
        
  } else if (screenIndex == 1) { //title screen
    if (keyInput[4] == true); //screenIndex = 2;
  } if (screenIndex == 3) { //vn
    if (keyInput[4] == true) {
      //advanceVNText();
    }
  } else if (screenIndex == 9) { //level editor
    /*if (keyInput[2] == true) scrollX++;
    if (keyInput[0] == true) scrollX = scrollX + 10;
    if (keyInput[3] == true) scrollX--;
    if (keyInput[1] == true) scrollX = scrollX - 10;
    if (scrollX < 0) scrollX = 0; //dont let scroll go negative*/
    if (keyInput[4] == true) {levelEnemyTypeSelected++; keyInput[4] = false;} //press space to cycle enemies
    if (levelEnemyTypeSelected > 7) levelEnemyTypeSelected = 0; //reset it overflow
    if (keyInput[8] == true) saveLevel(); //save the level to a JSON
    if (keyInput[17] == true) intentLevelEditor(6); //go back to level select
    if (keyInput[18] == true) loadLevel(); //try to load the editor save
    if (keyInput[19] == true) { //playtest level
      intentLevelEditor(5);
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
  if (key == 'm' || key == 'M') keyInput[17] = true;
  if (key == 'l' || key == 'L') keyInput[18] = true;
  if (key == 't' || key == 'T') keyInput[19] = true;
  if (key == BACKSPACE) keyInput[20] = true;
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
  if (key == 'm' || key == 'M') keyInput[17] = false;
  if (key == 'l' || key == 'L') keyInput[18] = false;
  if (key == 't' || key == 'T') keyInput[19] = false;
  if (key == BACKSPACE) keyInput[20] = false;
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
  } else if (playerWeapon == 3) { //sniper shot
      if (timing > playerWeaponCooldown3) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 50, 0, playerWeapon, 200, 10, playerWeaponPower3 * playerAttack, 0);
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
    if (areaIndex == 0) { //debug area
      if (mouseX > 50 && mouseX < 750 && mouseY > 25 && mouseY < 100) {screenIndex = 3;textIndex = scriptStartPoints[0];} //story button
      else if (mouseX > 50 && mouseX < 750 && mouseY > 125 && mouseY < 200) levelStart(0); //level 00
      else if (mouseX > 50 && mouseX < 750 && mouseY > 225 && mouseY < 300) levelStart(1); //level 01
      else if (mouseX > 50 && mouseX < 750 && mouseY > 325 && mouseY < 400) levelStart(98); //performance test level
      else if (mouseX > 50 && mouseX < 750 && mouseY > 425 && mouseY < 500) levelStart(99); //performance test level 2
    } else if (areaIndex == 1) { //first area
      if (mouseX > 50 && mouseX < 750 && mouseY > 25 && mouseY < 100) {screenIndex = 3;textIndex = scriptStartPoints[0];} //story button
      if (mouseX > 50 && mouseX < 750 && mouseY > 325 && mouseY < 400) {screenIndex = 9; initObjects(); scrollX = 0;} //level editor button
      if (mouseX > 50 && mouseX < 750 && mouseY > 425 && mouseY < 500) areaIndex = 0; //debug button
    }
  } else if (screenIndex == 3) { //vn segments
    if (mouseX > 1150 && mouseX < 1250 && mouseY > 650 && mouseY < 690) { //next button
      advanceVNText();
    }
    else if (mouseX > 1040 && mouseX < 1140 && mouseY > 650 && mouseY < 690); //skip button (currently doesnt do anything
  } else if (screenIndex == 4) { //settings menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) {screenIndex = 2; saveSettings();} //back button (also saves settings)
    else if (mouseX > 50 && mouseX < 450 && mouseY > 25 && mouseY < 100) oneHitMode = !oneHitMode; //one hit death mode
    else if (mouseX > 50 && mouseX < 450 && mouseY > 225 && mouseY < 300) {image(shadow, 500, 500); image(shadow2, 1000, 500); image(shadow3, 500, 200); shadowFactor++;} //shadow
    else if (mouseX > 50 && mouseX < 450 && mouseY > 125 && mouseY < 200) damageOnTop = !damageOnTop; //damage on top button
  } else if (screenIndex == 5) { //stats menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) screenIndex = 2; //back button
    else if (mouseX > 625 && mouseX < 700 && mouseY > 125 && mouseY < 200) if (playerStatPoints > 0) {playerHPMax = playerHPMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 225 && mouseY < 300) if (playerStatPoints > 0) {playerShieldMax = playerShieldMax * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 325 && mouseY < 400) if (playerStatPoints > 0) {playerDefense = playerDefense * 1.05; playerStatPoints--;}
    if (mouseX > 625 && mouseX < 700 && mouseY > 425 && mouseY < 500) if (playerStatPoints > 0) {playerAttack = playerAttack * 1.05; playerStatPoints--;}
  } else if (screenIndex == 8) { //engineering menu
    if (mouseX > 950 && mouseX < 1250 && mouseY > 25 && mouseY < 100) if (areaIndex == 2) {screenIndex = 3; textIndex = scriptStartPoints[3];} else screenIndex = 2; //back button
    else if (mouseX > 60 && mouseX < 445 && mouseY > 170 && mouseY < 195 && playerMoney >= playerWeaponCost2) {playerMoney = playerMoney - playerWeaponCost2; playerWeaponLevel2++; calcWeaponStats();} //upgrade beam weapon
    else if (mouseX > 60 && mouseX < 445 && mouseY > 370 && mouseY < 395 && playerMoney >= playerWeaponCost0) {playerMoney = playerMoney - playerWeaponCost0; playerWeaponLevel0++; calcWeaponStats();} //upgrade mg weapon
    else if (mouseX > 60 && mouseX < 445 && mouseY > 570 && mouseY < 595 && playerMoney >= playerWeaponCost3) {playerMoney = playerMoney - playerWeaponCost3; playerWeaponLevel3++; calcWeaponStats();} //upgrade snipe weapon
    else if (mouseX > 485 && mouseX < 870 && mouseY > 170 && mouseY < 195 && playerMoney >= playerWeaponCost1) {playerMoney = playerMoney - playerWeaponCost1; playerWeaponLevel1++; calcWeaponStats();} //upgrade shotgun weapon
  } else if (screenIndex == 9) { //level editor
    //place an enemy
    if (mouseButton == LEFT) { //only place if LMB pressed
      genEnemy(levelEnemyTypeSelected, mouseX + scrollX, mouseY);
      levelEnemyType[levelEnemyIndex] = levelEnemyTypeSelected;
      levelEnemyX[levelEnemyIndex] = mouseX + scrollX;
      levelEnemyY[levelEnemyIndex] = mouseY;
      levelEnemyIndex++;
    } else if (mouseButton == RIGHT) { //undo
      intentLevelEditor(1);
    } else if (mouseButton == CENTER) { //reset enemies
      initObjects(); //reset all enemies
      for(int i = 0; i < levelEnemyIndex; i++) {
        genEnemy(levelEnemyType[i], levelEnemyX[i], levelEnemyY[i]);
      }
    }
  }
}

void controllerSupport() { //scans for controllers, reads inputs, etc
  ControllerIndex currController = controllers.getControllerIndex(0);
  controllers.update();
  
  try {
    if (currController.isButtonPressed(ControllerButton.A)) {
      intentConfirm();
    } else { //if A not pressed
      btnAdvanceA = true; //release A button, allow vn to advance again
    }
    if (currController.isButtonPressed(ControllerButton.DPAD_UP)) {
      usingDPAD = true;
      intentMove(0);
    }
    if (currController.isButtonPressed(ControllerButton.DPAD_RIGHT)) {
      usingDPAD = true;
      intentMove(1);
    }
    if (currController.isButtonPressed(ControllerButton.DPAD_DOWN)) {
      usingDPAD = true;
      intentMove(2);
    }
    if (currController.isButtonPressed(ControllerButton.DPAD_LEFT)) {
      usingDPAD = true;
      intentMove(3);
    }
    if (usingDPAD == false) btnAdvanceMenu = true; //release menu nav buttons if no dpad being pressed
    if (usingDPAD == false && paused == false) { //only allow stick movement if dpad not pressed this frame and game not paused
      if (abs(currController.getAxisState(ControllerAxis.LEFTX)) > 0.05) { //deadzone
        usingStick = true;
        if (screenIndex == 0) playerX = playerX + (playerMoveX * playerMoveBoost * constrain(currController.getAxisState(ControllerAxis.LEFTX), -1, 1));
        else if (screenIndex == 9) cursorX = cursorX + (10 * constrain(currController.getAxisState(ControllerAxis.LEFTX), -1, 1));
      }
      if (abs(currController.getAxisState(ControllerAxis.LEFTY)) > 0.05) { //deadzone
        usingStick = true;
        if (screenIndex == 0) playerY = playerY - (playerMoveY * playerMoveBoost * constrain(currController.getAxisState(ControllerAxis.LEFTY), -1, 1));
        else if (screenIndex == 9) cursorY = cursorY - (10 * constrain(currController.getAxisState(ControllerAxis.LEFTY), -1, 1));
      }
    }
    if (currController.getAxisState(ControllerAxis.TRIGGERLEFT) > 0.1) {
      intentSecondarySwitchDown();
    } else if (currController.getAxisState(ControllerAxis.TRIGGERRIGHT) > 0.1) {
      intentSecondarySwitchUp();
    } else btnAdvanceSec = true; //if neither trigger is pressed
    if (currController.isButtonPressed(ControllerButton.B)) {
      intentCancel();
    } else btnAdvanceCancel = true;
    if (currController.isButtonPressed(ControllerButton.LEFTBUMPER)) {
      intentWeaponSwitchUp();
    }
    else if (currController.isButtonPressed(ControllerButton.RIGHTBUMPER)) {
      intentWeaponSwitchDown();
    } else btnAdvanceWpn = true; //if neither bumper is pressed
    if (currController.isButtonPressed(ControllerButton.START)) {
      if (screenIndex == 9 && btnAdvancePause == true) {btnAdvancePause = false; intentLevelEditor(5);}
      intentPause();
    } else btnAdvancePause = true;
    if (currController.isButtonPressed(ControllerButton.Y)) {
      intentLevelEditor(0);
    } else btnAdvanceY = true;
    if (currController.isButtonPressed(ControllerButton.BACK)) {
      if (btnAdvanceBack == true) {
        btnAdvanceBack = false;
        useControllerForCursor = !useControllerForCursor;
      }
    } else btnAdvanceBack = true;
    if (currController.isButtonPressed(ControllerButton.RIGHTSTICK)) {
      intentLevelEditor(6);
    }
  } catch (ControllerUnpluggedException e) {   
    btnAdvanceA = true; //vn advance always true if no controller
    btnAdvancePause = true; //always true if no controller
    btnAdvanceWpn = true;
    btnAdvanceSec = true;
    btnAdvanceMenu = true;
  }
}

void intentConfirm() { //called when space/A are pressed
  if (paused == false) { //if not paused
    if (screenIndex == 0) { //in game
      playerShoot();
    } else if (screenIndex == 3) { //vn segments
      if (btnAdvanceA == true) { //used to prevent skipping segments by holding A
        advanceVNText();
        btnAdvanceA = false; //latch A button
        keyInput[20] = false; //latch backspace
      }
    }
  } else { //if paused
    if (levelEnd == true && btnAdvanceA == true) {
      levelEnd();
      btnAdvanceA = false;
    } else if (playerState == 255) { //dead
      intentRestart(); //restart level
    }
  } if (screenIndex == 2 || screenIndex == 1 || screenIndex == 5 || screenIndex == 8 || screenIndex == 4) {
    if (btnAdvanceA == true) {
      btnAdvanceA = false; //latch A
      keyInput[4] = false; //latch space
      intentConfirmMenu();
    }
  } else if (screenIndex == 9) {
    if (btnAdvanceA == true) {
      intentLevelEditor(2);
    }
  }
}

void intentCancel() { //called when backspace/B are pressed
  if (btnAdvanceCancel == true) {
    btnAdvanceCancel = false;
    if (screenIndex != 0 && screenIndex != 3 && screenIndex != 9) {
      if (screenIndex == 4) saveSettings(); //save settings if exiting settings menu
      if (areaIndex == 2 && screenIndex == 8) {screenIndex = 3; textIndex = scriptStartPoints[3];}
      else screenIndex = 2; //go to level select as long as not in game/in vn
      menuIndexX = 0;
      menuIndexY = 0;
    } else if (screenIndex == 9) { //level editor
      intentLevelEditor(1);
    }
  }
}

void intentMove(int direction) {
  if (screenIndex == 0) { //gameplay
    if (paused == false) { //ensure game is not paused
      if (direction == 0) { //up direction
        playerY = playerY - (playerMoveY * playerMoveBoost);
      } if (direction == 2) { //down direction
        playerY = playerY + (playerMoveY * playerMoveBoost);
      }
      if (direction == 1) { //right direction
        playerX = playerX + (playerMoveX * playerMoveBoost);
      } if (direction == 3) { //left direction
        playerX = playerX - (playerMoveX * playerMoveBoost);
      }
    } else { //if paused

    }
  } else if (screenIndex == 2 || screenIndex == 5 || screenIndex == 8 || screenIndex == 4) { //level select, status, engineering, settings
    if (btnAdvanceMenu == true) {
      keyInput[0] = false; //latch wasd
      keyInput[1] = false;
      keyInput[2] = false;
      keyInput[3] = false;
      btnAdvanceMenu = false;
      if (direction == 0 && menuIndexY > 0) menuIndexY--;
      if (direction == 2) menuIndexY++;
      if (direction == 3 && menuIndexX > 0) menuIndexX--;
      if (direction == 1) menuIndexX++;
      if (direction == 3 || direction == 1) menuIndexY = 0;
    }
  } else if (screenIndex == 9) { //level editor
    if (direction == 0) scrollX = scrollX + 10;
    if (direction == 1) scrollX++;
    if (direction == 2) scrollX = scrollX - 10;
    if (direction == 3) scrollX--;
    if (scrollX < 0) scrollX = 0; //dont let scroll go negative
  }
}

void intentPause() { //P or Start btn
  if (screenIndex == 0) { //gameplay screen
    if (btnAdvancePause == true) {
      if (paused == false) { //if not paused
        paused = true; //pause game
        btnAdvancePause = false; //latch start btn
        keyInput[8] = false; //latch p key
      } else { //if paused
        paused = false; //unpuase game
        btnAdvancePause = false; //latch start btn
        keyInput[8] = false; //latch p key
      }
    }
  }
}

void intentRestart() {
  if (screenIndex == 0) { //gameplay screen
    if (paused == true) { //if game is paused
      if (btnAdvanceA == true) {
        if (levelEditorMode == true) loadLevel(); //load level editor level
        else levelStart(levelIndex); //normal load level
        paused = false; //unpause game
      }
    }
  }
}

void intentWeaponSwitchUp() {
  if (screenIndex == 0) { //gameplay
    if (btnAdvanceWpn == true) {
      playerWeapon++; //increment weapon
      if (playerWeapon > playerWeaponsUnlocked) playerWeapon = 0; //reset if overflow past unlocked
      btnAdvanceWpn = false; //latch bumpers
      keyInput[6] = false; //latch E key
    }
  } if (screenIndex == 9) { //level editor
    if (btnAdvanceWpn == true) {
      intentLevelEditor(3);
    }
  }
}

void intentWeaponSwitchDown() {
  if (screenIndex == 0) { //gameplay
    if (btnAdvanceWpn == true) {
      playerWeapon--; //increment weapon
      if (playerWeapon < 0) playerWeapon = playerWeaponsUnlocked; //reset if overflow past unlocked
      btnAdvanceWpn = false; //latch bumpers
      keyInput[5] = false; //latch Q key
    }
  }
}

void intentSecondarySwitchUp() {
  if (screenIndex == 0) { //gameplay
    if (btnAdvanceSec == true) {
      playerSecondWeapon++; //increment secondary weapon
      if (playerSecondWeapon > playerSecondariesUnlocked) playerSecondWeapon = 0; //reset if overflow past unlocked
      btnAdvanceSec = false;
      keyInput[10] = false; //latch X key
    }
  }
}

void intentSecondarySwitchDown() {
  if (screenIndex == 0) { //gameplay
    if (btnAdvanceSec == true) {
      playerSecondWeapon--; //increment secondary weapon
      if (playerSecondWeapon < 0) playerSecondWeapon = playerSecondariesUnlocked; //reset if overflow past unlocked
      btnAdvanceSec = false;
      keyInput[9] = false; //latch Z key
    }
  }
}

void intentConfirmMenu() {
  if (screenIndex == 2) { //level select
    if (areaIndex == 0) {
      if (menuIndexX == 0) {
        if (menuIndexY == 0) {screenIndex = 3;textIndex = scriptStartPoints[0];} //story button
        else if (menuIndexY == 1) levelStart(0); //level 00
        else if (menuIndexY == 2) levelStart(1); //level 01
        else if (menuIndexY == 3) levelStart(98); //perf level 1
        else if (menuIndexY == 4) levelStart(99); //perf level 2
      } 
    } else if (areaIndex == 1) {
      if (menuIndexX == 0) {
        if (menuIndexY == 0) {screenIndex = 3;textIndex = scriptStartPoints[0];} //story button
        else if (menuIndexY == 1);
        else if (menuIndexY == 2);
        else if (menuIndexY == 3) {screenIndex = 9; initObjects(); scrollX = 0;} //level editor
        else if (menuIndexY == 4) areaIndex = 0; //debug menu
    }  
    }if (menuIndexX == 1) {
      if (menuIndexY == 0) screenIndex = 5; //status
      else if (menuIndexY == 1) screenIndex = 6; //mess hall
      else if (menuIndexY == 2) screenIndex = 7; //hanger
      else if (menuIndexY == 3) screenIndex = 8; //engineering
      else if (menuIndexY == 4) screenIndex = 4; //settings
      else if (menuIndexY == 5) saveSave(); //save game
    
  }
    
    menuIndexX = 0;
    menuIndexY = 0;
  } else if (screenIndex == 1) { //title screen
    screenIndex = 2;
  } else if (screenIndex == 4) { //settings
    if (menuIndexX == 0) {
      if (menuIndexY == 0) oneHitMode = !oneHitMode; //one hit death mode
      else if (menuIndexY == 1) damageOnTop = !damageOnTop; //damage on top button
      else if (menuIndexY == 2) {shadowDisp = true; shadowFactor++;} //shadow
    }
  } else if (screenIndex == 5) { //status menu
    if (menuIndexX == 0) {
      if (menuIndexY == 0 && playerStatPoints > 0) {playerHPMax = playerHPMax * 1.05; playerStatPoints--;} //hp stat up
      else if (menuIndexY == 1 && playerStatPoints > 0) {playerShieldMax = playerShieldMax * 1.05; playerStatPoints--;} //shield stat up
      else if (menuIndexY == 2 && playerStatPoints > 0) {playerDefense = playerDefense * 1.05; playerStatPoints--;} //def stat up
      else if (menuIndexY == 3 && playerStatPoints > 0) {playerAttack = playerAttack * 1.05; playerStatPoints--;} //attack stat up
    }
  } else if (screenIndex == 6) { //mess hall
    
  } else if (screenIndex == 7) { //hanger
  
  } else if (screenIndex == 8) { //engineering
    if (menuIndexX == 0) {
      
      if (menuIndexY == 0 && playerMoney >= playerWeaponCost2) {playerMoney = playerMoney - playerWeaponCost2; playerWeaponLevel2++; calcWeaponStats();} //upgrade beam weapon
      else if (menuIndexY == 1 && playerMoney >= playerWeaponCost0) {playerMoney = playerMoney - playerWeaponCost0; playerWeaponLevel0++; calcWeaponStats();} //upgrade mg weapon
      else if (menuIndexY == 2 &&playerMoney >= playerWeaponCost3) {playerMoney = playerMoney - playerWeaponCost3; playerWeaponLevel3++; calcWeaponStats();} //upgrade snipe weapon
    } else if (menuIndexX == 1) {
      if (menuIndexY == 0 && playerMoney >= playerWeaponCost1) {playerMoney = playerMoney - playerWeaponCost1; playerWeaponLevel1++; calcWeaponStats();} //upgrade shotgun weapon
    }
  }
}

void intentLevelEditor (int command) {
  if (screenIndex == 9) { //level editor screen
    if (command == 0 && btnAdvanceY == true) { //cycle enemies
    btnAdvanceY = false;
    keyInput[4] = false;
    levelEnemyTypeSelected++;
    if (levelEnemyTypeSelected > 7) levelEnemyTypeSelected = 0; //reset if overflow
    } else if (command == 1) { //undo
      if (levelEnemyIndex > 0) levelEnemyIndex--;
      //redraw enemies
      initObjects(); //reset all enemies
      for(int i = 0; i < levelEnemyIndex; i++) {
        genEnemy(levelEnemyType[i], levelEnemyX[i], levelEnemyY[i]);
      }
    } else if (command == 2) { //place enemy
      btnAdvanceA = false;
      if (useControllerForCursor == false) {
        cursorX = mouseX;
        cursorY = mouseY;
      }
      genEnemy(levelEnemyTypeSelected, (int)cursorX + scrollX, (int)cursorY);
      levelEnemyType[levelEnemyIndex] = levelEnemyTypeSelected;
      levelEnemyX[levelEnemyIndex] = (int)cursorX + scrollX;
      levelEnemyY[levelEnemyIndex] = (int)cursorY;
      levelEnemyIndex++;
    } else if (command == 3) { //load from file
      loadLevel();
    } else if (command == 4) { //save to file
      saveLevel();
    } else if (command == 5) { //playtest level
      screenIndex = 0;
      levelEditorMode = true;
      //redraw enemies
      initObjects(); //reset all enemies
      for(int i = 0; i < levelEnemyIndex; i++) {
        genEnemy(levelEnemyType[i], levelEnemyX[i], levelEnemyY[i]);
      }
    } else if (command == 6) { //exit
      screenIndex = 2; 
      levelEditorMode = false;
    }
  }
}

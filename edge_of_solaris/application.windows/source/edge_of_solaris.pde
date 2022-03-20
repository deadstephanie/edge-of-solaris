bullet[] blts;
enemy[] basicE;
starsBG[] stars;
damage[] dmg;

PImage naturals1;
PImage naturals2;
PImage naturals3;
PImage naturals4;
PImage naturals5;
PImage player1;
PImage vnPlayer1;
PImage vnPlayer2;
PImage vnPlayer1r;
PImage vnPlayer2r;
PImage vnSol1;
PImage vnSol2;
PImage vnSol3;
PImage vnSol1r;
PImage vnSol2r;
PImage vnSol3r;
PImage vnEsence1;
PImage vnEsence2;
PImage vnEsence3;
PImage vnEsence4;
PImage vnEsence1r;
PImage vnEsence2r;
PImage vnEsence3r;
PImage vnEsence4r;
PImage vnVeda1;
PImage vnVeda2;
PImage vnVeda3;
PImage vnVeda4;
PImage vnVeda1r;
PImage vnVeda2r;
PImage vnVeda3r;
PImage vnVeda4r;
PImage vnCyana1;
PImage vnCyana2;
PImage vnCyana3;
PImage vnCyana4;
PImage settingsBtn;
PImage shadow;
PImage shadow2;
PImage shadow3;

PrintWriter settingsOut;
PrintWriter OSver;
JSONObject settingsJSON;

import java.io.*;

void setup(){
  size(1280, 720);
  frameRate(60);
  blts = new bullet[bulletCount];
  basicE = new enemy[basicECount];
  stars = new starsBG[starCount];
  dmg = new damage[dmgCount];
  initObjects(); //initializes all objects to "default" values
  loadText(); //load the text file for visual novel text
  loadSprites(); //load in png images for sprites
  loadSave(); //load the gamesave.sav file
  scanForStartPoints();
}

void draw() {
  processInput();
  drawFrame();
  drawUI();
  if (screenIndex == 3) {
    fill(0);
    rect(0, 0, 100, 50);
  }
  fill(200, 50, 50);
  textSize(24);
  text(frameRate, 20, 20);
  if (paused == false) {
    if (timing < 255) timing++;
    if (secondTiming < 255) secondTiming++;
  }
}

void drawFrame() {
  if (screenIndex == 0) {
    if (paused == false) {
     //render background
     if (levelType == 1) background(180, 248, 255);
     else if (levelType == 2) background(0);
      
    if (levelType == 2 || levelType == 1) {
      for (starsBG stars : stars) {
        stars.update();
        stars.display();
      }
    }
    
    for (enemy basicE : basicE) {
      basicE.update();
      basicE.collision();
      basicE.shoot();
      basicE.display();
    }
    for (bullet blts : blts) {
      blts.update();
      blts.display();
    }
    for (damage dmg : dmg) {
      dmg.update();
    }
    if (damageOnTop ==false) {
      for (damage dmg : dmg) {
        dmg.display();
      }
    }
    
    if (levelType == 0) { //over land
      
    } else if (levelType == 1) { //over water
      noStroke();
      fill(50, 50, 255);
      ellipse(640, 750, 2000, 200);
    } 
    levelEndCheckTimer++;
    if (levelEndCheckTimer > 60) { //check to see if all enemies are dead once a second
      levelEndCheckTimer = 0;
      for (int i = 0; i < basicECount; i++) {
        if (basicE[i].enemyState != 2) {
          break; //break out of loop for efficiency
        }else if (i == (basicECount - 1)) {
          levelEnd = true; //switch to level end screen
          keyInput[4] = false; //release space key
          paused = true; //put game in paused state
          break; //break out of loop for efficiency
        }
      }
    }
    
    //draw player
    playerCollision();
    if (playerShield < playerShieldMax) playerShield = playerShield + playerShieldRegen; //regen shield if depleted
    if (playerShield > playerShieldMax) playerShield = playerShieldMax; //ensure shield does not increase past max
    if (playerState == 0) setRect(1); //if player not being hurt
    else { //if player being hurt
      setRect(2); 
      playerState--;  //reset player state
      rect(playerX, playerY + 10, playerHitX, playerHitY - 10, 10); //render player hurt state
    }
    
    if (playerHP <= 0) { //if player dies
      paused = true; //pause game
      playerState = 255; //set player as dead
      playerAnimTiming = 30; //set timer for death anim
      keyInput[4] = false; //unset space key
    }
    
    //render the engine glow effect
    noStroke();
    fill(0, 127, 255, 100);
    ellipse(playerX - 6, playerY + 12.5, 30 + abs(playerEngineTimer / 3), 10);
    fill(0, 165, 255, 120);
    ellipse(playerX - 3, playerY + 12.5, 20 + abs(playerEngineTimer / 3), 10);
    fill(60, 240, 255, 150);
    ellipse(playerX - 1, playerY + 12.5, 15 + abs(playerEngineTimer / 3), 8);
    fill(100, 240, 255, 200);
    ellipse(playerX - 1, playerY + 12.5, 10 + abs(playerEngineTimer / 3), 6);
    playerEngineTimer++;
    if (playerEngineTimer == 15) playerEngineTimer = -15;
    
    image(player1, playerX - 5, playerY - 5); //player sprite
    
    if (damageOnTop == true) {
      for (damage dmg : dmg) {
        dmg.display();
      }
    }
    } else if (paused == true) { //if game is paused
           //render background
     if (levelType == 1) background(180, 248, 255);
     else if (levelType == 2) background(0);
      
    if (levelType == 2 || levelType == 1) {
      for (starsBG stars : stars) {
        stars.display();
      }
    }
    
    for (enemy basicE : basicE) {
      basicE.display();
    }
    for (bullet blts : blts) {
      blts.display();
    }
    if (damageOnTop == false) {
      for (damage dmg : dmg) {
        dmg.display();
      }
    }
    if (levelType == 0) { //over land
      
    } else if (levelType == 1) { //over water
      noStroke();
      fill(50, 50, 255);
      ellipse(640, 750, 2000, 200);
    }
    if (playerState == 255) { //if player dead
      if (playerAnimTiming != 0) {
        fill(255, 127, 0, 100);
        ellipse(playerX + 30, playerY + 7, (playerHitX / 3) + (playerAnimTiming * 5), (playerHitY / 2) + (playerAnimTiming * 3));
        fill(255, 165, 0, 120);
        ellipse(playerX + 30, playerY + 7, (playerHitX / 3) + (playerAnimTiming * 4), (playerHitY / 2) + (playerAnimTiming * 2));
        fill(255, 240, 60, 150);
        ellipse(playerX + 30, playerY + 7, (playerHitX / 3) + (playerAnimTiming * 3), (playerHitY / 2) + (playerAnimTiming * 1));
        playerAnimTiming--;
      }
      textSize(60);
      fill(255, 50, 50);
      text("YOU DIED", 550, 350);
      textSize(48);
      text("Press R or Space to restart", 400, 450);
      
    } else {
      image(player1, playerX - 5, playerY - 5); //player sprite if player is not dead
      if (levelEnd == true) { //if on level end screen
      textSize(60);
      fill(255, 50, 50);
      text("Level Complete", 550, 350);
      textSize(48);
      text("Press Space to continue", 490, 450);
      if (keyInput[4] == true) levelEnd();
    } else { //if paused, player not dead and level not complete
      textSize(60);
      fill(255, 50, 50);
      text("PAUSED", 550, 350);
    }
    }
    if (damageOnTop == true) {
      for (damage dmg : dmg) {
        dmg.display();
      }
    }
    
    
    }
  } else if (screenIndex == 1) {
    resetObjects(); //reset objects on non game screens 
  } else if (screenIndex == 3) {
    drawVN();
  }
}

void drawUI() {
  if (screenIndex == 0) { //in game
    textSize(25);
    fill(255);
    //text("Q, E, R switch weapons", 50, 640);
    
    //render hp and shield bars
    if (oneHitMode == false) {
      stroke(0);
      strokeWeight(15);
      fill(0);
      rect(20, 650, 200, 50, 10);
      rect(235, 650, 200, 50, 10);
      setRect(4);
      if (playerHP >= 0) rect(23, 653.5, (195 * (playerHP / playerHPMax)), 44);
      setRect(5);
      rect(238, 653.5, (194 * (playerShield / playerShieldMax)), 44);
      setRect(3); //render surrounds
      noFill();
      rect(20, 650, 200, 50, 10);
      rect(235, 650, 200, 50, 10);
      fill(0);
    }
    
    //render weapon selector
    stroke(255);
    strokeWeight(2);
    rect(450, 653, 30, 20, 5);
    rect(450, 678, 30, 20, 5);
    rect(485, 653, 30, 20, 5);
    rect(485, 678, 30, 20, 5);
  } else if (screenIndex == 1) { //title page
    background(0);
    fill(200, 200, 255, 120);
    textSize(130);
    text("Edge Of Solaris", 240, 120);
    text("Edge Of Solaris", 248, 120);
    fill(200, 200, 255, 255);
    textSize(128);
    text("Edge Of Solaris", 250, 120);
    fill(200, 200, 255);
    textSize(90);
    text("random tagline in space", 200, 240);
    textSize(64);
    text("new game", 500, 400);
    text("continue", 500, 500);
    text("press space to continue (temp)", 50, 650);
    textSize(24);
    text("build " + buildNumber, 1175, 700);
  } else if (screenIndex == 2) { //level select
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950, 25, 300, 75);
    rect(950, 125, 300, 75);
    rect(950, 225, 300, 75);
    rect(950, 325, 300, 75);
    //draw level select rects
    rect(50, 25, 400, 75);
    rect(50, 125, 400, 75);
    rect(50, 225, 400, 75);
    rect(50, 325, 400, 75);
    //draw options button
    image(settingsBtn, 1000, 450, 200, 200);
    noStroke();
    fill(255);
    textSize(48);
    text("status", 975, 75);
    text("mess hall", 975, 175);
    text("hanger", 975, 275);
    text("engineering", 975, 375);
    text("launch story", 75, 75);
    text("level 00", 75, 175);
    text("level 01", 75, 275);
    text("test level", 75, 375);
  } else if (screenIndex == 4) { //settings menu
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950, 25, 300, 75);
    rect(50, 25, 400, 75);
    if (oneHitMode == true) {
      fill(0, 150, 0);
    }
    rect(475, 25, 75, 75);
    fill(50, 0, 50); // reset color
    if (damageOnTop == true) {
      fill(0, 150, 0);
    }
    rect(475, 125, 75, 75);
    fill(50, 0, 50); // reset color
    rect(50, 125, 400, 75);
    rect(50, 225, 400, 75);
    //draw options button
    noStroke();
    fill(255);
    textSize(48);
    text("Back", 975, 75);
    text("one hit mode", 75, 75);
    text("damage on top", 75, 175);
    text("shadow", 75, 275);
  } else if (screenIndex == 5) { //status window
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950, 25, 300, 75);
    rect(50, 25, 400, 75);
    rect(50, 125, 400, 75);
    rect(50, 225, 400, 75);
    rect(50, 325, 400, 75);
    rect(50, 425, 400, 75);
    
    rect(475, 25, 125, 75);
    rect(475, 125, 125, 75);
    rect(475, 225, 125, 75);
    rect(475, 325, 125, 75);
    rect(475, 425, 125, 75);
    
    rect(625, 125, 75, 75);
    rect(625, 225, 75, 75);
    rect(625, 325, 75, 75);
    rect(625, 425, 75, 75);
    //draw options button
    noStroke();
    fill(255);
    textSize(48);
    text("Back", 975, 75);
    text("total stat points", 75, 75);
    text("hp", 75, 175);
    text("shield", 75, 275);
    text("defense", 75, 375);
    text("attack", 75, 475);
    
    text("+", 650, 175);
    text("+", 650, 275);
    text("+", 650, 375);
    text("+", 650, 475);
    
    text(playerStatPoints, 490, 75);
    text((int)playerHPMax, 490, 175);
    text((int)playerShieldMax, 490, 275);
    text((int)(playerDefense * 100), 490, 375);
    text((int)(playerAttack * 100), 490, 475);
  }
}

void levelEnd() { //called when the level should end
  keyInput[4] = false; //release space key
  levelEnd = false; //turn off level end trigger
  paused = false; //unpause game
  screenIndex = 3;
  textIndex = scriptStartPoints[levelIndex+1];
  /*
  if (levelIndex == 0) {
    screenIndex = 3; //set to vn section
    textIndex = 11; //set text index to next vn section
  } else if (levelIndex == 1) {
    screenIndex = 3;
    textIndex = 16;
  }*/
}

void levelStart(int cmdIndex) {
  levelIndex = cmdIndex;
  screenIndex = 0;
  playerX = 200;
  playerY = 250;
  playerHP = playerHPMax;
  playerShield = playerShieldMax;
  playerState = 0;
  initObjects();
  placeEnemies();
  
  //calculate stats
  if (oneHitMode == true) enemyBalanceDMG = 9000;
  playerDMGReduction = 1 - ((playerDefense - 1) * 0.1);
  if (playerDMGReduction <= 0.30) playerDMGReduction = 0.30;
  playerShieldRegen = (playerShieldMax / 100) * playerShieldRegenBoost;
}

void setRect(int colorIndex) {
  if (colorIndex == 0) {
    strokeWeight(1);
    noStroke();
    fill(0);
  } else if (colorIndex == 1) { //used for player ship rendering
    strokeWeight(1);
    noStroke();
    fill(255);
  } else if (colorIndex == 2) { //used for player hurt rendering
    strokeWeight(10);
    stroke(200, 0, 0, 100);
    fill(255, 200, 200);
  } else if (colorIndex == 3) { //used for hp surround
    strokeWeight(6);
    fill(0);
    stroke(255);
  } else if (colorIndex == 4) { //used for hp bar fill
    noStroke();
    fill(20, 255, 20);
  } else if (colorIndex == 5) {
    noStroke();
    fill(20, 20, 255);
  }
}

void initObjects() { //set all objects to default (meant to be run in setup)
  for (int i = 0; i < bulletCount; i++) {
    blts[i] = new bullet(-20, -20, 0, 0, 255, 0, 0, 0);
  }
  for (int i = 0; i < basicECount; i++) {
    basicE[i] = new enemy(-200, -200, 0, 0, 255, 0, 0, 10, 10, 0, 2, 0);
  }
  for (int i = 0; i < starCount; i++) {
    stars[i] = new starsBG(int(random(screenX + 20)), int(random(screenY)), int(-1 * (random(10) + 1)), 0);
  }
  for (int i = 0; i < dmgCount; i++) {
    dmg[i] = new damage(-200, -200, 0, 0, 0);
  }
}

void resetObjects() { //resets objects (similar to init but meant to be run in main loop)
    for (starsBG stars : stars) {
      stars.reset();
    }
    for (enemy basicE : basicE) {
      basicE.reset();
    }
    for (bullet blts : blts) {
      blts.reset();
    }
    for (damage dmg : dmg) {
      dmg.reset();
    }
}

void playerCollision() { //check collision with enemy bullets/ships
    for (int i = 0; i < bulletCount; i++) {
   if (blts[i].bulletType == 200 || blts[i].bulletType == 201) { //check to ensure bullet is an enemy bullet
    if (playerX <= blts[i].bulletX + (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((playerX + (playerHitX / 1)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (playerY + 10 <= blts[i].bulletY + (blts[i].bulletHitY / 2)) {
          if ((playerY + (playerHitY / 1)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
              playerState = 10;
              playerShield = playerShield - (blts[i].bulletPower * playerDMGReduction);
              dmg[findDamage()] = new damage(playerX - 10, playerY - 20, (blts[i].bulletPower * playerDMGReduction), 1, 30);
              if (playerShield < 0) { //if shield goes negative
                playerHP = playerHP - abs(playerShield); //subtract the difference of how negative the shield is
                playerShield = 0; //make sure player shield does not go negative
              }
            
            if (blts[i].bulletType == 200) blts[i].reset();
          }
        }
      }
    }
  }
  }
  for (int i = 0; i < basicECount; i++) { //check collision with enemy planes
   if (basicE[i].enemyState != 2) { //check to ensure ship is not dead
    if (playerX <= basicE[i].enemyX + (basicE[i].enemyHitX / 2)) {
      if ((playerX + (playerHitX / 1)) >= (basicE[i].enemyX - (basicE[i].enemyHitX / 2))) {
        if (playerY + 10 <= basicE[i].enemyY + (basicE[i].enemyHitY / 2)) {
          if ((playerY + (playerHitY / 1)) >= (basicE[i].enemyY - (basicE[i].enemyHitY / 2))) {
              playerState = 10;
              playerShield = playerShield - (basicE[i].enemyHP * enemyBalanceBump * enemyBalanceDMG * playerDMGReduction);
              dmg[findDamage()] = new damage(playerX - 10, playerY - 20, (basicE[i].enemyHP * enemyBalanceBump * enemyBalanceDMG * playerDMGReduction), 1, 30);
              if (playerShield < 0) { //if shield goes negative
                playerHP = playerHP - abs(playerShield); //subtract the difference of how negative the shield is
                playerShield = 0; //make sure player shield does not go negative
              }
            //kill enemy
            basicE[i].enemyHP = 0;
            basicE[i].enemyState = 2;
            basicE[i].enemyTiming = 30;
          }
        }
      }
    }
  }
  }
}

int findBullet () { //finds next unused bullet and returns its index value as an int
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (blts[i].bulletType == 255) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > (bulletCount - 1)) {
        bulletIndex = 0;
        exit = true;
      }
    }
  return bulletIndex;
}

int findEnemy () { //finds next unused enemy and returns its index value as an int
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (basicE[i].enemyState == 2) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > (basicECount - 1)) {
        bulletIndex = 0;
        exit = true;
      }
    }
  return bulletIndex;
}

int findDamage () { //finds next unused enemy and returns its index value as an int
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (dmg[i].damageTimer == 0) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > (dmgCount - 1)) {
        bulletIndex = 0;
        exit = true;
      }
    }
  return bulletIndex;
}

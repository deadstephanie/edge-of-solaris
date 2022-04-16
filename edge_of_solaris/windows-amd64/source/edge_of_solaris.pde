//jamepad imports
import com.badlogic.gdx.jnigen.*;
import com.studiohartman.jamepad.*;
import com.studiohartman.jamepad.tester.*;
import com.badlogic.gdx.jnigen.parsing.*;
import com.badlogic.gdx.jnigen.test.*;
import com.github.javaparser.*;
import com.github.javaparser.ast.*;
import com.github.javaparser.ast.body.*;
import com.github.javaparser.ast.comments.*;
import com.github.javaparser.ast.expr.*;
import com.github.javaparser.ast.internal.*;
import com.github.javaparser.ast.stmt.*;
import com.github.javaparser.ast.type.*;
import com.github.javaparser.ast.visitor.*;

import java.io.*;

bullet[] blts;
enemy[] basicE;
starsBG[] stars;
damage[] dmg;
item[] itemDrop;

PImage faun1;
PImage faun2;
PImage faun3;
PImage faun4;
PImage faun5;
PImage faun6;
PImage faun7;
PImage faun8;
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
PImage shadow4;

PrintWriter settingsOut;
PrintWriter OSver;
JSONObject settingsJSON;
JSONObject gamesaveJSON;
JSONArray levelEditorSaveJSON;

ControllerManager controllers = new ControllerManager();

void setup(){
  size(1280, 720);
  surface.setResizable(true);
  frameRate(60);
  blts = new bullet[bulletCount]; //create all init objects
  basicE = new enemy[basicECount];
  stars = new starsBG[starCount];
  dmg = new damage[dmgCount];
  itemDrop = new item[itemDropCount]; 
  initObjects(); //initializes all objects to "default" values
  loadText(); //load the text file for visual novel text
  loadSprites(); //load in png images for sprites
  loadSave(); //load the gamesave.sav file
  scanForStartPoints(); //scan the script for the segment start points
  calcWeaponStats(); //calculates weapon power from level and weapon upg cost
  placeEnemies(); //only needed when you want to load the game straight into gameplay, ie skipping any menus
  
  //init the controller
  controllers.initSDLGamepad();
}

void draw() {
  controllerSupport(); //detects controllers, controller movement,etc
  processInput(); //process keyboard input
  playerX = constrain(playerX, 20 * screenScaling, 1200 * screenScaling); //constrain playerX to playfield
  playerY = constrain(playerY, 10 * screenScaling, 600 * screenScaling); //constrain playerY to playfield
  drawFrame();
  drawUI();
  if (shadowDisp == true) {image(shadow, 500, 500); image(shadow2, 1000, 500); image(shadow3, 500, 200); shadowFactor++; shadowDisp = false;}
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
  usingDPAD = false; //release dpad
  usingStick = false; //release stick
}

void changeRes(int res) { //change screen resolution
  if (res == 0) { //720p
    surface.setSize(1280, 720);
    screenScaling = 1;
    screenX = 1280;
    screenY = 720;
  } else if (res == 1) { //1080p
    surface.setSize(1920, 1080);
    screenScaling = 1.5;
    screenX = 1920;
    screenY = 1080;
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
    for (item itemDrop : itemDrop) {
      itemDrop.update();
      itemDrop.display();
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
      ellipse(640 * screenScaling, 750 * screenScaling, 2000 * screenScaling, 200 * screenScaling);
    } 
    levelEndCheckTimer++;
    if (levelEndCheckTimer > 60) { //check to see if all enemies are dead once a second
      levelEndCheckTimer = 0;
      for (int i = 0; i < basicECount; i++) {
        if (basicE[i].enemyState != 2) {
          break; //break out of loop for efficiency
        }else if (i == (basicECount - 1)) {
          levelEnd = true; //switch to level end screen
          paused = true; //put game in paused state
          keyInput[4] = false; //latch space key
          btnAdvanceA = false; //latch a btn
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
      rect(playerX * screenScaling, (playerY + 10) * screenScaling, playerHitX * screenScaling, (playerHitY - 10) * screenScaling, 10); //render player hurt state
    }
    
    if (playerHP <= 0) { //if player dies
      paused = true; //pause game
      playerState = 255; //set player as dead
      playerAnimTiming = 30; //set timer for death anim
      keyInput[4] = false; //latch space key
      btnAdvanceA = false; //latch A btn
    }
    
    //render the engine glow effect
    noStroke();
    fill(0, 127, 255, 100);
    ellipse((playerX - 6) * screenScaling, (playerY + 12.5) * screenScaling, (30 + abs(playerEngineTimer / 3)) * screenScaling, 10 * screenScaling);
    fill(0, 165, 255, 120);
    ellipse((playerX - 3) * screenScaling, (playerY + 12.5) * screenScaling, (20 + abs(playerEngineTimer / 3)) * screenScaling, 10 * screenScaling);
    fill(60, 240, 255, 150);
    ellipse((playerX - 1) * screenScaling, (playerY + 12.5) * screenScaling, (15 + abs(playerEngineTimer / 3)) * screenScaling, 8 * screenScaling);
    fill(100, 240, 255, 200);
    ellipse((playerX - 1) * screenScaling, (playerY + 12.5) * screenScaling, (10 + abs(playerEngineTimer / 3)) * screenScaling, 6 * screenScaling);
    playerEngineTimer++;
    if (playerEngineTimer == 15) playerEngineTimer = -15;
    
    if (shadowFactor > 12) image(shadow4, (playerX - 5) * screenScaling, (playerY - 5) * screenScaling, (playerHitX * 2) * screenScaling, (playerHitY * 2) * screenScaling);
    else image(player1, (playerX - 5) * screenScaling, (playerY - 5) * screenScaling, 80 * screenScaling, 30 * screenScaling); //player sprite
    
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
    for (item itemDrop : itemDrop) {
      itemDrop.display();
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
      ellipse(640 * screenScaling, 750 * screenScaling, 2000 * screenScaling, 200 * screenScaling);
    }
    if (playerState == 255) { //if player dead
      if (playerAnimTiming != 0) {
        fill(255, 127, 0, 100);
        ellipse((playerX + 30) * screenScaling, (playerY + 7) * screenScaling, ((playerHitX / 3) + (playerAnimTiming * 5)) * screenScaling, ((playerHitY / 2) + (playerAnimTiming * 3)) * screenScaling);
        fill(255, 165, 0, 120);
        ellipse((playerX + 30) * screenScaling, (playerY + 7) * screenScaling, ((playerHitX / 3) + (playerAnimTiming * 4)) * screenScaling, ((playerHitY / 2) + (playerAnimTiming * 2)) * screenScaling);
        fill(255, 240, 60, 150);
        ellipse((playerX + 30) * screenScaling, (playerY + 7) * screenScaling, ((playerHitX / 3) + (playerAnimTiming * 3)) * screenScaling, ((playerHitY / 2) + (playerAnimTiming * 1)) * screenScaling);
        playerAnimTiming--;
      }
      textSize(60 * screenScaling);
      fill(255, 50, 50);
      text("YOU DIED", 550 * screenScaling, 350 * screenScaling);
      textSize(48 * screenScaling);
      text("Press R, Space or A to restart", 400 * screenScaling, 450 * screenScaling);
      
    } else {
      if (shadowFactor > 12) image(shadow4, (playerX - 5) * screenScaling, (playerY - 5) * screenScaling, (playerHitX * 2) * screenScaling, (playerHitY * 2) * screenScaling);
      else image(player1, (playerX - 5) * screenScaling, (playerY - 5) * screenScaling, 80 * screenScaling, 30 * screenScaling); //player sprite
      
      if (levelEnd == true) { //if on level end screen
      textSize(60 * screenScaling);
      fill(255, 50, 50);
      text("Level Complete", 550 * screenScaling, 350 * screenScaling);
      textSize(48 * screenScaling);
      text("Press Space or A to continue", 490 * screenScaling, 450 * screenScaling);
    } else { //if paused, player not dead and level not complete
      textSize(60 * screenScaling);
      fill(255, 50, 50);
      text("PAUSED", 550 * screenScaling, 350 * screenScaling);
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
    
    //render hp and shield bars
    if (oneHitMode == false) {
      stroke(0);
      strokeWeight(15);
      fill(0);
      rect(20 * screenScaling, 650 * screenScaling, 200 * screenScaling, 50 * screenScaling, 10);
      rect(235 * screenScaling, 650 * screenScaling, 200 * screenScaling, 50 * screenScaling, 10);
      setRect(4);
      if (playerHP >= 0) rect(23 * screenScaling, 653.5 * screenScaling, (195 * (playerHP / playerHPMax)) * screenScaling, 44 * screenScaling);
      setRect(5);
      rect(238 * screenScaling, 653.5 * screenScaling, (194 * (playerShield / playerShieldMax)) * screenScaling, 44 * screenScaling);
      setRect(3); //render surrounds
      noFill();
      rect(20 * screenScaling, 650 * screenScaling, 200 * screenScaling, 50 * screenScaling, 10);
      rect(235 * screenScaling, 650 * screenScaling, 200 * screenScaling, 50 * screenScaling, 10);
      fill(0);
    }
    
    //render weapon selector
    stroke(255);
    strokeWeight(2);
    rect(450 * screenScaling, 653 * screenScaling, 30 * screenScaling, 20 * screenScaling, 5);
    rect(450 * screenScaling, 678 * screenScaling, 30 * screenScaling, 20 * screenScaling, 5);
    rect(485 * screenScaling, 653 * screenScaling, 30 * screenScaling, 20 * screenScaling, 5);
    rect(485 * screenScaling, 678 * screenScaling, 30 * screenScaling, 20 * screenScaling, 5);
    
    textSize(48);
    stroke(0);
    fill(200, 255, 20);
    text("Money: " + playerMoney, 550 * screenScaling, 680 * screenScaling);
  } else if (screenIndex == 1) { //title page
    background(0);
    fill(200, 200, 255, 120);
    textSize(130 * screenScaling);
    text("Edge Of Solaris", 240 * screenScaling, 120 * screenScaling);
    text("Edge Of Solaris", 248 * screenScaling, 120 * screenScaling);
    fill(200, 200, 255, 255);
    textSize(128 * screenScaling);
    text("Edge Of Solaris", 250 * screenScaling, 120 * screenScaling);
    fill(200, 200, 255);
    textSize(90 * screenScaling);
    text("random tagline in space", 200 * screenScaling, 240 * screenScaling);
    textSize(64);
    text("new game", 500 * screenScaling, 400 * screenScaling);
    text("continue", 500 * screenScaling, 500 * screenScaling);
    text("press space or A to continue (temp)", 50 * screenScaling, 650 * screenScaling);
    textSize(24 * screenScaling);
    text("build " + buildNumber, 1175 * screenScaling, 650 * screenScaling);
  } else if (screenIndex == 2) { //level select
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    if (menuIndexX == 1 && menuIndexY == 0) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 25 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 1 && menuIndexY == 1) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 125 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 1 && menuIndexY == 2) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 225 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 1 && menuIndexY == 3) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 325 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 1 && menuIndexY == 4) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 425 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 1 && menuIndexY == 5) fill(20, 100, 20); else fill(50, 0, 50);
    rect(950 * screenScaling, 525 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    //draw level select rects
    if (menuIndexX == 0 && menuIndexY == 0) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 25 * screenScaling, 700 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 1) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 125 * screenScaling, 700 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 2) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 225 * screenScaling, 700 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 3) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 325 * screenScaling, 700 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 4) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 425 * screenScaling, 700 * screenScaling, 75 * screenScaling);
    
    if (playerStatPoints > 0) { //check if stat points to spend
      fill(255, 0, 0);
      noStroke();
      ellipse(1212.5 * screenScaling, 62.5 * screenScaling, 50 * screenScaling, 50 * screenScaling); //draw red circle to indicate stat points to spend
    }
    //draw text
    noStroke();
    fill(255);
    textSize(48 * screenScaling);
    text("status", 975 * screenScaling, 75 * screenScaling);
    text("mess hall", 975 * screenScaling, 175 * screenScaling);
    text("hanger", 975 * screenScaling, 275 * screenScaling);
    text("engineering", 975 * screenScaling, 375 * screenScaling);
    text("settings", 975 * screenScaling, 475 * screenScaling);
    text("save game", 975 * screenScaling, 575 * screenScaling);
    if (areaIndex == 0) { //debug menu
      text("launch story", 75 * screenScaling, 75 * screenScaling);
      text("level 00", 75 * screenScaling, 175 * screenScaling);
      text("level 01", 75 * screenScaling, 275 * screenScaling);
      text("test level", 75 * screenScaling, 375 * screenScaling);
      text("test level 2", 75 * screenScaling, 475 * screenScaling);
      
    } else if (areaIndex == 1) { //first area
      text("start the story", 75 * screenScaling, 75 * screenScaling);
      text("go to level editor", 75 * screenScaling, 375 * screenScaling);
      text("go to debug level select", 75 * screenScaling, 475 * screenScaling);
    } 
  } else if (screenIndex == 4) { //settings menu
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950 * screenScaling, 25 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 0) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 25 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    if (oneHitMode == true) {
      fill(0, 150, 0);
    } else fill(50, 0, 50);
    rect(475 * screenScaling, 25 * screenScaling, 75 * screenScaling, 75 * screenScaling);
    fill(50, 0, 50); // reset color
    if (damageOnTop == true) {
      fill(0, 150, 0);
    } else fill(50, 0, 50);
    rect(475 * screenScaling, 125 * screenScaling, 75 * screenScaling, 75 * screenScaling);
    fill(50, 0, 50); // reset color
    if (menuIndexX == 0 && menuIndexY == 1) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 125 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 2) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 225 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 3) fill(20, 100, 20); else fill(50, 0, 50);
    rect(50 * screenScaling, 325 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    //draw options button
    noStroke();
    fill(255);
    textSize(48 * screenScaling);
    text("Back", 975 * screenScaling, 75 * screenScaling);
    text("one hit mode", 75 * screenScaling, 75 * screenScaling);
    text("damage on top", 75 * screenScaling, 175 * screenScaling);
    text("shadow", 75 * screenScaling, 275 * screenScaling);
    if (screenRes == 0) text("change to 1080p", 75 * screenScaling, 375 * screenScaling);
    else if (screenRes == 1) text("change to 720p", 75 * screenScaling, 375 * screenScaling);
  } else if (screenIndex == 5) { //status window
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950 * screenScaling, 25 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    rect(50 * screenScaling, 25 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    rect(50 * screenScaling, 125 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    rect(50 * screenScaling, 225 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    rect(50 * screenScaling, 325 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    rect(50 * screenScaling, 425 * screenScaling, 400 * screenScaling, 75 * screenScaling);
    
    rect(475 * screenScaling, 25 * screenScaling, 125 * screenScaling, 75 * screenScaling);
    rect(475 * screenScaling, 125 * screenScaling, 125 * screenScaling, 75 * screenScaling);
    rect(475 * screenScaling, 225 * screenScaling, 125 * screenScaling, 75 * screenScaling);
    rect(475 * screenScaling, 325 * screenScaling, 125 * screenScaling, 75 * screenScaling);
    rect(475 * screenScaling, 425 * screenScaling, 125 * screenScaling, 75 * screenScaling);
    
    if (menuIndexX == 0 && menuIndexY == 0) fill(20, 100, 20); else fill(50, 0, 50);
    rect(625 * screenScaling, 125 * screenScaling, 75 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 1) fill(20, 100, 20); else fill(50, 0, 50);
    rect(625 * screenScaling, 225 * screenScaling, 75 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 2) fill(20, 100, 20); else fill(50, 0, 50);
    rect(625 * screenScaling, 325 * screenScaling, 75 * screenScaling, 75 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 3) fill(20, 100, 20); else fill(50, 0, 50);
    rect(625 * screenScaling, 425 * screenScaling, 75 * screenScaling, 75 * screenScaling);

    noStroke();
    fill(255);
    textSize(48 * screenScaling);
    text("Back", 975 * screenScaling, 75 * screenScaling);
    text("total stat points", 75 * screenScaling, 75 * screenScaling);
    text("hp", 75 * screenScaling, 175 * screenScaling);
    text("shield", 75 * screenScaling, 275 * screenScaling);
    text("defense", 75 * screenScaling, 375 * screenScaling);
    text("attack", 75 * screenScaling, 475 * screenScaling);
    
    text("XP: " + playerXP, 75 * screenScaling, 575 * screenScaling);
    text("level: " + playerLevel, 75 * screenScaling, 675 * screenScaling);
    text("xp next level: " + pow(playerLevel + 1, 3), 500 * screenScaling, 575 * screenScaling);
    
    text("+", 650 * screenScaling, 175 * screenScaling);
    text("+", 650 * screenScaling, 275 * screenScaling);
    text("+", 650 * screenScaling, 375 * screenScaling);
    text("+", 650 * screenScaling, 475 * screenScaling);
    
    text(playerStatPoints, 490 * screenScaling, 75 * screenScaling);
    text((int)playerHPMax, 490 * screenScaling, 175 * screenScaling);
    text((int)playerShieldMax, 490 * screenScaling, 275 * screenScaling);
    text((int)(playerDefense * 100), 490 * screenScaling, 375 * screenScaling);
    text((int)(playerAttack * 100), 490 * screenScaling, 475 * screenScaling);
  } else if (screenIndex == 8) { //engineering
    background(0);
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    //draw menu rects
    rect(950 * screenScaling, 25 * screenScaling, 300 * screenScaling, 75 * screenScaling);
    rect(950 * screenScaling, 125 * screenScaling, 300 * screenScaling, 175 * screenScaling);
    //draw level select rects
    rect(50 * screenScaling, 25 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    rect(50 * screenScaling, 225 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    rect(50 * screenScaling, 425 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    
    rect(475 * screenScaling, 25 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    rect(475 * screenScaling, 225 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    rect(475 * screenScaling, 425 * screenScaling, 400 * screenScaling, 175 * screenScaling);
    
    noStroke();
    fill(255);
    textSize(48 * screenScaling);
    text("Back", 975 * screenScaling, 75 * screenScaling);
    text("Money:", 975 * screenScaling, 175 * screenScaling);
    text("$" + playerMoney, 975 * screenScaling, 275 * screenScaling);
    
    textSize(16 * screenScaling);
    text("Dual Beam Cannon (per bullet stats)", 60 * screenScaling, 45 * screenScaling);
    text("Bullet Count: 2", 60 * screenScaling, 65 * screenScaling);
    text("Current Damage per Bullet: " + playerWeaponPower2, 60 * screenScaling, 85 * screenScaling);
    text("Upgraded Damage per Bullet: " + (playerWeaponPower2 * 1.1), 60 * screenScaling, 105 * screenScaling);
    text("Current Damage per Second: " + (playerWeaponPower2 * (60/playerWeaponCooldown2)), 60 * screenScaling, 125 * screenScaling);
    text("Upgraded Damage per Second: " + (playerWeaponPower2 * 1.1 * (60/playerWeaponCooldown2)), 60 * screenScaling, 145 * screenScaling);
    text("Current Bullets per second: " + (60/playerWeaponCooldown2), 60 * screenScaling, 165 * screenScaling);
    if (menuIndexX == 0 && menuIndexY == 0) fill(20, 100, 20);
    text("Click here to Upgrade Weapon: $" + playerWeaponCost2, 60 * screenScaling, 185 * screenScaling); 
    fill(255);
    if (playerWeaponsUnlocked >= 1) {
      text("Machine Gun (per bullet stats)", 60 * screenScaling, 245 * screenScaling);
      text("Bullet Count: 1", 60 * screenScaling, 265 * screenScaling);
      text("Current Damage per Bullet: " + playerWeaponPower0, 60 * screenScaling, 285 * screenScaling);
      text("Upgraded Damage per Bullet: " + (playerWeaponPower0 * 1.1), 60 * screenScaling, 305 * screenScaling);
      text("Current Damage per Second: " + (playerWeaponPower0 * (60/playerWeaponCooldown0)), 60 * screenScaling, 325 * screenScaling);
      text("Upgraded Damage per Second: " + (playerWeaponPower0 * 1.1 * (60/playerWeaponCooldown0)), 60 * screenScaling, 345 * screenScaling);
      text("Current Bullets per second: " + (60/playerWeaponCooldown0), 60 * screenScaling, 365 * screenScaling);
      if (menuIndexX == 0 && menuIndexY == 1) fill(20, 100, 20);
      text("Click here to Upgrade Weapon: $" + playerWeaponCost0, 60 * screenScaling, 385 * screenScaling); 
      fill(255);
      if (playerWeaponsUnlocked >= 2) {
        text("Heavy Laser (per bullet stats)", 60 * screenScaling, 445 * screenScaling);
        text("Bullet Count: 1", 60 * screenScaling, 465 * screenScaling);
        text("Current Damage per Bullet: " + playerWeaponPower3, 60 * screenScaling, 485 * screenScaling);
        text("Upgraded Damage per Bullet: " + (playerWeaponPower3 * 1.1), 60 * screenScaling, 505 * screenScaling);
        text("Current Damage per Second: " + (playerWeaponPower3 * (60/playerWeaponCooldown3)), 60 * screenScaling, 525 * screenScaling);
        text("Upgraded Damage per Second: " + (playerWeaponPower3 * 1.1 * (60/playerWeaponCooldown3)), 60 * screenScaling, 545 * screenScaling);
        text("Current Bullets per second: " + (60/playerWeaponCooldown3), 60 * screenScaling, 565 * screenScaling);
        if (menuIndexX == 0 && menuIndexY == 2) fill(20, 100, 20);
        text("Click here to Upgrade Weapon: $" + playerWeaponCost3, 60 * screenScaling, 585 * screenScaling); 
        fill(255);
        if (playerWeaponsUnlocked >= 3) {
          text("Shotgun (per bullet stats)", 485 * screenScaling, 45 * screenScaling);
          text("Bullet Count: 5", 485 * screenScaling, 65 * screenScaling);
          text("Current Damage per Bullet: " + playerWeaponPower1, 485 * screenScaling, 85 * screenScaling);
          text("Upgraded Damage per Bullet: " + (playerWeaponPower1 * 1.1), 485 * screenScaling, 105 * screenScaling);
          text("Current Damage per Second: " + (playerWeaponPower1 * (60/playerWeaponCooldown1)), 485 * screenScaling, 125 * screenScaling);
          text("Upgraded Damage per Second: " + (playerWeaponPower1 * 1.1 * (60/playerWeaponCooldown1)), 485 * screenScaling, 145 * screenScaling);
          text("Current Bullets per second: " + (60/playerWeaponCooldown1), 485 * screenScaling, 165 * screenScaling);
          if (menuIndexX == 1 && menuIndexY == 0) fill(20, 100, 20);
          text("Click here to Upgrade Weapon: $" + playerWeaponCost1, 485 * screenScaling, 185 * screenScaling); 
          fill(255);
        }
      }
    }
  } else if (screenIndex == 9) { //level editor window
    levelEditor();
  }
}

void levelEnd() { //called when the level should end
  keyInput[4] = false; //release space key
  levelEnd = false; //turn off level end trigger
  paused = false; //unpause game
  if (levelEditorMode == false) {
  checkForLevelUp(); //check if player leveled up
  if (levelIndex == 0) level0Completed = true;
  if (levelIndex == 1) level1Completed = true;
  if (levelIndex == 1) { //sets area to 2 (required for the back button into story bit)
  areaIndex = 2;
    if (playerWeaponsUnlocked == 0) { //basically don't set weapons unlocked to 1 if weapons are already unlocked, mostly for debug
      playerWeaponsUnlocked = 1; 
    }
  } //unlock the mg after level 1 complete and set area to 2
  scanLevelEndCommands();
  } else {
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

void checkForLevelUp() { //check to see if the player just leveled up
  if ((int)Math.cbrt(playerXP) > playerLevel) { //if player leveled up
    playerLevel = (int)Math.cbrt(playerXP); //set the level to new level
    playerStatPoints = playerStatPoints + 4; //add 4 stat points
  }
}

void calcWeaponStats() { //calculate weapon stats and costs
  playerWeaponPower0 = playerWeaponBasePower0;
  playerWeaponPower1 = playerWeaponBasePower1;
  playerWeaponPower2 = playerWeaponBasePower2;
  playerWeaponPower3 = playerWeaponBasePower3;
  for (int i = 0; i < playerWeaponLevel0; i++) {
    playerWeaponPower0 = playerWeaponPower0 * 1.1;
  }
  for (int i = 0; i < playerWeaponLevel1; i++) {
    playerWeaponPower1 = playerWeaponPower1 * 1.1;
  }
  for (int i = 0; i < playerWeaponLevel2; i++) {
    playerWeaponPower2 = playerWeaponPower2 * 1.1;
  }
  for (int i = 0; i < playerWeaponLevel3; i++) {
    playerWeaponPower3 = playerWeaponPower3 * 1.1;
  }
  playerWeaponCost0 = (int)pow(playerWeaponLevel0 * 10, 3);
  playerWeaponCost1 = (int)pow(playerWeaponLevel1 * 10, 3);
  playerWeaponCost2 = (int)pow(playerWeaponLevel2 * 10, 3);
  playerWeaponCost3 = (int)pow(playerWeaponLevel3 * 10, 3);
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
    blts[i] = new bullet(-20, -20, 0, 0, 255, 0, 0, 0, 0);
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
  for (int i = 0; i < itemDropCount; i++) {
    itemDrop[i] = new item(-200, -200,0, 0, 0, 255, 0);
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
    for (item itemDrop : itemDrop) {
      itemDrop.reset();
    }
}

void playerCollision() { //check collision with enemy bullets/ships
    for (int i = 0; i < bulletCount; i++) {
   if (blts[i].bulletType == 200 || blts[i].bulletType == 201) { //check to ensure bullet is an enemy bullet
    if (playerX <= blts[i].bulletX + (blts[i].bulletHitX / 2)) {
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
  for (int i = 0; i < itemDropCount; i++) { //check collision with items that are dropped
   if (itemDrop[i].itemType != 255) { //check to ensure item is not dead
    if (playerX <= itemDrop[i].itemX + (itemDrop[i].itemHitX / 2)) {
      if ((playerX + (playerHitX / 1)) >= (itemDrop[i].itemX - (itemDrop[i].itemHitX / 2))) {
        if (playerY + 10 <= itemDrop[i].itemY + (itemDrop[i].itemHitY / 2)) {
          if ((playerY + (playerHitY / 1)) >= (itemDrop[i].itemY - (itemDrop[i].itemHitY / 2))) {
              if (itemDrop[i].itemType == 0) { //money item
                playerMoney = playerMoney + itemDrop[i].itemValue; //add item money to player money
                dmg[findDamage()] = new damage(itemDrop[i].itemX, itemDrop[i].itemY, itemDrop[i].itemValue, 4, 30);
              }
              itemDrop[i].itemType = 255;
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

int findDamage () { //finds next unused damage object and returns its index value as an int
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

int findItem () { //finds next unused item object and returns its index value as an int
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (itemDrop[i].itemType == 255) {
        bulletIndex = i;
        exit = true;
      } else i++;
      if (i > (itemDropCount - 1)) {
        bulletIndex = 0;
        exit = true;
      }
    }
  return bulletIndex;
}

void dropItem(float value, float x, float y) { //when an enemy dies
  int shouldWeDropanItem = 0;
  boolean itemSuperCrit = false;
  if (itemCritChance > 100) { //super crit possible
    if (random(100) <= (itemCritChance - 100)) { //if super crit
      shouldWeDropanItem = 1;
      itemSuperCrit = true;
    } else { //no super crit
      shouldWeDropanItem = 1;
    }
  } else if (random(100) <= itemDropChance) { //normal item drop
    shouldWeDropanItem = 1;
  }
  
  if (shouldWeDropanItem == 1) { //normal drop
    int itemRand = int(random(1000));
    
    if (itemSuperCrit == true) { //super crit
      value = value * pow(itemCritMod, 3);
      if (itemRand <= moneyDropThreshold) { //money
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 1, 0);
      } else if (itemRand <= xpDropThreshold) { //xp
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 3, 0);
      } else if (itemRand <= hpDropThreshold) { //hp
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 5, 0);
      } else if (itemRand <= shieldDropThreshold) { //shield
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 7, 0);
      }
    } else { //normal drop
      if (random(100) <= itemCritChance) value = value * itemCritMod;
      if (itemRand <= moneyDropThreshold) { //money
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 0, 0);
      } else if (itemRand <= xpDropThreshold) { //xp
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 2, 0);
      } else if (itemRand <= hpDropThreshold) { //hp
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 4, 0);
      } else if (itemRand <= shieldDropThreshold) { //shield
        itemDrop[findItem()] = new item(x, y, 20, 20, value, 6, 0);
      }
    }
  }
}

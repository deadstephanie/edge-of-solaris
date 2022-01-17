/* autogenerated by Processing revision 1277 on 2022-01-17 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.io.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class edge_of_solaris extends PApplet {

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




 public void setup(){
  /* size commented out by preprocessor */;
  blts = new bullet[bulletCount];
  basicE = new enemy[basicECount];
  stars = new starsBG[starCount];
  dmg = new damage[dmgCount];
  initObjects(); //initializes all objects to "default" values
  loadText(); //load the text file for visual novel text
  loadSprites(); //load in png images for sprites
  fillvnInfo(); //defines vninfo
}

 public void draw() {
  background(15);
  processInput();
  drawFrame();
  drawUI();
  if (screenIndex == 0) {
    if (enemiesPlaced == false) {
      placeEnemies();
      enemiesPlaced = true;
    }
  }
  if (timing < 255) timing++;
  if (secondTiming < 255) secondTiming++;
}

 public void drawFrame() {
  if (screenIndex == 0) {
    for (starsBG stars : stars) {
      stars.update();
      stars.display();
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
      dmg.display();
    }
    
    //draw player
    playerCollision();
    if (playerShield < playerShieldMax) playerShield = playerShield + playerShieldRegen; //regen shield if depleted
    if (playerShield > playerShieldMax) playerShield = playerShieldMax; //ensure shield does not increase past max
    if (playerState == 0) setRect(1); //if player not being hurt
    else {
      setRect(2); //if player being hurt
      playerState--;  
      rect(playerX, playerY, playerHitX, playerHitY, 10); //render player hurt state
    }
    
    //render the engine glow effect
    noStroke();
    fill(0, 127, 255, 100);
    ellipse(playerX - 10, playerY + 2.5f, 30 + abs(playerEngineTimer / 3), 10);
    fill(0, 165, 255, 120);
    ellipse(playerX - 7, playerY + 2.5f, 20 + abs(playerEngineTimer / 3), 10);
    fill(60, 240, 255, 150);
    ellipse(playerX - 5, playerY + 2.5f, 15 + abs(playerEngineTimer / 3), 8);
    fill(100, 240, 255, 200);
    ellipse(playerX - 5, playerY + 2.5f, 10 + abs(playerEngineTimer / 3), 6);
    playerEngineTimer++;
    if (playerEngineTimer == 15) playerEngineTimer = -15;
    
    image(player1, playerX - 5, playerY - 5); //player sprite
  } else if (screenIndex == 1) {
    resetObjects(); //reset objects on non game screens 
  } else if (screenIndex == 3) {
    drawVN();
  }
}

 public void drawUI() {
  if (screenIndex == 0) { //in game
    textSize(25);
    fill(255);
    //text("Q, E, R switch weapons", 50, 640);
    
    //render hp and shield bars
    setRect(4);
    rect(23, 653.5f, (194 * (playerHP / playerHPMax)), 44);
    setRect(5);
    rect(238, 653.5f, (194 * (playerShield / playerShieldMax)), 44);
    setRect(3); //render surrounds
    noFill();
    rect(20, 650, 200, 50, 10);
    rect(235, 650, 200, 50, 10);
    fill(0);
    
    //render weapon selector
    stroke(255);
    strokeWeight(2);
    rect(450, 653, 30, 20, 5);
    rect(450, 678, 30, 20, 5);
    rect(485, 653, 30, 20, 5);
    rect(485, 678, 30, 20, 5);
  } else if (screenIndex == 1) { //title page
    fill(200, 200, 255, 120);
    textSize(130);
    text("Edge Of Solaris", 240, 120);
    text("Edge Of Solaris", 248, 120);
    fill(200, 200, 255, 255);
    textSize(128);
    text("Edge Of Solaris", 250, 120);
    fill(200, 200, 255);
    textSize(90);
    text("random bullshit in space", 200, 240);
    textSize(64);
    text("new game", 500, 400);
    text("continue", 500, 500);
    text("press space to continue (temp)", 50, 650);
  } else if (screenIndex == 2) { //level select
    stroke(255);
    strokeWeight(10);
    fill(50, 0, 50);
    rect(950, 25, 300, 75);
    rect(950, 125, 300, 75);
    rect(950, 225, 300, 75);
    rect(950, 325, 300, 75);
    noStroke();
    fill(255);
    textSize(48);
    text("status", 975, 75);
    text("mess hall", 975, 175);
    text("hanger", 975, 275);
    text("engineering", 975, 375);
    text("press w to continue (temp)", 50, 650);
  }
}

 public void setRect(int colorIndex) {
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

 public void initObjects() { //set all objects to default (meant to be run in setup)
  for (int i = 0; i < bulletCount; i++) {
    blts[i] = new bullet(-20, -20, 0, 0, 255, 0, 0, 0);
  }
  for (int i = 0; i < basicECount; i++) {
    basicE[i] = new enemy(-200, -200, 0, 0, 255, 0, 0, 10, 10, 0, 2, 0);
  }
  for (int i = 0; i < starCount; i++) {
    stars[i] = new starsBG(PApplet.parseInt(random(screenX + 20)), PApplet.parseInt(random(screenY)), PApplet.parseInt(-1 * (random(10) + 1)), 0);
  }
  for (int i = 0; i < dmgCount; i++) {
    dmg[i] = new damage(-200, -200, 0, 0, 0);
  }
}

 public void resetObjects() { //resets objects (similar to init but meant to be run in main loop)
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

 public void playerCollision() { //check to see if an enemy bullet 
    for (int i = 0; i < bulletCount; i++) {
   if (blts[i].bulletType == 200 || blts[i].bulletType == 201) { //check to ensure bullet is an enemy bullet
    if (playerX <= blts[i].bulletX + (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((playerX + (playerHitX / 1)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (playerY <= blts[i].bulletY + (blts[i].bulletHitY / 2)) {
          if ((playerY + (playerHitY / 1)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            if (blts[i].bulletType == 200 || blts[i].bulletType == 201) {
              playerState = 10;
              playerShield = playerShield - blts[i].bulletPower;
              if (playerShield < 0) { //if shield goes negative
                playerHP = playerHP - abs(playerShield); //subtract the difference of how negative the shield is
                playerShield = 0; //make sure player shield does not go negative
              }
            }
            if (blts[i].bulletType == 200) blts[i].reset();
          }
        }
      }
    }
  }
  }
}

 public int findBullet () { //finds next unused bullet and returns its index value as an int
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

 public int findEnemy () { //finds next unused enemy and returns its index value as an int
    bulletIndex = 0;
    int i = 0;
    boolean exit = false;
    while (exit == false) {
      if (basicE[i].enemyType == 255) {
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

 public int findDamage () { //finds next unused enemy and returns its index value as an int
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
class bullet {
  float bulletX; //bullet x pos
  float bulletY; //bullet y pos
  float bulletSpeedX; //bullet x speed
  float bulletSpeedY; //bullet y speed
  int bulletType; //255 = dead/inactive bullet, 0-199 = player bullets, 200-254 = enemy bullets
  int bulletHitX; //bullet hitbox x
  int bulletHitY; //bullet hitbox y
  float bulletPower; //bullet impact damage (defined on bullet gen)

bullet(float bulletXtemp, float bulletYtemp, float bulletSpeedXtemp, float bulletSpeedYtemp, int bulletTypetemp, int bulletHitXtemp, int bulletHitYtemp, float bulletPowertemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
  bulletType = bulletTypetemp;
  bulletHitX = bulletHitXtemp;
  bulletHitY = bulletHitYtemp;
  bulletPower = bulletPowertemp;
}

 public void update() {
  if (bulletX > (screenX + 100) || bulletX < -100 || bulletY > (screenY + 100) || bulletY < -100) bulletType = 255; //destroy bullet if off screen
  else { //if bullet is not off screen, update bullet position
    bulletX = bulletX + bulletSpeedX; //update bullet x according to x speed
    bulletY = bulletY + bulletSpeedY; //update bullet y according to y speed
  }
  if (bulletType == 100) {
    if (bulletSpeedY > 0) bulletSpeedY--;
    if (bulletSpeedY < 0) bulletSpeedY++;
    if (bulletSpeedX < 5) bulletSpeedX++;
  }
}

public void reset() {
  bulletX = -20;
  bulletY = -20;
  bulletSpeedX = 0;
  bulletSpeedY = 0;
  bulletType = 255;
  bulletHitX = 0;
  bulletHitY = 0;
  bulletPower = 0;
}

 public void explode() {
}

 public void display() {
  if (bulletType == 0) { //machine gun
    stroke(20, 20, 200, 120);
    strokeWeight(2);
    fill(20, 20, 200);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 1) { //spread shot
    stroke(255, 120);
    strokeWeight(2);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 4) { //snipe shot
    stroke(255, 120);
    strokeWeight(10);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 100) { //basic secondary missile
    stroke(255, 200);
    strokeWeight(3);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 2) { //dual beam cannon
    stroke(20, 20, 200, 150);
    strokeWeight(2);
    fill(100, 100, 255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 200) { //basic enemy shot
    stroke(20, 200, 20, 150);
    strokeWeight(2);
    fill(175, 255, 175);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
}
}
class damage {
  float damageX;
  float damageY;
  float damage;
  int damageType;
  int damageTimer;
  
  damage(float damageXtemp, float damageYtemp, float damagetemp, int damageTypetemp, int damageTimertemp) {
    damageX = damageXtemp;
    damageY = damageYtemp;
    damage = damagetemp;
    damageType = damageTypetemp;
    damageTimer = damageTimertemp;
  }
  
   public void update() {
    if (damageTimer != 0) {
      damageTimer--;
      damageY--;
    }
  }
  
   public void display() {
    if (damageTimer != 0) {
      if (damageType == 0) {
        int fade = damageTimer * 8;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(24);
        fill(255, 20, 20, fade);
        text(damage, damageX, damageY);
      }
    }
  }
  
   public void reset() {
    damageX = -200;
    damageY = -200;
    damage = 0;
    damageType = 0;
    damageTimer = 0;
  }
}
class enemy {
  float enemyX; //enemy x pos
  float enemyY; //enemy y pos
  float enemySpeedX; //enemy x speed
  float enemySpeedY; //enemy y speed
  int enemyType; //type of enemy, 0 = basic, 1 = big, 2 = modema ship
  float enemyHitX; //enemy hitbox x
  float enemyHitY; //enemy hitbox y
  float enemyHP; //enemy current hp
  float enemyHPMax; //enemy max hp
  int enemyTiming; //enemy timing, used for projectile shot timing
  int enemyState; //0 = normal, 1 = hurt, 2 = dead
  float enemyMoveTiming; //used to move enemies in various ways

enemy(int enemyXtemp, int enemyYtemp, int enemySpeedXtemp, int enemySpeedYtemp, int enemyTypetemp, int enemyHitXtemp, int enemyHitYtemp, float enemyHPtemp, float enemyHPMaxtemp, int enemyTimingtemp, int enemyStatetemp, int enemyMoveTimingtemp) {
  enemyX = enemyXtemp;
  enemyY = enemyYtemp;
  enemySpeedX = enemySpeedXtemp;
  enemySpeedY = enemySpeedYtemp;
  enemyType = enemyTypetemp;
  enemyHitX = enemyHitXtemp;
  enemyHitY = enemyHitYtemp;
  enemyHP = enemyHPtemp;
  enemyHPMax = enemyHPMaxtemp;
  enemyTiming = enemyTimingtemp;
  enemyState = enemyStatetemp;
  enemyMoveTiming = enemyMoveTimingtemp;
}

 public void update() {
  enemyX = enemyX + enemySpeedX; //update enemy x pos according to speed
  enemyY = enemyY + enemySpeedY; //update enemy y pos according to speed
  if (enemyTiming < 255 && enemyState != 2) enemyTiming++; //increment enemy timer (used for timing enemy firing
  if (enemyHP <= 0) enemyState = 2; //set enemy as dead if hp is zero
  else enemyState = 0; //set enemy as alive if not dead
  if (enemyType == 0 && enemyState != 2) {
    enemySpeedY = (sin((enemyMoveTiming / 1)) * 1);
    enemyMoveTiming = enemyMoveTiming + 0.025f;
  } else if (enemyType == 4 && enemyState != 2) {
    if (enemyX <= 1000) enemyX = 1000;
    else enemyTiming = 199;
  }
}

 public void collision() {
  for (int i = 0; i < bulletCount; i++) { //run for every bullet instance
   if (blts[i].bulletType != 255 && enemyState != 2) { //check to ensure bullet is not inactive (for efficiency) and enemy is not dead
    if (enemyX - (enemyHitX / 2) <= blts[i].bulletX - (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((enemyX + (enemyHitX / 2)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (enemyY - (enemyHitY / 2) <= blts[i].bulletY - (blts[i].bulletHitY / 2)) {
          if ((enemyY + (enemyHitY / 2)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            if (blts[i].bulletType < 199) { //check if bullet type is player projectile
              enemyState = 1; //change enemy to hurt state
              enemyHP = enemyHP - blts[i].bulletPower; //reduce enemy hp per bullet power
              dmg[findDamage()] = new damage(enemyX, enemyY, blts[i].bulletPower, 0, 30);
              if (enemyHP <= 0) {
                enemyTiming = 30; //start timer over for death anim
                enemyState = 2; //set enemy to dead
              }
              if (blts[i].bulletType != 4) blts[i].reset(); //reset bullet on impact if not snipe shot
            }
            
          }
        }
      }
    }
  }
  }
}

 public void reset() {
  enemyX = -250;
  enemyY = -250;
  enemySpeedX = 0;
  enemySpeedY = 0;
  enemyType = 255;
  enemyHitX = 0;
  enemyHitY = 0;
  enemyHP = 0;
  enemyHPMax = 0;
  enemyState = 2; //dead
}

 public void hit(int bulletType) {
  //TEMP
}

 public void shoot() {
   if (enemyState != 2 && enemyX > 0 && enemyX < 1250) {
    if (enemyType == 0) { //check to see if enemy is basic and not dead
    if (enemyTiming > 60) { //check to make sure enough time has passed since last shot
    float speed = 10; //higher numbers are slower
    int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
    int offsetY = 10; //account for incorrect aim
    float c = sqrt((abs(playerX - enemyX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
    c = c * speed; //scale c (distance hypotenuse) to speed
    float speedX = (playerX - enemyX + offsetX);
    float speedY = (playerY - enemyY + offsetY);
    speedX = speedX / (c);
    speedY = speedY / (c);
    blts[findBullet()] = new bullet(enemyX, enemyY, speedX, speedY, 200, 10, 10, 10);
    enemyTiming = 0;
    }
  } else if (enemyType == 1) { //check for enemy type
    if (enemyTiming > 80) { //check to make sure enough time has passed since last shot
    blts[findBullet()] = new bullet(enemyX - 50, enemyY + 13, -5, 0, 200, 50, 5, 10);
    enemyTiming = 0;
    }
  } else if (enemyType == 2) { //check for enemy type
    if (enemyTiming > 120) { //check to make sure enough time has passed since last shot
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, +2, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, +1, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, 0, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, -1, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, -2, 200, 10, 10, 10);
    enemyTiming = 0;
    }
    } else if (enemyType == 3) { //check for enemy type
    if (enemyTiming > 30) { //check to make sure enough time has passed since last shot
      blts[findBullet()] = new bullet(enemyX - 40, enemyY + 13, -10, 0, 200, 10, 5, 5);
      enemyTiming = 0;
    }
  } else if (enemyType == 4) { //check for enemy type
    if (enemyTiming > 200) { //check to make sure enough time has passed since last shot
    basicE[findEnemy()] = new enemy(PApplet.parseInt(enemyX - 80), PApplet.parseInt(enemyY + 15), -2, 0, 5, 50, 50, 50, 50, 0, 0, 0); //i have no idea why the x/y need to be cast as ints but they do
    basicE[findEnemy()] = new enemy(PApplet.parseInt(enemyX - 80), PApplet.parseInt(enemyY + 15), -2, -1, 5, 50, 50, 50, 50, 0, 0, 0);
    basicE[findEnemy()] = new enemy(PApplet.parseInt(enemyX - 80), PApplet.parseInt(enemyY + 15), -2, 1, 5, 50, 50, 50, 50, 0, 0, 0);
      enemyTiming = 0;
    }
  } else if (enemyType == 5) { //check for enemy type, this is the bomb
    if (enemyTiming > 120) { //check to make sure enough time has passed since last shot
      blts[findBullet()] = new bullet(enemyX, enemyY, 0, -4, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, 0, +4, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, +4, 0, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -4, 0, 200, 10, 10, 10);
      
      blts[findBullet()] = new bullet(enemyX, enemyY, -2.828f, +2.828f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -2.828f, -2.828f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, +2.828f, +2.828f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, +2.828f, -2.828f, 200, 10, 10, 10);
      
      blts[findBullet()] = new bullet(enemyX, enemyY, +1.53f, +3.695f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -1.53f, +3.695f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, +1.53f, -3.695f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -1.53f, -3.695f, 200, 10, 10, 10);
      
      blts[findBullet()] = new bullet(enemyX, enemyY, +3.695f, +1.53f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -3.695f, +1.53f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, +3.695f, -1.53f, 200, 10, 10, 10);
      blts[findBullet()] = new bullet(enemyX, enemyY, -3.695f, -1.53f, 200, 10, 10, 10);
      
      //destroy bomb
      enemyTiming = 30;
      enemyState = 2;
      enemyHP = 0;
    }
  }
   }
}

 public void display() {
  strokeWeight(1);
  noStroke();
  if (enemyState != 2) { //do not display hp bar if enemy is dead
    fill(20, 255, 20, 100);
    rect(enemyX - (enemyHitX * 0.45f), enemyY - (enemyHitY - 5), ((enemyHitX - 5) * (enemyHP / enemyHPMax)), 5);
    
    if (enemyState == 1) tint(255, 100, 100);
    
    if (enemyType == 0 && enemyState != 2) {
      image(naturals1, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 1 && enemyState != 2) {
      image(naturals2, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 2 && enemyState != 2) {
      image(naturals3, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 3 && enemyState != 2) {
      image(naturals4, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 4 && enemyState != 2) {
      image(naturals5, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else {
      fill(255, 0, 0);
      ellipse(enemyX, enemyY, enemyHitX, enemyHitY);
    }
    tint(255, 255, 255); //reset tint
  } else if (enemyState == 2 && enemyTiming !=0) { //death state anim
    fill(255, 127, 0, 100);
    ellipse(enemyX, enemyY, enemyHitX + (enemyTiming * 3), enemyHitY + (enemyTiming * 3));
    fill(255, 165, 0, 120);
    ellipse(enemyX, enemyY, enemyHitX + (enemyTiming * 2), enemyHitY + (enemyTiming * 2));
    fill(255, 240, 60, 150);
    ellipse(enemyX, enemyY, enemyHitX + (enemyTiming * 1), enemyHitY + (enemyTiming * 1));
    enemyTiming--;
  }
  
}
}
 public void loadText() {
  String[] lines = loadStrings("assets/text/script.txt");
  for (int i = 0 ; i < lines.length; i++) {
    //println(lines[i]);
    textLines[i] = lines[i];
  }
}

 public void loadSprites() {
  naturals1 = loadImage("assets/png/naturals/3-x.png");
  naturals2 = loadImage("assets/png/naturals/2-x.png");
  naturals3 = loadImage("assets/png/naturals/1-x.png");
  naturals4 = loadImage("assets/png/naturals/4-x.png");
  naturals5 = loadImage("assets/png/naturals/5-x.png");
  player1 = loadImage("assets/png/player/3.png");
  
  vnPlayer1 = loadImage("assets/vn/player/1.png");
  vnPlayer2 = loadImage("assets/vn/player/2.png");
  vnPlayer1r = loadImage("assets/vn/player/1-r.png");
  vnPlayer2r = loadImage("assets/vn/player/2-r.png");
  vnSol1 = loadImage("assets/vn/sol/1.png");
  vnSol2 = loadImage("assets/vn/sol/2.png");
  vnSol3 = loadImage("assets/vn/sol/3.png");
  
  vnEsence1 = loadImage("assets/vn/esence/1.png");
  vnEsence2 = loadImage("assets/vn/esence/2.png");
}
 public void placeEnemies() {
  if (levelIndex == 0) {
    //temp layout
    /*genEnemy(0, 700, 200);
    genEnemy(0, 500, 400);
    genEnemy(0, 900, 400);
    genEnemy(0, 1100, 20);
    genEnemy(0, 1000, 20);
    genEnemy(1, 900, 200);
    genEnemy(1, 1100, 650);
    genEnemy(2, 800, 500);
    genEnemy(0, 1700, 100);
    genEnemy(0, 1500, 400);
    genEnemy(0, 1400, 600);*/
    
    genEnemy(0, 1000, 300);
    
    genEnemy(0, 1300, 200);
    genEnemy(0, 1300, 400);
    
    genEnemy(3, 1600, 50);
    genEnemy(3, 1600, 225);
    genEnemy(3, 1600, 400);
    genEnemy(3, 1600, 575);
    
    genEnemy(0, 2000, 100);
    genEnemy(0, 2000, 300);
    genEnemy(0, 2000, 500);
    
    genEnemy(1, 2400, 50);
    genEnemy(1, 2400, 225);
    genEnemy(1, 2400, 400);
    genEnemy(1, 2400, 575);
    
    genEnemy(0, 2800, 100);
    genEnemy(0, 2800, 300);
    genEnemy(0, 2800, 500);
    
    genEnemy(3, 3200, 50);
    genEnemy(3, 3200, 225);
    genEnemy(3, 3200, 400);
    genEnemy(3, 3200, 575);
    
    genEnemy(1, 3600, 100);
    genEnemy(2, 3600, 300);
    genEnemy(1, 3600, 500);
    
    genEnemy(0, 4000, 50);
    genEnemy(0, 4000, 225);
    genEnemy(0, 4000, 400);
    genEnemy(0, 4000, 575);
    
    genEnemy(4, 5400, 300);
  } else if (levelIndex == 1) {
    genEnemy(4, 1000, 300);
  }
}

 public void genEnemy(int type, int x, int y) { //used for placing enemies easier, pass in enemy type and position x/y
  enemyIndex = findEnemy();
  if (type == 0) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = 0;
    basicE[enemyIndex].enemyHitX = 55;
    basicE[enemyIndex].enemyHitY = 55;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  } else if (type == 1) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 105;
    basicE[enemyIndex].enemyHitY = 43;
    basicE[enemyIndex].enemyHP = 30;
    basicE[enemyIndex].enemyHPMax = 30;
  } else if (type == 2) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 85;
    basicE[enemyIndex].enemyHitY = 35;
    basicE[enemyIndex].enemyHP = 40;
    basicE[enemyIndex].enemyHPMax = 40;
  } else if (type == 3) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 95;
    basicE[enemyIndex].enemyHitY = 29;
    basicE[enemyIndex].enemyHP = 10;
    basicE[enemyIndex].enemyHPMax = 10;
  } else if (type == 4) {
    basicE[enemyIndex].enemyX = x;
    basicE[enemyIndex].enemyY = y;
    basicE[enemyIndex].enemySpeedX = autoScroll;
    basicE[enemyIndex].enemySpeedY = 0;
    basicE[enemyIndex].enemyType = type;
    basicE[enemyIndex].enemyHitX = 126;
    basicE[enemyIndex].enemyHitY = 51;
    basicE[enemyIndex].enemyHP = 100;
    basicE[enemyIndex].enemyHPMax = 100;
  }
}
 public void processInput() {
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
      if (keyInput[7] == true) { //q, next weapon
        playerWeapon = 1;
      }
  } else if (screenIndex == 1) {
    if (keyInput[4] == true) screenIndex = 2;
  } else if (screenIndex == 2) {
    if (keyInput[0] == true) {
      screenIndex = 0;
      initObjects();
    }  
  } else if (screenIndex == 3) {
    if (keyInput[4] == true) {
      textIndex++;
      if (textIndex == 9) {
        screenIndex = 0;
        initObjects();
        enemiesPlaced = false;
      }
      keyInput[4] = false;
    }
  }
}

 public void keyPressed() {
  if (key == 'w' || key == 'W')  keyInput[0] = true;
  if (key == 's' || key == 'S')  keyInput[1] = true;
  if (key == 'd' || key == 'D')  keyInput[2] = true;
  if (key == 'a' || key == 'A')  keyInput[3] = true;
  if (key == ' ') keyInput[4] = true;
  if (key == 'q' || key == 'Q')  keyInput[5] = true;
  if (key == 'e' || key == 'E')  keyInput[6] = true;
  if (key == 'r' || key == 'R')  keyInput[7] = true;
}

 public void keyReleased() {
  if (key == 'w' || key == 'W')  keyInput[0] = false;
  if (key == 's' || key == 'S')  keyInput[1] = false;
  if (key == 'd' || key == 'D')  keyInput[2] = false;
  if (key == 'a' || key == 'A')  keyInput[3] = false;
  if (key == ' ') keyInput[4] = false;
  if (key == 'q' || key == 'Q')  keyInput[5] = false;
  if (key == 'e' || key == 'E')  keyInput[6] = false;
  if (key == 'r' || key == 'R')  keyInput[7] = false;
}

 public void playerShoot() {
  if (playerWeapon == 0) { //machine gun
    if (timing > playerWeaponCooldown0) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 0, playerWeapon, 10, 10, playerWeaponPower0);
      timing = 0;
    }
  } else if (playerWeapon == 1) { //spread shot
    if (timing > playerWeaponCooldown1) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 0, playerWeapon, 10, 10, playerWeaponPower1);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 1, playerWeapon, 10, 10, playerWeaponPower1);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, 2, playerWeapon, 10, 10, playerWeaponPower1);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, -2, playerWeapon, 10, 10, playerWeaponPower1);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 10, -1, playerWeapon, 10, 10, playerWeaponPower1);
      timing = 0;
    }
  } else if (playerWeapon == 2) { //dual beam cannon
      if (timing > playerWeaponCooldown2) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY + 5, 20, 0, playerWeapon, 50, 7, playerWeaponPower2);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY - 5, 20, 0, playerWeapon, 50, 7, playerWeaponPower2);
      timing = 0;
    }
  } else if (playerWeapon == 4) { //sniper shot
      if (timing > playerWeaponCooldown4) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, 25, 0, playerWeapon, 100, 5, playerWeaponPower4);
      timing = 0;
    }
  }
  if (playerSecondWeapon == 0) { //basic secondary missile
    if (secondTiming > playerWeaponCooldown100) {
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, +10, playerSecondWeapon + 100, 10, 5, playerWeaponPower100);
      blts[findBullet()] = new bullet(playerX + playerBulletOffsetX, playerY + playerBulletOffsetY, -10, -10, playerSecondWeapon + 100, 10, 5, playerWeaponPower100);
      secondTiming = 0;
    }
  }
}
class starsBG {
  int starX;
  int starY;
  int starSpeedX;
  int starSpeedY;

starsBG(int starXtemp, int starYtemp, int starSpeedXtemp, int starSpeedYtemp) {
  starX = starXtemp;
  starY = starYtemp;
  starSpeedX = starSpeedXtemp;
  starSpeedY = starSpeedYtemp;
}

 public void update() {
  starX = starX + starSpeedX;
  starY = starY + starSpeedY;
  if (starX < 0) {
    starY = PApplet.parseInt(random(screenY));
    starX = screenX + 20;
    starSpeedX = PApplet.parseInt(-1 * (random(10) + 1));
  }
}

 public void reset() {
  starX = -200;
  starY = -200;
  starSpeedX = 0;
  starSpeedY = 0;
}

 public void display() {
  strokeWeight(5);
  stroke(255, 25);
  fill(255, (150 - (starSpeedX * 20)));
  ellipse(starX, starY, 5, 5);
}
}
//game vars
int screenIndex = 0; //0 = game, 1 = title, 2 = level select, 3 = visual novel story stuff
int levelIndex = 0; //what level the player is playing, 0 is test level
boolean enemiesPlaced = false; //used to only place enemies once per level load
int enemyIndex = 0; //used for enemy gen
int bulletCount = 500; //total bullet objects
int basicECount = 100; //total enemy objects
int dmgCount = 200; //total damage (readout) objects
int starCount = 300; //how many stars to display
int timing = 0; //used for various timings, namely the players weapon firing timer
int secondTiming = 0; //used for timing secondary weapons
int screenX = 1280;
int screenY = 720;
float autoScroll = -2; //controls how fast the enemies move to the left

//player vars
float playerX = 200;
float playerY = 250;
int playerHitX = 30;
int playerHitY = 7;
int playerBulletOffsetX = 45; //offset for where bullet is generated relative to player model
int playerBulletOffsetY = 5; //offset for where bullet is generated relative to player model
int playerMoveX = 3;
int playerMoveY = 3;
int playerWeapon = 2;
int playerSecondWeapon = 0;
int playerState = 0; //0 = normal, 1 = hurt
int bulletIndex = 0;
float playerShield = 20;
float playerShieldMax = 100;
float playerShieldRegen = 0.5f;
float playerHP = 100;
float playerHPMax = 100;

//player weapon vars
//machine gun
int playerWeaponCooldown0 = 10;
float playerWeaponPower0 = 5;
int playerWeaponHitX0 = 10;
int playerWeaponHitY0 = 10;
//spread shot
int playerWeaponCooldown1 = 40;
float playerWeaponPower1 = 3.5f;
//dual beam cannon
int playerWeaponCooldown2 = 20;
float playerWeaponPower2 = 3.5f;
//snipe shot
int playerWeaponCooldown4 = 30;
float playerWeaponPower4 = 5;
//basic secondary missile
int playerWeaponCooldown100 = 40;
float playerWeaponPower100 = 10;

//input vars
boolean keyInput[] = new boolean [15];

//visual novel vars
int eventIndex = 0; //index value for events
int textIndex = 0; //index value for which line of dialogue should be displayed
int bgIndex = 0; //background index
int textTiming = 0; //used for rendering each letter individually, ie it looks like its being typed out
String[] textLines = new String[999]; //used for each line of dialogue
int[][] vnInfo = new int[999][5]; //used for stuff like who should be rendered, tint, etc

//animation timing vars
int playerEngineTimer = 0;
 public void drawVN() {
  switch(vnInfo[textIndex + 1][2]) { //left side vn portrait tint
    case 0:
    tint(255, 255, 255, 255);
    break;
    case 1:
    tint(255, 100);
    break;
  }
  switch(vnInfo[textIndex + 1][0]) { //left side vn portrait image
    case 0:
    image(vnPlayer1r, 0, 0, 500, 500);
    break;
    case 1:
    image(vnPlayer2r, 0, 0, 500, 500);
    break;
    case 5:
    //image(vnSol1r, 0, 0, 500, 500);
    break;
    default:
    break;
  }
  switch(vnInfo[textIndex + 1][3]) { //right side vn portrait tint
    case 0:
    tint(255, 255, 255, 255);
    break;
    case 1:
    tint(255, 100);
    break;
    default:
    break;
  }
  switch(vnInfo[textIndex + 1][1]) { //right side vn portrait image
    case 0:
    image(vnPlayer1, 800, 0, 500, 500);
    break;
    case 1:
    image(vnPlayer2, 800, 0, 500, 500);
    break;
    case 5:
    image(vnSol1, 800, 0, 500, 500);
    break;
    case 10:
    image(vnEsence1, 800, 0, 500, 500);
    break;
    case 11:
    image(vnEsence2, 800, 0, 500, 500);
    break;
    default:
    break;
  }
  tint(255, 255, 255, 255); //reset image tint
  
  strokeWeight(2);
  stroke(255);
  fill(20, 20, 255);
  rect(20, 450, 1240, 250, 20);
  rect(1150, 650, 100, 40, 5);
  rect(1040, 650, 100, 40, 5);
  textSize(48);
  fill(255);
  noStroke();
  text(textLines[textIndex], 35, 460, 1230, 250);
  textSize(32);
  text("SKIP", 1050, 680);
  text("NEXT", 1160, 680);
}

 public void fillvnInfo() {
  vnInfo[1][0] = 0;
  vnInfo[1][1] = 10;
  vnInfo[1][2] = 1;
  vnInfo[1][3] = 0;
  
  vnInfo[2][0] = 0;
  vnInfo[2][1] = 10;
  vnInfo[2][2] = 0;
  vnInfo[2][3] = 1;
  
  vnInfo[3][0] = 0;
  vnInfo[3][1] = 11;
  vnInfo[3][2] = 1;
  vnInfo[3][3] = 0;
  
  vnInfo[4][0] = 0;
  vnInfo[4][1] = 10;
  vnInfo[4][2] = 1;
  vnInfo[4][3] = 0;
  
  vnInfo[5][0] = -1;
  vnInfo[5][1] = -1;
  vnInfo[5][2] = 0;
  vnInfo[5][3] = 0;
  
  vnInfo[6][0] = 1;
  vnInfo[6][1] = 10;
  vnInfo[6][2] = 0;
  vnInfo[6][3] = 1;
  
  vnInfo[7][0] = 0;
  vnInfo[7][1] = 11;
  vnInfo[7][2] = 1;
  vnInfo[7][3] = 0;
  
  vnInfo[8][0] = 0;
  vnInfo[8][1] = 10;
  vnInfo[8][2] = 1;
  vnInfo[8][3] = 0;
  
  vnInfo[9][0] = 1;
  vnInfo[9][1] = -1;
  vnInfo[9][2] = 0;
  vnInfo[9][3] = 0;
}


  public void settings() { size(1280, 720); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "edge_of_solaris" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

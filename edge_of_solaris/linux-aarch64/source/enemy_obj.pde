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

void update() {
  if (screenIndex != 9) enemyX = enemyX + enemySpeedX; //update enemy x pos according to speed (only if not in level editor
  enemyY = enemyY + enemySpeedY; //update enemy y pos according to speed
  if (enemyHP <= 0) enemyState = 2; //set enemy as dead if hp is zero
  if (enemyState != 2) { //only run if enemy is not dead
    if (enemyTiming < 255) enemyTiming++; //increment enemy timer (used for timing enemy firing
    
    switch(enemyType) {
      case 0:
      enemySpeedY = (sin((enemyMoveTiming / 1)) * 1);
      enemyMoveTiming = enemyMoveTiming + 0.025;
      break;
      case 3:
      //enemyMoveTiming++;
      break;
      case 4:
      if (screenIndex != 9) { //only run if not in level editor mode
        if (enemyX <= 1000) enemyX = 1000;
        else enemyTiming = 199;
      }
      break;
      default:
      break;
    }
    
    if (enemyX < -200) enemyState = 2; //kill enemy if off screen
    if (enemyType == 7 && screenIndex != 9) { //only do if enemy type is energy weapon and not in level editor
      enemyHP = enemyHP + (enemyHPMax / 1000);
      if (enemyHP > enemyHPMax) enemyHP = enemyHPMax;
      if (enemyX < (900 - (abs(enemyY - 300))/2)) enemySpeedX = 0;
    }
  }
}

void collision() {
  for (int i = 0; i < bulletCount; i++) { //run for every bullet instance
   if (blts[i].bulletType != 255 && enemyState != 2) { //check to ensure bullet is not inactive (for efficiency) and enemy is not dead
    if (enemyX - (enemyHitX / 2) <= blts[i].bulletX - (blts[i].bulletHitX / 2)) {
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
                playerMoney = playerMoney + (enemyHPMax * moneyValueDrop * moneyBalance); //add money for kill
                playerXP = playerXP + (enemyHPMax * xpValueDrop * xpBalance); //add xp for kill
                checkForLevelUp(); //check if player leveled up
              }
              if (blts[i].bulletType != 3) blts[i].reset(); //reset bullet on impact if not snipe shot
            }
            
          }
        }
      }
    }
  }
  }
}

void reset() {
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

void shoot() {
  if (screenIndex == 9) displayX = enemyX - scrollX;
   else displayX = enemyX;
   if (enemyState != 2 && displayX < 1250 * screenScaling) { //check if enemy is on screen and not dead
    if (enemyType == 0) { //check to see if enemy is a drone
    if (enemyTiming > 40) { //check to make sure enough time has passed since last shot
    float speed = 5; //higher numbers are slower
    int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
    int offsetY = 10; //account for incorrect aim
    float c = sqrt((abs(playerX - displayX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
    c = c * speed; //scale c (distance hypotenuse) to speed
    float speedX = (playerX - displayX + offsetX);
    float speedY = (playerY - enemyY + offsetY);
    speedX = speedX / (c);
    speedY = speedY / (c);
    blts[findBullet()] = new bullet(displayX, enemyY, speedX, speedY, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    enemyTiming = 0;
    }
  } else if (enemyType == 1) { //check for enemy type helicopter
    if (enemyTiming > 10) { //check to make sure enough time has passed since last shot
    if (enemyMoveTiming > 40) {
    float speed = 5; //higher numbers are slower
    int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
    int offsetY = 10; //account for incorrect aim
    float c = sqrt((abs(playerX - displayX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
    c = c * speed; //scale c (distance hypotenuse) to speed
    float speedX = (playerX - displayX + offsetX);
    float speedY = (playerY - enemyY + offsetY);
    speedX = speedX / (c);
    speedY = speedY / (c);
    blts[findBullet()] = new bullet(displayX - 100, enemyY + 20, speedX, speedY, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    blts[findBullet()] = new bullet(displayX - 100, enemyY + 20, speedX, -speedY, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    enemyTiming = 0;
    }
    if (enemyMoveTiming > 43) enemyMoveTiming = 0;
    enemyMoveTiming++;
    }
  } else if (enemyType == 2) { //check for enemy type small interceptor that shoots a spread shot
    if (enemyTiming > 60) { //check to make sure enough time has passed since last shot
    blts[findBullet()] = new bullet(displayX - 70, enemyY, -5, +5, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    blts[findBullet()] = new bullet(displayX - 70, enemyY, -5, -5, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    blts[findBullet()] = new bullet(displayX - 70, enemyY, +5, 0, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    blts[findBullet()] = new bullet(displayX - 70, enemyY, +5, +5, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    blts[findBullet()] = new bullet(displayX - 70, enemyY, +5, -5, 200, 10, 10, 10 * enemyBalanceDMG, 0);
    enemyTiming = 0;
    }
    } else if (enemyType == 3) { //check for enemy type medium interceptor
    if (enemyTiming > 2) { //check to make sure enough time has passed since last shot
      if (enemyMoveTiming > 40) {
      blts[findBullet()] = new bullet(displayX - 80, enemyY + 17, -10, random(1)-0.5, 200, 10, 5, 5 * enemyBalanceDMG, 0);
      enemyTiming = 0;
      }
      if (enemyMoveTiming > 44) enemyMoveTiming = 0;
      enemyMoveTiming++;
    }
  } else if (enemyType == 4) { //check for enemy type miniboss cargo ship
    if (enemyTiming > 200) { //check to make sure enough time has passed since last shot
    basicE[findEnemy()] = new enemy(int(displayX - 80), int(enemyY + 15), -2, 0, 5, 50, 50, 50, 50, 0, 0, 0); //i have no idea why the x/y need to be cast as ints but they do
    basicE[findEnemy()] = new enemy(int(displayX - 80), int(enemyY + 15), -2, -1, 5, 50, 50, 50, 50, 0, 0, 0);
    basicE[findEnemy()] = new enemy(int(displayX - 80), int(enemyY + 15), -2, 1, 5, 50, 50, 50, 50, 0, 0, 0);
      enemyTiming = 0;
    }
  } else if (enemyType == 5) { //check for enemy type, this is the bomb
    if (enemyTiming > 120) { //check to make sure enough time has passed since last shot
      blts[findBullet()] = new bullet(displayX, enemyY, 0, -4, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, 0, +4, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, +4, 0, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -4, 0, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      
      blts[findBullet()] = new bullet(displayX, enemyY, -2.828, +2.828, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -2.828, -2.828, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, +2.828, +2.828, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, +2.828, -2.828, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      
      blts[findBullet()] = new bullet(displayX, enemyY, +1.53, +3.695, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -1.53, +3.695, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, +1.53, -3.695, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -1.53, -3.695, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      
      blts[findBullet()] = new bullet(displayX, enemyY, +3.695, +1.53, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -3.695, +1.53, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, +3.695, -1.53, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      blts[findBullet()] = new bullet(displayX, enemyY, -3.695, -1.53, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      
      //destroy bomb
      enemyTiming = 30;
      enemyState = 2;
      enemyHP = 0;
    }
  } else if (enemyType == 6) { //small interceptor that shoots homing shots once it reaches the end of the screen
    if (enemyTiming > 20 && enemyX < 200 * screenScaling) {
      float speed = 10; //higher numbers are slower
      int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
      int offsetY = 10; //account for incorrect aim
      float c = sqrt((abs(playerX - enemyX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
      c = c * speed; //scale c (distance hypotenuse) to speed
      float speedX = (playerX - enemyX + offsetX);
      float speedY = (playerY - enemyY + offsetY);
      speedX = speedX / (c);
      speedY = speedY / (c);
      blts[findBullet()] = new bullet(displayX, enemyY, speedX, speedY, 200, 10, 10, 10 * enemyBalanceDMG, 0);
      enemyTiming = 0;
    }
  } else if (enemyType == 7) { //energy weapon
    if (enemyTiming > 120) {
      blts[findBullet()] = new bullet(displayX - 140, enemyY, -30, 0, 201, 250, 20, 5 * enemyBalanceDMG, 0);
      enemyTiming = 0;
    }
  }
   }
}

void display() {
  displayX = (enemyX - scrollX);
  strokeWeight(1);
  noStroke();
  if (enemyState == 1) tint(255, 100, 100);
  if (enemyState != 2 && displayX < (1500 * screenScaling)) { //do not display hp bar and render enemy if enemy is dead
    if (screenIndex == 9 || screenIndex == 0) {
      //draw hp bars
      strokeWeight(1);
      stroke(0);
      fill(20, 255, 20, 100);
      rect((displayX - (enemyHitX * 0.45)) * screenScaling, (enemyY - (enemyHitY - 5)) * screenScaling, (((enemyHitX - 5) * (enemyHP / enemyHPMax))) * screenScaling, 5 * screenScaling);
      
      //draw enemies
      switch(enemyType) {
        case 0: //drone that fires a homing shot
        image(faun1, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 1: //small gunship
        image(faun2, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 2: //small interceptor (spread shot)
        image(faun3, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 3: //medium interceptor
        image(faun4, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 4: //cargo ship
        image(faun5, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 6: //small interceptor that does not fire until it reaches a certain part of the screen, then fires a homing shot
        image(faun3, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        case 7: //energy weapon that charges
        fill(20, 20, 200, 150);
        stroke(20, 20, 200, 150);
        rect((displayX - (enemyTiming / 2)) * screenScaling, (enemyY - 12) * screenScaling, 50 * screenScaling, 25 * screenScaling); //shooting animation
        image(faun6, (displayX - (enemyHitX / 2)) * screenScaling, (enemyY - (enemyHitY / 2)) * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
        default:
        noStroke();
        fill(255, 0, 0);
        ellipse(displayX * screenScaling, enemyY * screenScaling, enemyHitX * screenScaling, enemyHitY * screenScaling);
        break;
      }
    }
    tint(255, 255, 255); //reset tint
    enemyState = 0; //reset enemy state (so it untints after being shot)
  } else if (enemyState == 2 && enemyTiming !=0) { //death state anim
    fill(255, 127, 0, 100);
    ellipse(enemyX * screenScaling, enemyY * screenScaling, ((enemyHitX / 3) + (enemyTiming * 5)) * screenScaling, ((enemyHitY / 2) + (enemyTiming * 3)) * screenScaling);
    fill(255, 165, 0, 120);
    ellipse(enemyX * screenScaling, enemyY * screenScaling, ((enemyHitX / 3) + (enemyTiming * 4)) * screenScaling, ((enemyHitY / 2) + (enemyTiming * 2)) * screenScaling);
    fill(255, 240, 60, 150);
    ellipse(enemyX * screenScaling, enemyY * screenScaling, ((enemyHitX / 3) + (enemyTiming * 3)) * screenScaling, ((enemyHitY / 2) + (enemyTiming * 1)) * screenScaling);
    enemyTiming--;
  }
  
}
}

class bullet {
  float bulletX; //bullet x pos
  float bulletY; //bullet y pos
  float bulletSpeedX; //bullet x speed
  float bulletSpeedY; //bullet y speed
  int bulletType; //255 = dead/inactive bullet, 0-199 = player bullets, 200-254 = enemy bullets
  int bulletHitX; //bullet hitbox x
  int bulletHitY; //bullet hitbox y
  float bulletPower; //bullet impact damage (defined on bullet gen)
  int bulletTimer; //used for timed bullet functions

bullet(float bulletXtemp, float bulletYtemp, float bulletSpeedXtemp, float bulletSpeedYtemp, int bulletTypetemp, int bulletHitXtemp, int bulletHitYtemp, float bulletPowertemp, int bulletTimertemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
  bulletType = bulletTypetemp;
  bulletHitX = bulletHitXtemp;
  bulletHitY = bulletHitYtemp;
  bulletPower = bulletPowertemp;
  bulletTimer = bulletTimertemp;
}

void update() {
  if (bulletX > (screenX + 100) || bulletX < -100 || bulletY > (screenY + 100) || bulletY < -100) bulletType = 255; //destroy bullet if off screen
  else { //if bullet is not off screen, update bullet position and timer
    bulletX = bulletX + bulletSpeedX; //update bullet x according to x speed
    bulletY = bulletY + bulletSpeedY; //update bullet y according to y speed
    bulletTimer++; //increment bullet's timer if bullet is alive
  }
  if (bulletType == 100) { //basic secondary rockets
    if (bulletSpeedY > 0) bulletSpeedY--;
    if (bulletSpeedY < 0) bulletSpeedY++;
    if (bulletSpeedX < 5) bulletSpeedX++;
  } else if (bulletType == 101) { //tracking secondary missiles
    float enemyDistance = 999999999; //how far away is the enemy
    float enemyDistanceX; //distance from enemy x
    float enemyDistanceY; //distance from enemy y
    int enemyTargetIndex = 9999; //which enemy is being targeted
    for (int i = 0; i < basicECount; i++) {
      if (basicE[i].enemyState != 2) { //confirm enemy is not dead
        enemyDistanceX = abs(basicE[i].enemyX - bulletX); //find difference on x axis
        enemyDistanceY = abs(basicE[i].enemyY - bulletY); //find difference on y axis
        float enemyDistanceNew = sqrt(pow(enemyDistanceX, 2) + pow(enemyDistanceY, 2));
        if (enemyDistanceNew < enemyDistance) { //if current enemy distance is less than previous enemy distance
          enemyDistance = enemyDistanceNew; //set current closest distance to current distance
          enemyTargetIndex = i; //set the current targeted enemy to be this enemy
        }
      }
    }
    if (enemyDistance != 999999999 && enemyTargetIndex != 9999) { //basically just checks if the above loop actually found an enemy
      if (basicE[enemyTargetIndex].enemyX < 1250) {
        float speed = 0.1; //higher numbers are slower
        int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
        int offsetY = 10; //account for incorrect aim
        enemyDistance = enemyDistance * speed; //scale c (distance hypotenuse) to speed
        float speedX = (basicE[enemyTargetIndex].enemyX - bulletX + offsetX);
        float speedY = (basicE[enemyTargetIndex].enemyY - bulletY + offsetY);
        float bulletSpeedXNew = speedX / (enemyDistance);
        float bulletSpeedYNew = speedY / (enemyDistance);
        if (bulletSpeedXNew < bulletSpeedX) bulletSpeedX = bulletSpeedX - 0.1;
        if (bulletSpeedXNew > bulletSpeedX) bulletSpeedX = bulletSpeedX + 0.1;
        if (bulletSpeedYNew < bulletSpeedY) bulletSpeedY = bulletSpeedY - 0.1;
        if (bulletSpeedYNew > bulletSpeedY) bulletSpeedY = bulletSpeedY + 0.1;
      }
    }
  } else if (bulletType == 1) { //shotgun/spread shot
    bulletHitX = int(10 - pow(1.030, bulletTimer));
    bulletHitY = int(10 - pow(1.030, bulletTimer));
    bulletPower = (playerWeaponPower1 * playerAttack) - pow(1.030, bulletTimer);
    if (bulletHitX < 1) bulletType = 255; //kill bullet if too small
  } else if (bulletType == 200) { //basic enemy bullet
    
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
  bulletTimer = 0;
}

void explode() {
}

void display() {
  if (bulletType == 0) { //machine gun
    stroke(20, 20, 200, 120);
    strokeWeight(2);
    fill(20, 20, 200);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 1) { //spread shot
    noStroke();
    fill(139, 69, 19, 200);
    ellipse(bulletX, bulletY, bulletHitX + 5, bulletHitY + 5);
    stroke(220, 220, 20, 120);
    strokeWeight(2);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 4) { //snipe shot
    noStroke();
    fill(20, 20, 255, 200);
    ellipse(bulletX, bulletY, bulletHitX + 5, bulletHitY + 5);
    stroke(255, 120);
    strokeWeight(10);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 100) { //basic secondary missile
    stroke(255, 20, 20, 200);
    strokeWeight(3);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }else if (bulletType == 101) {   
    stroke(255, 77, 0, 150);
    strokeWeight(3);
    fill(255, 77, 0, 150);
    ellipse(bulletX - (bulletSpeedX / 1), bulletY - (bulletSpeedY / 1), bulletHitX - 1, bulletHitY - 1);
    
    stroke(255, 77, 0, 100);
    strokeWeight(3);
    fill(255, 77, 0, 100);
    ellipse(bulletX - (bulletSpeedX / 0.5), bulletY - (bulletSpeedY / 0.5), bulletHitX - 1   , bulletHitY - 1);
    
    stroke(155, 77, 0, 50);
    strokeWeight(3);
    fill(255, 77, 0, 50);
    ellipse(bulletX - (bulletSpeedX / 0.35), bulletY - (bulletSpeedY / 0.35), bulletHitX - 1   , bulletHitY - 1);
    
    stroke(255, 2, 255, 200);
    strokeWeight(3);
    fill(255, 200, 220);
    ellipse(bulletX - (bulletSpeedX / 2), bulletY - (bulletSpeedY / 2), bulletHitX, bulletHitY);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 2) { //dual beam cannon
    stroke(20, 20, 200, 150);
    strokeWeight(2);
    fill(100, 100, 255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 200) { //basic enemy shot
    stroke(20, 200, 20, 150);
    strokeWeight(2);
    fill(20, 255, 20, 150);
    ellipse(bulletX, bulletY, bulletHitX + 5, bulletHitY + 5);
    fill(175, 255, 175);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 201) { //enemy energy shot (enemyindex 7)
    stroke(20, 20, 200, 150);
    strokeWeight(2);
    fill(20, 20, 255, 150);
    ellipse(bulletX, bulletY, bulletHitX + 5, bulletHitY + 5);
    fill(175, 175, 255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
}
}

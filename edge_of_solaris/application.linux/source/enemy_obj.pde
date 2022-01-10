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
  enemyX = enemyX + enemySpeedX; //update enemy x pos according to speed
  enemyY = enemyY + enemySpeedY; //update enemy y pos according to speed
  if (enemyTiming < 255 && enemyState != 2) enemyTiming++; //increment enemy timer (used for timing enemy firing
  if (enemyHP <= 0) enemyState = 2; //set enemy as dead if hp is zero
  else enemyState = 0; //set enemy as alive if not dead
  if (enemyType == 0 && enemyState != 2) {
    enemySpeedY = (sin((enemyMoveTiming / 1)) * 1);
    enemyMoveTiming = enemyMoveTiming + 0.025;
  }
}

void collision() {
  for (int i = 0; i < bulletCount; i++) { //run for every bullet instance
   if (blts[i].bulletType != 255 && enemyState != 2) { //check to ensure bullet is not inactive (for efficiency) and enemy is not dead
    if (enemyX - (enemyHitX / 2) <= blts[i].bulletX - (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((enemyX + (enemyHitX / 2)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (enemyY - (enemyHitY / 2) <= blts[i].bulletY - (blts[i].bulletHitY / 2)) {
          if ((enemyY + (enemyHitY / 2)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            if (blts[i].bulletType == 0 || blts[i].bulletType == 4) { //check if bullet type is player projectile
              enemyState = 1; //change enemy to hurt state
              enemyHP = enemyHP - blts[i].bulletPower; //reduce enemy hp per bullet power
              if (enemyHP <= 0) {
                enemyTiming = 30; //start timer over for death anim
                enemyState = 2; //set enemy to dead
              }
            }
            if (blts[i].bulletType == 0) blts[i].reset(); //reset bullet on impact if not snipe shot
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
  enemyType = 0;
  enemyHitX = 0;
  enemyHitY = 0;
  enemyHP = 0;
  enemyHPMax = 0;
  enemyState = 2; //dead
}

void hit(int bulletType) {
  //TEMP
}

void shoot() {
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
  } else if (enemyType == 1) { //check to see if enemy is basic2 and not dead
    if (enemyTiming > 80) { //check to make sure enough time has passed since last shot
    blts[findBullet()] = new bullet(enemyX - 50, enemyY + 13, -10, 0, 200, 50, 5, 10);
    enemyTiming = 0;
    }
  } else if (enemyType == 2) { //check to see if enemy is basic2 and not dead
    if (enemyTiming > 120) { //check to make sure enough time has passed since last shot
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, +2, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, +1, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, 0, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, -1, 200, 10, 10, 10);
    blts[findBullet()] = new bullet(enemyX, enemyY, -5, -2, 200, 10, 10, 10);
    enemyTiming = 0;
    }
  }
   }
}

void display() {
  strokeWeight(1);
  noStroke();
  if (enemyState != 2) { //do not display hp bar if enemy is dead
    fill(20, 255, 20, 100);
    rect(enemyX - (enemyHitX * 0.45), enemyY - (enemyHitY - 5), ((enemyHitX - 5) * (enemyHP / enemyHPMax)), 5);
  }
  fill(255, 0, 0);
  if (enemyState == 0) { //normal state
    if (enemyType == 0 && enemyState != 2) {
      image(naturals1, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 1 && enemyState != 2) {
      image(naturals2, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 2 && enemyState != 2) {
      image(naturals3, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else {
      fill(255, 0, 0);
      ellipse(enemyX, enemyY, enemyHitX, enemyHitY);
    }
  } else if (enemyState == 1) { //hurt state
    if (enemyType == 0 && enemyState != 2) {
      image(naturals1, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 1 && enemyState != 2) {
      image(naturals2, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else if (enemyType == 2 && enemyState != 2) {
      image(naturals3, enemyX - (enemyHitX / 2), enemyY - (enemyHitY / 2));
    } else {
      fill(255, 0, 0);
      ellipse(enemyX, enemyY, enemyHitX, enemyHitY);
    }
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

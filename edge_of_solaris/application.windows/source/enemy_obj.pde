class enemy {
  int enemyX; //enemy x pos
  int enemyY; //enemy y pos
  int enemySpeedX; //enemy x speed
  int enemySpeedY; //enemy y speed
  int enemyType; //type of enemy, 0 = basic
  int enemyHitX; //enemy hitbox x
  int enemyHitY; //enemy hitbox y
  float enemyHP; //enemy current hp
  float enemyHPMax; //enemy max hp
  int enemyTiming; //enemy timing, used for projectile shot timing
  int enemyState; //0 = normal, 1 = hurt, 2 = dead

enemy(int enemyXtemp, int enemyYtemp, int enemySpeedXtemp, int enemySpeedYtemp, int enemyTypetemp, int enemyHitXtemp, int enemyHitYtemp, float enemyHPtemp, float enemyHPMaxtemp, int enemyTimingtemp, int enemyStatetemp) {
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
}

void update() {
  enemyX = enemyX + enemySpeedX; //update enemy x pos according to speed
  enemyY = enemyY + enemySpeedY; //update enemy y pos according to speed
  if (enemyTiming < 255 && enemyState != 2) enemyTiming++; //increment enemy timer (used for timing enemy firing
  if (enemyHP <= 0) enemyState = 2; //set enemy as dead if hp is zero
  else enemyState = 0; //set enemy as alive if not dead
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
    if (enemyType == 0 && enemyState != 2) { //check to see if enemy is basic and not dead
    if (enemyTiming > 40) { //check to make sure enough time has passed since last shot
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
    float speed = 10; //higher numbers are slower
    int offsetX = 30; //account for incorrect aim, ie these values change the point of aim
    int offsetY = 10; //account for incorrect aim
    float c = sqrt((abs(playerX - enemyX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
    c = c * speed; //scale c (distance hypotenuse) to speed
    float speedX = (playerX - enemyX + offsetX);
    float speedY = (playerY - enemyY + offsetY);
    speedX = speedX / (c);
    speedY = speedY / (c);
    blts[bulletIndex] = new bullet(enemyX, enemyY, speedX, speedY, 200, 10, 10, 10);
    enemyTiming = 0;
    }
  } else if (enemyType == 1 && enemyState != 2) { //check to see if enemy is basic2 and not dead
    if (enemyTiming > 80) { //check to make sure enough time has passed since last shot
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
    blts[bulletIndex] = new bullet(enemyX, enemyY, -10, 0, 200, 50, 5, 10);
    enemyTiming = 0;
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
  if (enemyState == 0) {
    fill(255, 0, 0);
    ellipse(enemyX, enemyY, enemyHitX, enemyHitY);
  } else if (enemyState == 1) {
    fill(255, 255, 0);
    ellipse(enemyX, enemyY, enemyHitX, enemyHitY);
  } else if (enemyState == 2 && enemyTiming !=0) { //death anim
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

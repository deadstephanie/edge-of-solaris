class enemy {
  int enemyX;
  int enemyY;
  int enemySpeedX;
  int enemySpeedY;
  int enemyType;
  int enemyHitX;
  int enemyHitY;
  int enemyHP;
  int enemyTiming;

enemy(int enemyXtemp, int enemyYtemp, int enemySpeedXtemp, int enemySpeedYtemp, int enemyTypetemp, int enemyHitXtemp, int enemyHitYtemp, int enemyHPtemp, int enemyTimingtemp) {
  enemyX = enemyXtemp;
  enemyY = enemyYtemp;
  enemySpeedX = enemySpeedXtemp;
  enemySpeedY = enemySpeedYtemp;
  enemyType = enemyTypetemp;
  enemyHitX = enemyHitXtemp;
  enemyHitY = enemyHitYtemp;
  enemyHP = enemyHPtemp;
  enemyTiming = enemyTimingtemp;
}

void update() {
  enemyX = enemyX + enemySpeedX;
  enemyY = enemyY + enemySpeedY;
  if (enemyTiming < 255) enemyTiming++;
}

void collision() {
  for (int i = 0; i < bulletCount; i++) {
    if (enemyX - (enemyHitX / 2) <= blts[i].bulletX - (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((enemyX + (enemyHitX / 2)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (enemyY - (enemyHitY / 2) <= blts[i].bulletY - (blts[i].bulletHitY / 2)) {
          if ((enemyY + (enemyHitY / 2)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            if (blts[i].bulletType == 0 || blts[i].bulletType == 4) enemyType = 4;
            if (blts[i].bulletType == 0) blts[i].reset();
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
}

void hit(int bulletType) {
  //TEMP
}

void shoot() {
    if (enemyType == 0) {
    if (enemyTiming > 10) {
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
    int offsetX = 30; //account for incorraaaaaaaaaaect aim, ie these values change the point of aim
    int offsetY = 10; //account for incorrect aim
    float c = sqrt((abs(playerX - enemyX + offsetX)) + abs((playerY - enemyY + offsetY))); //solve for hypotenuse
    c = c * speed;
    float speedX = (playerX - enemyX + offsetX);
    float speedY = (playerY - enemyY + offsetY);
    speedX = speedX / (c);
    speedY = speedY / (c);
    //speedX = speedX / speed;
    //speedY = speedY / speed;
    blts[bulletIndex] = new bullet(enemyX, enemyY, speedX, speedY, 200, 10, 10);
    enemyTiming = 0;
    }
  }
}

void display() {
  strokeWeight(1);
  noStroke();
  fill(255, 0, 0);
  if (enemyType == 4) fill(0, 255, 0);
  ellipse(enemyX, enemyY, 25, 25);
}
}

class enemy {
  int enemyX;
  int enemyY;
  int enemySpeedX;
  int enemySpeedY;
  int enemyType;
  int enemyHitX;
  int enemyHitY;

enemy(int enemyXtemp, int enemyYtemp, int enemySpeedXtemp, int enemySpeedYtemp, int enemyTypetemp, int enemyHitXtemp, int enemyHitYtemp) {
  enemyX = enemyXtemp;
  enemyY = enemyYtemp;
  enemySpeedX = enemySpeedXtemp;
  enemySpeedY = enemySpeedYtemp;
  enemyType = enemyTypetemp;
  enemyHitX = enemyHitXtemp;
  enemyHitY = enemyHitYtemp;
}

void update() {
  enemyX = enemyX + enemySpeedX;
  enemyY = enemyY + enemySpeedY;
}

void collision() {
  for (int i = 0; i < playerBulletCount; i++) {
    if (enemyX - (enemyHitX / 2) <= blts[i].bulletX - (blts[i].bulletHitX / 2)) {
      //println(( enemyX + (enemyHitX / 2)) + " + " + (blts[i].bulletX +  (blts[i].bulletHitX / 2)));
      if ((enemyX + (enemyHitX / 2)) >= (blts[i].bulletX - (blts[i].bulletHitX / 2))) {
        if (enemyY - (enemyHitY / 2) <= blts[i].bulletY - (blts[i].bulletHitY / 2)) {
          if ((enemyY + (enemyHitY / 2)) >= (blts[i].bulletY - (blts[i].bulletHitY / 2))) {
            enemyType = 4;
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

void display() {
  strokeWeight(1);
  noStroke();
  fill(255, 0, 0);
  if (enemyType == 4) fill(0, 255, 0);
  ellipse(enemyX, enemyY, 25, 25);
}
}

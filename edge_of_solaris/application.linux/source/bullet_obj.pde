class bullet {
  int bulletX;
  int bulletY;
  int bulletSpeedX;
  int bulletSpeedY;
  int bulletType;
  int bulletHitX;
  int bulletHitY;

bullet(int bulletXtemp, int bulletYtemp, int bulletSpeedXtemp, int bulletSpeedYtemp, int bulletTypetemp, int bulletHitXtemp, int bulletHitYtemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
  bulletType = bulletTypetemp;
  bulletHitX = bulletHitXtemp;
  bulletHitY = bulletHitYtemp;
}

void update() {
  bulletX = bulletX + bulletSpeedX;
  bulletY = bulletY + bulletSpeedY;
}

void reset() {
  bulletX = -20;
  bulletY = -20;
  bulletSpeedX = 0;
  bulletSpeedY = 0;
  bulletType = 0;
  bulletHitX = 0;
  bulletHitY = 0;
}

void explode() {
}

void display() {
  if (bulletType == 0) {
    stroke(20, 20, 200, 120);
    strokeWeight(2);
    fill(20, 20, 200);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
  if (bulletType == 4) {
    stroke(255, 120);
    strokeWeight(10);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
}
}

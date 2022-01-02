class bullet {
  float bulletX;
  float bulletY;
  float bulletSpeedX;
  float bulletSpeedY;
  int bulletType; //255 = dead/inactive bullet, 0-199 = player bullets, 200-254 = enemy bullets
  int bulletHitX;
  int bulletHitY;

bullet(float bulletXtemp, float bulletYtemp, float bulletSpeedXtemp, float bulletSpeedYtemp, int bulletTypetemp, int bulletHitXtemp, int bulletHitYtemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
  bulletType = bulletTypetemp;
  bulletHitX = bulletHitXtemp;
  bulletHitY = bulletHitYtemp;
}

void update() {
  if (bulletX > (screenX + 100) || bulletX < -100 || bulletY > (screenY + 100) || bulletY < -100) bulletType = 255;
  else {
    bulletX = bulletX + bulletSpeedX;
    bulletY = bulletY + bulletSpeedY;
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
  else if (bulletType == 4) {
    stroke(255, 120);
    strokeWeight(10);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
  else if (bulletType == 200) {
    stroke(255, 20, 20, 120);
    strokeWeight(2);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
}
}

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

void display() {
  fill(255);
  if (bulletType == 4) fill(255, 0, 255);
  ellipse(bulletX, bulletY, 5, 5);
}
}

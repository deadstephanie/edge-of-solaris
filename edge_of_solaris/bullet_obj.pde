class bullet {
  int bulletX;
  int bulletY;
  int bulletSpeedX;
  int bulletSpeedY;

bullet(int bulletXtemp, int bulletYtemp, int bulletSpeedXtemp, int bulletSpeedYtemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
}

void update() {
  bulletX = bulletX + bulletSpeedX;
  bulletY = bulletY + bulletSpeedY;
}

void display() {
  fill(255);
  ellipse(bulletX, bulletY, 5, 5);
}

}

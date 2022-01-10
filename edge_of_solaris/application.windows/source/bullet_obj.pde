class bullet {
  float bulletX; //bullet x pos
  float bulletY; //bullet y pos
  float bulletSpeedX; //bullet x speed
  float bulletSpeedY; //bullet y speed
  int bulletType; //255 = dead/inactive bullet, 0-199 = player bullets, 200-254 = enemy bullets
  int bulletHitX; //bullet hitbox x
  int bulletHitY; //bullet hitbox y
  float bulletPower; //bullet impact damage (defined on bullet gen)

bullet(float bulletXtemp, float bulletYtemp, float bulletSpeedXtemp, float bulletSpeedYtemp, int bulletTypetemp, int bulletHitXtemp, int bulletHitYtemp, float bulletPowertemp) {
  bulletX = bulletXtemp;
  bulletY = bulletYtemp;
  bulletSpeedX = bulletSpeedXtemp;
  bulletSpeedY = bulletSpeedYtemp;
  bulletType = bulletTypetemp;
  bulletHitX = bulletHitXtemp;
  bulletHitY = bulletHitYtemp;
  bulletPower = bulletPowertemp;
}

void update() {
  if (bulletX > (screenX + 100) || bulletX < -100 || bulletY > (screenY + 100) || bulletY < -100) bulletType = 255; //destroy bullet if off screen
  else { //if bullet is not off screen, update bullet position
    bulletX = bulletX + bulletSpeedX; //update bullet x according to x speed
    bulletY = bulletY + bulletSpeedY; //update bullet y according to y speed
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
    stroke(255, 120);
    strokeWeight(2);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 4) { //snipe shot
    stroke(255, 120);
    strokeWeight(10);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  } else if (bulletType == 200) { //basic enemy shot
    stroke(20, 200, 20, 120);
    strokeWeight(2);
    fill(255);
    ellipse(bulletX, bulletY, bulletHitX, bulletHitY);
  }
}
}

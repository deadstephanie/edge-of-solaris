class starsBG {
  int starX;
  int starY;
  int starSpeedX;
  int starSpeedY;

starsBG(int starXtemp, int starYtemp, int starSpeedXtemp, int starSpeedYtemp) {
  starX = starXtemp;
  starY = starYtemp;
  starSpeedX = starSpeedXtemp;
  starSpeedY = starSpeedYtemp;
}

void update() {
  starX = starX + starSpeedX;
  starY = starY + starSpeedY;
  if (starX < 0) {
    starY = int(random(screenY));
    starX = screenX + 20;
    starSpeedX = int(-1 * (random(10) + 1));
  }
}

void reset() {
  starX = -200;
  starY = -200;
  starSpeedX = 0;
  starSpeedY = 0;
}

void display() {
  if (levelType == 0) {
  } else if (levelType == 1) {
    strokeWeight(5);
    stroke(255, 25);
    fill(255, (150 + (starSpeedX * 10)));
    ellipse(starX, starY, 60, 25);
  } else if (levelType == 2) {
    strokeWeight(5);
    stroke(255, 25);
    fill(255, (150 + (starSpeedX * 10)));
    ellipse(starX, starY, 5, 5);
  }
}
}

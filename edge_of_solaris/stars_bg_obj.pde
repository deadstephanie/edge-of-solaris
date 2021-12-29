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
    starY = int(random(500));
    starX = 700;
    starSpeedX = int(-1 * random(10));
  }
}

void display() {
  fill(255);
  ellipse(starX, starY, 5, 5);
}
}

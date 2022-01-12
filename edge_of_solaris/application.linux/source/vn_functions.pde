void drawVN() {
  image(vnPlayer1r, 0, 0, 500, 500);
  image(vnEsence1, 800, 0, 500, 500);
  strokeWeight(2);
  stroke(255);
  fill(20, 20, 255);
  rect(20, 450, 1240, 250, 20);
  rect(1150, 650, 100, 40, 5);
  rect(1040, 650, 100, 40, 5);
  textSize(48);
  fill(255);
  noStroke();
  text(textLines[textIndex], 35, 460, 1230, 250);
  textSize(32);
  text("SKIP", 1050, 680);
  text("NEXT", 1160, 680);
}

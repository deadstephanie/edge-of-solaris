void loadText() {
  String[] lines = loadStrings("assets/text/text.txt");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
    textLines[i] = lines[i];
  }
}

void loadSprites() {
  enemy1 = loadImage("assets/png/enemy/1.png");
  player1 = loadImage("assets/png/player/2.png");
}

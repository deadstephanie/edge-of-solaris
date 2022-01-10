void loadText() {
  String[] lines = loadStrings("assets/text/text.txt");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
    textLines[i] = lines[i];
  }
}

void loadSprites() {
  naturals1 = loadImage("assets/png/naturals/3-x.png");
  naturals2 = loadImage("assets/png/naturals/2-x.png");
  naturals3 = loadImage("assets/png/naturals/1-x.png");
  player1 = loadImage("assets/png/player/3.png");
}

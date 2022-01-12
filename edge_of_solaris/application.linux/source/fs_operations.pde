void loadText() {
  String[] lines = loadStrings("assets/text/script.txt");
  for (int i = 0 ; i < lines.length; i++) {
    //println(lines[i]);
    textLines[i] = lines[i];
  }
}

void loadSprites() {
  naturals1 = loadImage("assets/png/naturals/3-x.png");
  naturals2 = loadImage("assets/png/naturals/2-x.png");
  naturals3 = loadImage("assets/png/naturals/1-x.png");
  naturals4 = loadImage("assets/png/naturals/4-x.png");
  naturals5 = loadImage("assets/png/naturals/5-x.png");
  player1 = loadImage("assets/png/player/3.png");
  
  vnPlayer1 = loadImage("assets/vn/player/1.png");
  vnPlayer2 = loadImage("assets/vn/player/2.png");
  vnPlayer1r = loadImage("assets/vn/player/1-r.png");
  vnPlayer2r = loadImage("assets/vn/player/2-r.png");
  vnSol1 = loadImage("assets/vn/sol/1.png");
  vnSol2 = loadImage("assets/vn/sol/2.png");
  vnSol3 = loadImage("assets/vn/sol/3.png");
  
  vnEsence1 = loadImage("assets/vn/esence/1.png");
}

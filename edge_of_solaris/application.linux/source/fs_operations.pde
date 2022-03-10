void loadText() {
  String[] loadScript = loadStrings("assets/text/script.txt");
  String[] loadSettings = loadStrings("config.ini");
  for (int i = 0 ; i < loadScript.length; i++) {
    textLines[i] = loadScript[i];
  }
  char[] settingsChar = loadSettings[0].toCharArray();
  if (settingsChar[16] == '0') pauseOnRestart = false;
  else pauseOnRestart = true;
  
  settingsChar = loadSettings[1].toCharArray();
  if (settingsChar[13] == '0') damageOnTop = false;
  else damageOnTop = true;
}

void loadSprites() {
  naturals1 = loadImage("assets/png/naturals/3-xx.png");
  naturals2 = loadImage("assets/png/naturals/2-xx.png");
  naturals3 = loadImage("assets/png/naturals/1-xx.png");
  naturals4 = loadImage("assets/png/naturals/4-xx.png");
  naturals5 = loadImage("assets/png/naturals/5-xx.png");
  player1 = loadImage("assets/png/player/3-x.png");
  
  vnPlayer1 = loadImage("assets/vn/player/1.png");
  vnPlayer2 = loadImage("assets/vn/player/2.png");
  vnPlayer1r = loadImage("assets/vn/player/1-r.png");
  vnPlayer2r = loadImage("assets/vn/player/2-r.png");
  vnSol1 = loadImage("assets/vn/sol/1.png");
  vnSol2 = loadImage("assets/vn/sol/2.png");
  vnSol3 = loadImage("assets/vn/sol/3.png");
  
  vnEsence1 = loadImage("assets/vn/esence/1.png");
  vnEsence2 = loadImage("assets/vn/esence/2.png");
  vnEsence3 = loadImage("assets/vn/esence/3.png");
  vnEsence4 = loadImage("assets/vn/esence/4.png");
  
  vnCyana1 = loadImage("assets/vn/cyana/1.png");
  vnCyana2 = loadImage("assets/vn/cyana/2.png");
  vnCyana3 = loadImage("assets/vn/cyana/3.png");
  vnCyana4 = loadImage("assets/vn/cyana/4.png");
  
  settingsBtn = loadImage("assets/ui/settings.png");
  shadow = loadImage("assets/ui/shadow.png");
  shadow2 = loadImage("assets/ui/shadow2.png");
  shadow3 = loadImage("assets/ui/shadow3.gif");
}

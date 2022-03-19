void loadText() {
  String[] loadScript = loadStrings("assets/text/script.txt");
  //String[] loadSettings = loadUserDataFile("config.ini");
  String OS = System.getProperty("os.name").toLowerCase();
  println(OS);
  if (OS.contains("win") == false) {
    OSver = createWriter(new File("osversion-not-win.txt"));
    OSver.println("detected not windows");
    OSver.flush();
    OSver.close();
    File file = new File(userDataDir(), "settings.json");
    if (file.isFile() == true) settingsJSON = loadJSONObject(file); else settingsJSON = loadJSONObject("settings.json");
  } else {
    OSver = createWriter(new File("osversion-win.txt"));
    OSver.println("detected windows");
    OSver.flush();
    OSver.close();
    settingsJSON = loadJSONObject("settings.json");
  }
  int tempInt = settingsJSON.getInt("oneHitMode");
  if (tempInt == 1) oneHitMode = true; else oneHitMode = false;
  tempInt = settingsJSON.getInt("damageOnTop");
  if (tempInt == 1) damageOnTop = true; else damageOnTop = false;
  
  for (int i = 0; i < loadScript.length; i++) {
    textLines[i] = loadScript[i];
  }/*
  char[] settingsChar = loadSettings[0].toCharArray();
  if (settingsChar[12] == '0')
    oneHitMode = false;
  else
    oneHitMode = true;

  settingsChar = loadSettings[1].toCharArray();
  if (settingsChar[13] == '0')
    damageOnTop = false;
  else
    damageOnTop = true; */
}

String userDataDir() {
  // Default to CWD, allow overriding with '-Dsolaris.dir'
  return System.getProperty("solaris.dir", System.getProperty("user.dir"));
}

String[] loadUserDataFile(String name) {
  // Load file in the user data directory, falling back to the one in the sketch
  // directory if it does not exist yet
  final File file = new File(userDataDir(), name);
  return file.isFile() ? loadStrings(file) : loadStrings("gamesave.save");
}

void loadSave() {
  String[] loadSave = loadUserDataFile("gamesave.save");

  char[] saveChar = loadSave[0].toCharArray();
  playerHPMax = (saveChar[13] - '0') * 1000 + (saveChar[14] - '0') * 100 +
                (saveChar[15] - '0') * 10 + (saveChar[16] - '0');

  saveChar = loadSave[1].toCharArray();
  playerShieldMax = (saveChar[17] - '0') * 1000 + (saveChar[18] - '0') * 100 +
                    (saveChar[19] - '0') * 10 + (saveChar[20] - '0');

  saveChar = loadSave[2].toCharArray();
  playerDefense = ((saveChar[15] - '0') * 1000 + (saveChar[16] - '0') * 100 +
                   (saveChar[17] - '0') * 10 + (saveChar[18] - '0'));
  playerDefense = playerDefense * 0.01;

  saveChar = loadSave[3].toCharArray();
  playerAttack = ((saveChar[14] - '0') * 1000 + (saveChar[15] - '0') * 100 +
                  (saveChar[16] - '0') * 10 + (saveChar[17] - '0'));
  playerAttack = playerAttack * 0.01;
}

void saveSettings() {
  if (oneHitMode == true) settingsJSON.setInt("oneHitMode", 1); else settingsJSON.setInt("oneHitMode", 0);
  if (damageOnTop == true) settingsJSON.setInt("damageOnTop", 1); else settingsJSON.setInt("damageOnTop", 0);
  saveJSONObject(settingsJSON, "settings.json");
  /*
  settingsOut = createWriter(new File(userDataDir(), "config.ini"));
  int tempOut;
  if (oneHitMode == true)
    tempOut = 1;
  else
    tempOut = 0;
  settingsOut.println("OneHitMode: " + tempOut);
  if (damageOnTop == true)
    tempOut = 1;
  else
    tempOut = 0;
  settingsOut.println("DamageOnTop: " + tempOut);
  settingsOut.flush();
  settingsOut.close(); */
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

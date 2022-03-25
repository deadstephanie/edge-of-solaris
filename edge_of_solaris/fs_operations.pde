void loadText() {
  String[] loadScript = loadStrings("assets/text/script.txt");
  levelEndCommands = loadStrings("assets/text/level-end-commands.txt");
  /*String OS = System.getProperty("os.name").toLowerCase();
  if (OS.contains("win")) {//if windows
  //%APPDATA%/edge-of-solaris
    settingsJSON = loadJSONObject("settings.json");
  } else { //if not on windows ie linux
    file = new File("$XDG_DATA_HOME/edge-of-solaris/settings.json");
    if (file.isFile() == true) settingsJSON = loadJSONObject(file); else settingsJSON = loadJSONObject("settings.json"); //if no appdata save default to root
  }*/
  
  file = new File(userDataDir(), "settings.json");
  if (file.isFile() == true) {settingsJSON = loadJSONObject(file); useCWD = true;} else settingsJSON = loadJSONObject("settings.json");
  
  int tempInt = settingsJSON.getInt("oneHitMode");
  if (tempInt == 1) oneHitMode = true; else oneHitMode = false;
  tempInt = settingsJSON.getInt("damageOnTop");
  if (tempInt == 1) damageOnTop = true; else damageOnTop = false;
  
  for(int i = 0; i < loadScript.length; i++) {
    textLines[i] = loadScript[i]; //this is necessary trust me
    scriptLength++;
  }
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

void loadSave() { //load the player data save file
  file = new File(userDataDir(), "gamesave.json");
  if (file.isFile() == true) {gamesaveJSON = loadJSONObject(file); useCWD = true;} else gamesaveJSON = loadJSONObject("gamesave.json");
  
  playerHPMax = gamesaveJSON.getFloat("playerHPMax");
  playerShieldMax = gamesaveJSON.getFloat("playerShieldMax");
  playerDefense = gamesaveJSON.getFloat("playerDefense");
  playerAttack = gamesaveJSON.getFloat("playerAttack");
  playerMoney = gamesaveJSON.getFloat("playerMoney");
  playerXP = gamesaveJSON.getFloat("playerXP");
  playerStatPoints = gamesaveJSON.getInt("playerStatPoints");
  playerCooldown = gamesaveJSON.getFloat("playerCooldown");
  playerWeaponLevel0 = gamesaveJSON.getInt("playerWeaponLevel0");
  playerWeaponLevel1 = gamesaveJSON.getInt("playerWeaponLevel1");
  playerWeaponLevel2 = gamesaveJSON.getInt("playerWeaponLevel2");
  playerWeaponLevel4 = gamesaveJSON.getInt("playerWeaponLevel4");
  playerWeaponsUnlocked = gamesaveJSON.getInt("playerWeaponsUnlocked");
  level0Completed = gamesaveJSON.getBoolean("level0Completed");
  level1Completed = gamesaveJSON.getBoolean("level1Completed");
  
  playerLevel = (int)Math.cbrt(playerXP);
}

void saveSave() { //save the player data save file
  gamesaveJSON.setFloat("playerHPMax", playerHPMax);
  gamesaveJSON.setFloat("playerShieldMax", playerShieldMax);
  gamesaveJSON.setFloat("playerDefense", playerDefense);
  gamesaveJSON.setFloat("playerAttack", playerAttack);
  gamesaveJSON.setFloat("playerMoney", playerMoney);
  gamesaveJSON.setInt("playerStatPoints", playerStatPoints);
  gamesaveJSON.setFloat("playerCooldown", playerCooldown);
  gamesaveJSON.setInt("playerWeaponLevel0", playerWeaponLevel0);
  gamesaveJSON.setInt("playerWeaponLevel1", playerWeaponLevel1);
  gamesaveJSON.setInt("playerWeaponLevel2", playerWeaponLevel2);
  gamesaveJSON.setInt("playerWeaponLevel4", playerWeaponLevel4);
  gamesaveJSON.setInt("playerWeaponsUnlocked", playerWeaponsUnlocked);
  gamesaveJSON.setBoolean("level0Completed", level0Completed);
  gamesaveJSON.setBoolean("level1Completed", level1Completed);
  
  saveJSONObject(gamesaveJSON, "gamesave.json");
  fill(255);
  textSize(36);
  text("game saved", 975, 675);
}

void saveSettings() { //save the settings file
  if (oneHitMode == true) settingsJSON.setInt("oneHitMode", 1); else settingsJSON.setInt("oneHitMode", 0);
  if (damageOnTop == true) settingsJSON.setInt("damageOnTop", 1); else settingsJSON.setInt("damageOnTop", 0);
  
  saveJSONObject(settingsJSON, "settings.json");
}

void scanLevelEndCommands() { //scan the level end commands file
  char[] ch = levelEndCommands[levelIndex].toCharArray();
  if (ch[3] == '-' && ch[4] == 'l') { //load level
    commandIndex = (ch[6] - '0') * 10 + (ch[7] - '0'); //read the level index to load
    levelStart(commandIndex); //load the level
  } else if (ch[3] == '-' && ch[4] == 'c') { //load a menu screen
    commandIndex = (ch[6] - '0') * 10 + (ch[7] - '0'); //load the index of the screen
    screenIndex = commandIndex; //jump to that screen
  } else if (ch[3] == '-' && ch[4] == 's') { //load a 
    commandIndex = (ch[6] - '0') * 10 + (ch[7] - '0'); //jump to a script text section
    screenIndex = 3; //set screen to vn
    textIndex = scriptStartPoints[commandIndex]; //set the text index to the selected start point
  } else { //fallback
    screenIndex = 2;
  }
}

void loadSprites() { //load png assets
  faun1 = loadImage("assets/png/faun/3-xx.png");
  faun2 = loadImage("assets/png/faun/2-xx.png");
  faun3 = loadImage("assets/png/faun/1-xx.png");
  faun4 = loadImage("assets/png/faun/4-xx.png");
  faun5 = loadImage("assets/png/faun/5-xx.png");
  faun6 = loadImage("assets/png/faun/6-xx.png");
  
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
  
  vnVeda1 = loadImage("assets/vn/veda/1.png");
  vnVeda2 = loadImage("assets/vn/veda/2.png");
  vnVeda3 = loadImage("assets/vn/veda/3.png");
  vnVeda4 = loadImage("assets/vn/veda/4.png");

  settingsBtn = loadImage("assets/ui/settings.png");
  shadow = loadImage("assets/ui/shadow.png");
  shadow2 = loadImage("assets/ui/shadow2.png");
  shadow3 = loadImage("assets/ui/shadow3.gif");
  shadow4 = loadImage("assets/ui/shadow4.png");
}

void drawVN() {
  if (vnScreenChanges == true) {
  background(0);
  scanVNInfo();
  
  switch(vnInfo[textIndex][2]) { //left side vn portrait tint
    case 0:
    tint(255, 255, 255, 255);
    break;
    case 1:
    tint(255, 100);
    break;
  }
  switch(vnInfo[textIndex][0]) { //left side vn portrait image
    case 0:
    image(vnPlayer1r, 0 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 1:
    image(vnPlayer2r, 0 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 5:
    //image(vnSol1r, 0, 0, 500, 500);
    break;
    default:
    break;
  }
  switch(vnInfo[textIndex][3]) { //right side vn portrait tint
    case 0:
    tint(255, 255, 255, 255);
    break;
    case 1:
    tint(255, 100);
    break;
    default:
    break;
  }
  switch(vnInfo[textIndex][1]) { //right side vn portrait image
    case 0:
    image(vnPlayer1, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 1:
    image(vnPlayer2, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 5:
    image(vnSol1, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 10:
    image(vnEsence1, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 11:
    image(vnEsence2, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 12:
    image(vnEsence3, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 13:
    image(vnEsence4, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 20:
    image(vnCyana1, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 21:
    image(vnCyana2, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 22:
    image(vnCyana3, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 23:
    image(vnCyana4, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 30:
    image(vnVeda1, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 31:
    image(vnVeda2, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 32:
    image(vnVeda3, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    case 33:
    image(vnVeda4, 800 * screenScaling, 0 * screenScaling, 500 * screenScaling, 500 * screenScaling);
    break;
    default:
    break;
  }
  tint(255, 255, 255, 255); //reset image tint
  
  strokeWeight(2);
  stroke(255);
  fill(20, 20, 255);
  rect(20 * screenScaling, 450 * screenScaling, 1240 * screenScaling, 250 * screenScaling, 20);
  rect(1150 * screenScaling, 650 * screenScaling, 100 * screenScaling, 40 * screenScaling, 5);
  rect(1040 * screenScaling, 650 * screenScaling, 100 * screenScaling, 40 * screenScaling, 5);
  textSize(48 * screenScaling);
  fill(255);
  noStroke();
  text(textLinesO[textIndex - 1], 35 * screenScaling, 460 * screenScaling, 1230 * screenScaling, 250 * screenScaling);
  textSize(26 * screenScaling);
  text("SKIP (Y)", 1045 * screenScaling, 680 * screenScaling);
  text("NEXT (A)", 1153 * screenScaling, 680 * screenScaling);
  
  vnScreenChanges = false; //finished rendering frame, do not render again unless changes to frame occur
  }
}

void scanVNCommands() { //looks for commands in the script text, this is run when text is advanced
  char[] ch = textLines[textIndex-1].toCharArray();
  if (ch[0] == '-' && ch[1] == 'l') { //load level
    commandIndex = (ch[3] - '0') * 10 + (ch[4] - '0'); //read the level index to load
    levelStart(commandIndex);
  } else if (ch[0] == '-' && ch[1] == 's') { //text start point
    textIndex++; //advance text to skip past start point line
  } else if (ch[0] == '-' && ch[1] == 'c') { //load a menu screen command
    commandIndex = (ch[3] - '0') * 10 + (ch[4] - '0'); //jump to menu screen
    screenIndex = commandIndex;
  } else if (ch[3] == '-' && ch[4] == 'a') { //load a new area (jump to level select)
    commandIndex = (ch[6] - '0') * 10 + (ch[7] - '0'); //jump to a script text section
    screenIndex = 2; //set screen to level select
    areaIndex = commandIndex; //set area to selected area
  }
}

void scanForStartPoints() {
  int index = 0; //used to increment the start points array, ie 0 would be the first start point, note the text after -s does not matter only the order in the file they appear
  for (int i = 0; i < scriptLength; i++) {
    char[] ch = textLines[i].toCharArray();
    if (ch[0] == '-' && ch[1] == 's') { //text blurb start point
      scriptStartPoints[index] = i+1+1; //textLines is a 1 incremented array, add another 1 so it starts the line after the start point line
      index++;
    }
  }
}

void advanceVNText() { //moves vn forward, reads commands, etc
  textIndex++; //advance the text script
  scanVNCommands();
  vnScreenChanges = true; //trigger a new vn frame rendering
  keyInput[4] = false; //release space key
}

void skipVNText() { //when user wants to skip text, always on for always skip text mode
  while (screenIndex == 3) { //repeat until screen index is not vn
    advanceVNText(); //advance text one line
  } //this will likely crash the game if there is not a command at the end of the text segment (ie it would run out of text lines)
}

void scanVNInfo() { //scans the script text for the vn portrait info
  char[] ch = textLines[textIndex-1].toCharArray();
  if (ch[0] != '-') { //ensure line is not a command
    vnInfo[textIndex][0] = (ch[0] - '0') * 10 + (ch[1] - '0'); //left vn portrait
    vnInfo[textIndex][1] = (ch[3] - '0') * 10 + (ch[4] - '0'); //right vn portrait
    vnInfo[textIndex][4] = (ch[6] - '0'); //tint, who is 
    
    //translate into vnInfo format that is used in drawVN
    if (vnInfo[textIndex][4] == 0) { //left side talking
    vnInfo[textIndex][2] = 0;
    vnInfo[textIndex][3] = 1;
  } else if (vnInfo[textIndex][4] == 1) { //right side talking
    vnInfo[textIndex][2] = 1;
    vnInfo[textIndex][3] = 0;
  } else if (vnInfo[textIndex][4] == 2) { //no one talking
    vnInfo[textIndex][2] = 1;
    vnInfo[textIndex][3] = 1;
  }
  
  char[] chStripped = new char[ch.length-7]; //makes a new char array for text stripping
  for(int i = 7; i < ch.length; i++) { //strips the first 7 chars
    chStripped[i-7] = ch[i];
  }
  textLinesO[textIndex-1] = String.valueOf(chStripped); //dumps the char into a string
} else textLinesO[textIndex-1] = "this line is a command [error]";
}

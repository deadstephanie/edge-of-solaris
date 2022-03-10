void drawVN() {
  scanVNInfo();
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
    image(vnPlayer1r, 0, 0, 500, 500);
    break;
    case 1:
    image(vnPlayer2r, 0, 0, 500, 500);
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
    image(vnPlayer1, 800, 0, 500, 500);
    break;
    case 1:
    image(vnPlayer2, 800, 0, 500, 500);
    break;
    case 5:
    image(vnSol1, 800, 0, 500, 500);
    break;
    case 10:
    image(vnEsence1, 800, 0, 500, 500);
    break;
    case 11:
    image(vnEsence2, 800, 0, 500, 500);
    break;
    case 12:
    image(vnEsence3, 800, 0, 500, 500);
    break;
    case 13:
    image(vnEsence4, 800, 0, 500, 500);
    break;
    case 20:
    image(vnCyana1, 800, 0, 500, 500);
    break;
    case 21:
    image(vnCyana2, 800, 0, 500, 500);
    break;
    case 22:
    image(vnCyana3, 800, 0, 500, 500);
    break;
    case 23:
    image(vnCyana4, 800, 0, 500, 500);
    break;
    default:
    break;
  }
  tint(255, 255, 255, 255); //reset image tint
  
  strokeWeight(2);
  stroke(255);
  fill(20, 20, 255);
  rect(20, 450, 1240, 250, 20);
  rect(1150, 650, 100, 40, 5);
  rect(1040, 650, 100, 40, 5);
  textSize(48);
  fill(255);
  noStroke();
  text(textLinesO[textIndex - 1], 35, 460, 1230, 250);
  textSize(32);
  text("SKIP", 1050, 680);
  text("NEXT", 1160, 680);
}

int scanVNCommands() { //looks for commands in the script text, this is run when text is advanced
  char[] ch = textLines[textIndex-1].toCharArray();
  if (ch[0] == '-' && ch[1] == 'l') { //load level
    commandIndex = (ch[3] - '0') * 10 + (ch[4] - '0');
    println(commandIndex);
    return 0; //the command to load a level
  }
  return 255;
}

void scanVNInfo() { //scans the script text for the vn portrait info
  char[] ch = textLines[textIndex-1].toCharArray();
  if (ch[0] != '-') { //ensure line is not a command
    vnInfo[textIndex][0] = (ch[0] - '0') * 10 + (ch[1] - '0'); //left vn portrait
    vnInfo[textIndex][1] = (ch[3] - '0') * 10 + (ch[4] - '0'); //right vn portrait
    vnInfo[textIndex][4] = (ch[6] - '0'); //tint, who is talking
  }
  char[] chStripped = new char[ch.length-7]; //makes a new char array for text stripping
  for(int i = 7; i < ch.length; i++) { //strips the first 7 chars
    chStripped[i-7] = ch[i];
  }
  textLinesO[textIndex-1] = String.valueOf(chStripped); //dumps the char into a string
}

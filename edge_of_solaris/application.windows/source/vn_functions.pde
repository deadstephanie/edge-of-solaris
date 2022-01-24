void drawVN() {
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
  text(textLines[textIndex - 1], 35, 460, 1230, 250);
  textSize(32);
  text("SKIP", 1050, 680);
  text("NEXT", 1160, 680);
}

void fillvnInfo() {
  vnInfo[1][0] = 0;
  vnInfo[1][1] = 10;
  vnInfo[1][2] = 1;
  vnInfo[1][3] = 0;
  
  vnInfo[2][0] = 0;
  vnInfo[2][1] = 10;
  vnInfo[2][2] = 0;
  vnInfo[2][3] = 1;
  
  vnInfo[3][0] = 0;
  vnInfo[3][1] = 11;
  vnInfo[3][2] = 1;
  vnInfo[3][3] = 0;
  
  vnInfo[4][0] = 0;
  vnInfo[4][1] = 10;
  vnInfo[4][2] = 1;
  vnInfo[4][3] = 0;
  
  vnInfo[5][0] = -1;
  vnInfo[5][1] = -1;
  vnInfo[5][2] = 0;
  vnInfo[5][3] = 0;
  
  vnInfo[6][0] = 1;
  vnInfo[6][1] = 10;
  vnInfo[6][2] = 0;
  vnInfo[6][3] = 1;
  
  vnInfo[7][0] = 0;
  vnInfo[7][1] = 11;
  vnInfo[7][2] = 1;
  vnInfo[7][3] = 0;
  
  vnInfo[8][0] = 0;
  vnInfo[8][1] = 10;
  vnInfo[8][2] = 1;
  vnInfo[8][3] = 0;
  
  vnInfo[9][0] = 1;
  vnInfo[9][1] = -1;
  vnInfo[9][2] = 0;
  vnInfo[9][3] = 0;
  
  vnInfo[11][0] = 0;
  vnInfo[11][1] = 10;
  vnInfo[11][2] = 1;
  vnInfo[11][3] = 0;
  
  vnInfo[12][0] = 0;
  vnInfo[12][1] = 13;
  vnInfo[12][2] = 1;
  vnInfo[12][3] = 0;
  
  vnInfo[13][0] = 1;
  vnInfo[13][1] = -1;
  vnInfo[13][2] = 0;
  vnInfo[13][3] = 0;
  
  vnInfo[14][0] = 1;
  vnInfo[14][1] = -1;
  vnInfo[14][2] = 0;
  vnInfo[14][3] = 0;
}

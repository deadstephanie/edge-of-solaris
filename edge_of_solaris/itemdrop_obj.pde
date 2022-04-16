class item {
  float itemX;
  float itemY;
  float itemHitX;
  float itemHitY;
  float itemValue;
  int itemType; //0 = money, 255 = dead
  int itemTimer;
  
  item(float itemXtemp, float itemYtemp, float itemHitXtemp, float itemHitYtemp, float itemValuetemp, int itemTypetemp, int itemTimertemp) {
    itemX = itemXtemp;
    itemY = itemYtemp;
    itemHitX = itemHitXtemp;
    itemHitY = itemHitYtemp;
    itemValue = itemValuetemp;
    itemType = itemTypetemp;
    itemTimer = itemTimertemp;
  }
  
  void update() {
    if (itemType != 255) {
      itemTimer++;
      itemX = itemX + autoScroll;
    }
  }
  
  void display() {
    if (itemType == 0) { //money
      strokeWeight(2);
      stroke(0); 
      fill(228, 235, 33);
      ellipse(itemX * screenScaling, itemY * screenScaling, itemHitX * screenScaling, itemHitY * screenScaling);
    } 
  }
  
  void reset() {
    itemX = -200;
    itemY = -200;
    itemHitX = 0;
    itemHitY = 0;
    itemValue = 0;
    itemType = 255;
    itemTimer = 0;
  }
}

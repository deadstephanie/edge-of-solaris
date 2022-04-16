class damage {
  float damageX;
  float damageY;
  float damage;
  int damageType; //0 = enemy take dmg, 1 = player take dmg, 2 = crit on enemy, 3 = super crit, 4 = money collect from item
  int damageTimer; //set on creation of obj, when it reaches 0 damage is dead
  
  damage(float damageXtemp, float damageYtemp, float damagetemp, int damageTypetemp, int damageTimertemp) {
    damageX = damageXtemp;
    damageY = damageYtemp;
    damage = damagetemp;
    damageType = damageTypetemp;
    damageTimer = damageTimertemp;
  }
  
  void update() {
    if (damageTimer != 0) { //as long as damage isnt dead
      damageTimer--;
      damageY--;
    }
  }
  
  void display() {
    if (damageTimer != 0) { //when timer runs out damage is dead
      if (damageType == 0) { //enemy dmg
        int fade = damageTimer * 8;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(24 * screenScaling);
        fill(255, 20, 20, fade);
        text(damage * screenScaling, damageX * screenScaling, damageY * screenScaling);
      } else if (damageType == 1) { //player dmg
        int fade = damageTimer * 8;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(24 * screenScaling);
        fill(200, 20, 255, fade);
        text(damage * screenScaling, damageX * screenScaling, damageY * screenScaling);
      }  else if (damageType == 2) { //player crit on enemy
        int fade = damageTimer * 7;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(36 * screenScaling);
        fill(255, 0, 0, fade);
        text(damage * screenScaling, damageX * screenScaling, damageY * screenScaling);
      } else if (damageType == 3) { //player super crit on enemy
        int fade = damageTimer * 5;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(48 * screenScaling);
        fill(255, 0, 0, fade);
        text(damage * screenScaling, damageX * screenScaling, damageY * screenScaling);
      } else if (damageType == 4) { //money
        int fade = damageTimer * 5;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(24 * screenScaling);
        fill(220, 255, 25, fade);
        text(damage * screenScaling, damageX * screenScaling, damageY * screenScaling);
      }
    }
  }
  
  void reset() {
    damageX = -200;
    damageY = -200;
    damage = 0;
    damageType = 255;
    damageTimer = 0;
  }
}

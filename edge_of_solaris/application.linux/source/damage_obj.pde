class damage {
  float damageX;
  float damageY;
  float damage;
  int damageType;
  int damageTimer;
  
  damage(float damageXtemp, float damageYtemp, float damagetemp, int damageTypetemp, int damageTimertemp) {
    damageX = damageXtemp;
    damageY = damageYtemp;
    damage = damagetemp;
    damageType = damageTypetemp;
    damageTimer = damageTimertemp;
  }
  
  void update() {
    if (damageTimer != 0) {
      damageTimer--;
      damageY--;
    }
  }
  
  void display() {
    if (damageTimer != 0) {
      if (damageType == 0) {
        int fade = damageTimer * 8;
        if (fade > 255) fade = 255;
        noStroke();
        textSize(24);
        fill(255, 20, 20, fade);
        text(damage, damageX, damageY);
      }
    }
  }
  
  void reset() {
    damageX = -200;
    damageY = -200;
    damage = 0;
    damageType = 0;
    damageTimer = 0;
  }
}

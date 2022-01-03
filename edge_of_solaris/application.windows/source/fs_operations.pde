void loadText() {
  String[] lines = loadStrings("text.txt");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
    textLines[i] = lines[i];
  }
}

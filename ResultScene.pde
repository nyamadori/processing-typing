class ResultScene extends Scene {
  PFont titleTextFont;
  PFont promptFont;
  
  public ResultScene() {
    this.titleTextFont = createFont("AvenirNext-Regular", 64);
    this.promptFont = createFont("AvenirNext-Regular", 24);
  }
  
  public void draw() {
    background(0);
    noStroke();

    textAlign(CENTER, CENTER);
    textFont(titleTextFont);
    text("Finished!", width / 2, height / 2);
    textFont(promptFont);
    text("Press any key to return title...", width / 2, height / 2 + 82);
  }
  
  public void keyPressed(int keyCode) {
    transition(new TitleScene());
  }
}
class TitleScene extends Scene {
  PFont titleFont;
  PFont promptFont;
  
  public TitleScene() {
    this.titleFont = createFont("AvenirNext-Regular", 64); 
    this.promptFont = createFont("AvenirNext-Regular", 24);
  }
  
  public void draw() {
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    background(0);
    fill(255);
    text("Typing Game", width / 2, height / 2);
    textFont(promptFont);
    text("Press any key to start...", width / 2, height / 2 + 82);
  }
  
  public void keyPressed(int keyCode) {
    transition(new TypingScene());
  }
}
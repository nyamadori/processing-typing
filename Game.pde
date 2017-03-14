class Game {
  Scene current, nextCurrent;
  boolean eventProcessing;

  public Game(Scene init) {
    transition(init);
  }
  
  public void transition(Scene scene) {
    if (eventProcessing) {
      nextCurrent = scene;
    } else {
      current = scene;
    }

    scene.game = this;
  }
  
  public void draw() {
    current.draw();
  }
  
  public void keyTyped() {
    this.eventProcessing = true;
    current.keyTyped(str(key));
  }
  
  public void keyPressed() {
    this.eventProcessing = true;
    current.keyPressed(keyCode);
  }
  
  public void keyReleased() {
    current.keyReleased(keyCode);
    this.eventProcessing = false;

    if (nextCurrent != null) {
      current = nextCurrent;
      nextCurrent = null;
    }
  }
}
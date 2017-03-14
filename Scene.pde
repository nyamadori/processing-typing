class Scene {
  Game game;
  
  public void draw() {}
  public void keyTyped(String alphabet) {}
  public void keyPressed(int keyCode) {}
  public void keyReleased(int keyCode) {}
  public void transition(Scene scene) {
    game.transition(scene);
  }
}
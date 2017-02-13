public class Particle {
  float x, y, w, h, strokeWeight;
  color fillColor;
  color strokeColor;
  
  public void setup() {
    fill(fillColor);
    stroke(strokeColor);
    strokeWeight(strokeWeight);
  }
}
public class Game {
  private Problem[] problems;
  private int index;
  private RomanParser parser;
  private PFont displayTextFont, romanTextFont;

  public Game(Problem[] problems, RomanTable romanTable) {
    this.problems = problems;
    this.parser = new RomanParser(romanTable);
    this.index = 0;
    next();

    displayTextFont = createFont("ヒラギノ明朝 ProN W3", 48);
    romanTextFont = createFont("AvenirNext-Regular", 32);
  }
  
  public boolean isFinished() {
    return this.index >= this.problems.length;
  }
  
  public void reset() {
    this.index = 0;
  }
  
  public void draw() {
    background(0);
    drawParticles();
    drawProblem();
  }
  
  protected void drawParticles() {
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(random(0, width), random(0, height), 10, 10);
  }
  
  protected void drawProblem() {
    fill(255);
    textFont(displayTextFont);
    text(parser.problem.displayText, 100, 80);
    
    textFont(romanTextFont);
    float acceptedRomanTextWidth = textWidth(parser.acceptedRomanText());
    fill(100);
    text(parser.acceptedRomanText(), 100, 120);
    fill(255);
    text(parser.remainRomanText(), 100 + acceptedRomanTextWidth, 120);
  }
  
  public void input(String alphabet) {
    parser.input(alphabet);

    if (parser.isFinished()) next();
  }
  
  public void next() {
    if (isFinished()) {
      println("Game clear");
    } else {
      parser.setProblem(problems[index++]);
    }
  }
  
  public Problem currentProblem() {
    return this.problems[index];
  }
}
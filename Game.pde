public class Game {
  private ProblemSet problems;
  private int index;
  private RomanParser parser;
  private PFont displayTextFont, romanTextFont;
  private List<Particle> particles;

  public Game(ProblemSet problems, RomanTable romanTable) {
    this.problems = problems;
    this.parser = new RomanParser(romanTable);
    this.index = 0;
    next();

    displayTextFont = createFont("ヒラギノ明朝 ProN W3", 48);
    romanTextFont = createFont("AvenirNext-Regular", 32);

    particles = new ArrayList<Particle>();
  }

  public boolean isFinished() {
    return this.index >= this.problems.size();
  }

  public void reset() {
    this.index = 0;
  }

  public void draw() {
    background(0);
    noStroke();
    drawParticles();
    drawProblem();
  }

  public void input(String alphabet) {
    parser.input(alphabet);
    createParticle();

    if (parser.isFinished()) next();
  }

  public void next() {
    if (isFinished()) {
      println("Game clear");
    } else {
      parser.setProblem(problems.get(index++));
    }
  }

  public Problem currentProblem() {
    return this.problems.get(index);
  }


  protected void drawParticles() {    
    for (Particle particle : particles) {
      particle.fillColor =
        color(red(particle.fillColor), 
        green(particle.fillColor), 
        blue(particle.fillColor), 
        alpha(particle.fillColor) - 10);
      particle.setup();
      ellipse(particle.x, particle.y, particle.w, particle.h);
    }
  }

  protected void drawProblem() {
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(displayTextFont);
    text(parser.problem.displayText, width / 2, height / 2);

    textAlign(LEFT, CENTER);
    textFont(romanTextFont);

    float romanTextWidth = textWidth(parser.acceptedRomanText() + parser.remainRomanText());
    float romanTextLeft = (width - romanTextWidth) / 2;
    float acceptedRomanTextWidth = textWidth(parser.acceptedRomanText());
    fill(100);
    text(parser.acceptedRomanText(), romanTextLeft, height / 2 + 40);
    fill(255);
    text(parser.remainRomanText(), romanTextLeft + acceptedRomanTextWidth, height / 2 + 40);
  }

  protected void createParticle() {
    Particle particle = new Particle();
    colorMode(HSB);
    int h = (int)random(0, 255);
    int s = (int)random(200, 255);
    int b = (int)random(255, 255);

    particle.fillColor = color(h, s, b);
    colorMode(RGB);
    particle.x = random(100, width - 100);
    particle.y = random(100, height - 100);
    particle.w = random(20, 100);
    particle.h = particle.w;
    particles.add(particle);
  }
}
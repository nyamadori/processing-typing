Game game;

void setup() {
  size(800, 600);

  //Problem[] problems = {
  //  new Problem("東京特許許可局", "とうきょうとっきょきょかきょく"),
  //  new Problem("彼はよく柿喰う客だ", "かれはよくかきくうきゃくだ"),
  //  new Problem("ダチョウ", "だちょう"),
  //  new Problem("梅干し", "うめぼし"),
  //  new Problem("正直者", "しょうじきもの"),
  //  new Problem("農業", "のうぎょう"),
  //  new Problem("憂鬱", "ゆううつ"),
  //  new Problem("積み木", "つみき")
  //};
  
  ProblemSet problems = new ProblemSet();
  problems.loadFromFile("problems.txt");
  
  RomanTable romanTable = new RomanTable();
  romanTable.loadFromFile("romantable.txt");

  game = new Game(problems, romanTable);
}

void draw() {
  game.draw();
}

void keyTyped() {
  game.input(str(key));
}
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
public class Particle {
  float x, y, w, h, strokeWeight;
  color fillColor;
  color strokeColor;
  
  public void setup() {
    fill(fillColor);
    stroke(strokeColor);
    //strokeWeight(strokeWeight);
  }
}
class Problem {
  public String kanaText;
  public String displayText;
  
  public Problem(String displayText, String kanaText) {
    this.displayText = displayText;
    this.kanaText = kanaText;
  }
}
import java.util.AbstractList;
import java.util.Collections;

public class ProblemSet extends AbstractList<Problem> {
  private List<Problem> problems;
  
  public ProblemSet() {
    this.problems = new ArrayList<Problem>();
  }
  
  public void loadFromFile(String path) {
    String[] lines = loadStrings(path);
    
    for (String line : lines) {
      String[] fields = line.split("\t");
      
      add(new Problem(fields[0], fields[1]));
    }
  }
  
  public Problem get(int index) {
    return problems.get(index);
  }
  
  public int size() {
    return problems.size();
  }
  
  public void shuffle() {
    Collections.shuffle(problems);
  }
}
public class Roman {
  String input;
  String output;
  String nextInput;
  
  public Roman(String input, String output, String nextInput) {
    this.input = input;
    this.output = output;
    this.nextInput = nextInput;
  }
  
  public String toString() {
    return "[" + input + ", " + output + ", " + nextInput + "]";
  }
}
import java.util.Map;
import java.util.List;

public class RomanParser {
  public RomanTable romanTable;
  public Problem problem;
  private int pos;
  private String pendingRoman;
  private String _acceptedRomanText;
  
  public RomanParser(RomanTable romanTable) {
    this.romanTable = romanTable;
  }

  public void setProblem(Problem problem) {
    this.problem = problem;
    this.pos = 0;
    this.pendingRoman = "";
    this._acceptedRomanText = "";
  }

  public String currentKanaText() {
    return problem.kanaText.substring(pos);
  }

  public boolean isFinished() {
    return this.problem.kanaText.length() <= this.pos;
  }

  public List<Roman> match(String alphabet, int pos) {
    List<Roman> matches = new ArrayList<Roman>();
    String newPendingRoman = this.pendingRoman.concat(alphabet);
    String kanaText = problem.kanaText.substring(pos);
 
    if (isFinished()) return matches;

    for (Roman roman : romanTable) {
      if (roman.input.startsWith(newPendingRoman) && kanaText.startsWith(roman.output)) {
        matches.add(roman);
      }
    }
    
    return matches;
  }

  public boolean input(String alphabet) {
    String newPendingRoman = this.pendingRoman.concat(alphabet);
    List<Roman> matches = this.match(alphabet, pos);

    if (matches.size() == 0) return false;
    Roman match = matches.get(0);
 
    if (matches.size() == 1 && match.input.equals(newPendingRoman)) {
      if (match.nextInput == null) {
        this.pendingRoman = "";
      } else {
        this.pendingRoman = match.nextInput;
      }

      this.pos += match.output.length();
    } else {
      this.pendingRoman = newPendingRoman;
    }
    
    this._acceptedRomanText += alphabet; 

    return true;
  }
  
  public String remainRomanText() {
    String kanaText = this.currentKanaText();
    String romanText = "";
    
    while (kanaText.length() > 0) {
      List<Roman> matches = romanTable.getStartsWithOutputText(kanaText);
      List<Roman> candidates = new ArrayList<Roman>();
      
      for (Roman match : matches) {        
        if (match.nextInput != null) {
          List<Roman> nextMatches = romanTable.getStartsWithOutputText(kanaText.substring(1, 2));

          for (Roman m : nextMatches) {
            if (m.input.startsWith(match.nextInput)) {
              candidates.add(match);
              break;
            }
          }
        } else {
          candidates.add(match);
        }
      }
      
      Roman match = null;
      
      if (candidates.size() > 0) {
        match = candidates.get(0);
      } else {
        match = new Roman(kanaText.substring(0, 1), kanaText.substring(0, 1), "");
      }
      String targetKana = match.output;
      String roman = match.input;

      if (match.nextInput != null) roman = roman.substring(0, roman.length() - 1);
      if (candidates.size() > 0) {
        romanText = romanText.concat(roman);
        kanaText = kanaText.substring(targetKana.length());
      } else {
        break;
      }
    }

    return romanText.substring(pendingRoman.length());
  }
  
  public String acceptedRomanText() {
    return this._acceptedRomanText; 
  }
}
import java.util.Iterator;

public class RomanTable implements Iterable<Roman> {
  private List<Roman> table;

  public RomanTable() {
    this.table = new ArrayList<Roman>();
  }
  
  public void add(String input, String output, String nextInput) {
    this.table.add(new Roman(input, output, nextInput));
  }
  
  public Roman getFromInput(String input) {
    for (Roman roman : table) {
      if (roman.input.equals(input)) return roman;
    }
    
    return null;
  }

  public List<Roman> getFromOutput(String output) {
    List<Roman> romans = new ArrayList<Roman>();
    
    for (Roman roman : table) {
      if (roman.output.equals(output)) romans.add(roman);
    }
    
    return romans;
  }
  
  public List<Roman> getStartsWithInput(String input) {
    List<Roman> romans = new ArrayList<Roman>();
    
    for (Roman roman : table) {
      if (roman.input.startsWith(input)) romans.add(roman);
    }
    
    return romans;
  }
  
  public List<Roman> getStartsWithOutput(String output) {
    List<Roman> romans = new ArrayList<Roman>();
    
    for (Roman roman : table) {
      if (roman.output.startsWith(output)) romans.add(roman);
    }
    
    return romans;
  }
  
  public List<Roman> getStartsWithOutputText(String outputText) {
    List<Roman> romans = new ArrayList<Roman>();
    
    for (Roman roman : table) {
      if (outputText.startsWith(roman.output)) romans.add(roman);
    }
    
    return romans;
  }
  
  public void loadFromFile(String path) {
    String[] rows = loadStrings(path);
    
    for (String row : rows) {
      String[] fields = row.split("\t");
      
      String input = fields[0];
      String output = fields[1];
      String nextInput = fields[2];
      this.add(input, output, nextInput);
    }
  }
  
  public Iterator<Roman> iterator() {
    return this.table.iterator();
  }
}

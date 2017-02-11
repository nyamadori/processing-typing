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
    List<Roman> matches = match(alphabet, pos);

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
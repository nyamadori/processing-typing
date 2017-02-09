import java.util.Map;
import java.util.List;

Map<String, String[]> romanTable = new HashMap<String, String[]>();
Map<String, String> romanInvTable = new HashMap<String, String>();

public class RomanParser {
  public Map<String, String[]> romanTable;
  public Map<String, String> romanTableInv;
  public Problem problem;
  private int pos;
  private String pendingRoman;
  private String _acceptedRomanText;
  
  public RomanParser(Map<String, String[]> romanTable, Problem problem) {
    this.romanTable = romanTable;
    this.problem = problem;
    this.pos = 0;
    this.pendingRoman = "";
    this.romanTableInv = new HashMap<String, String>();
    this._acceptedRomanText = "";
    
    for (Map.Entry<String, String[]> entry : romanTable.entrySet()) {
      for (String roman : entry.getValue()) {
        romanTableInv.put(roman, entry.getKey());
      }
    }
  }

  public String currentKanaText() {
    return problem.kanaText.substring(pos);
  }

  public boolean isFinished() {
    return this.problem.kanaText.length() <= this.pos;
  }

  public List<Match> match(String alphabet, int pos) {
    List<Match> matches = new ArrayList<Match>();
    String newPendingRoman = this.pendingRoman.concat(alphabet);
    String kanaText = problem.kanaText.substring(pos);
 
    if (isFinished()) return matches;
    
    if (str(kanaText.charAt(0)).equals("っ")) {
      for (Map.Entry<String, String> entry : romanTableInv.entrySet()) {
        String roman = entry.getKey();
        String doubleRoman = str(roman.charAt(0)) + roman;
        String kana = "っ" + entry.getValue();
  
        if (doubleRoman.startsWith(newPendingRoman) && kanaText.startsWith(kana)) {
          matches.add(new Match(doubleRoman, kana));
        }
      }
    }
    
    for (Map.Entry<String, String> entry : romanTableInv.entrySet()) {
      String roman = entry.getKey();
      String kana = entry.getValue();

      if (roman.startsWith(newPendingRoman) && kanaText.startsWith(kana)) {
        matches.add(new Match(roman, kana));
      }
    }
    
    return matches;
  }

  public boolean input(String alphabet) {
    String newPendingRoman = this.pendingRoman.concat(alphabet);
    List<Match> matches = match(alphabet, pos);

    if (matches.size() == 0) {
      return false;
    } else if (matches.size() == 1 && matches.get(0).roman.equals(newPendingRoman)) {
      this.pendingRoman = "";
      this.pos += matches.get(0).kana.length();
    } else {
      this.pendingRoman = newPendingRoman;
    }
    
    this._acceptedRomanText += alphabet; 

    return true;
  }
  
  protected String[] getKanaCandidates(String kanaText) {
    List<String> candidates = new ArrayList<String>();
    
    for (Map.Entry<String, String[]> entry : romanTable.entrySet()) {
      String targetKana = entry.getKey();

      if (kanaText.startsWith(targetKana)) {
        candidates.add(targetKana);
      }
    }
    
    return candidates.toArray(new String[0]);
  }
  
  public String remainRomanText() {
    String kanaText = this.currentKanaText();
    String romanText = "";
    
    while (kanaText.length() > 0) {
      String[] kanaCandidates = getKanaCandidates(kanaText);

      String targetKana = kanaCandidates[0];
      String roman = romanTable.get(targetKana)[0];

      if (kanaCandidates.length > 0) {
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
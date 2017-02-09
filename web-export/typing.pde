
Problem[] problems = {
  new Problem("東京特許許可局", "とうきょうとっきょきょかきょく"),
  new Problem("彼はよく柿食う客だ", "かれはよくかきくうきゃくだ")
};
Map<String, String[]> romanTable = new HashMap<String, String[]>();
Map<String, String> romanInvTable = new HashMap<String, String>();
RomanParser parser;

void setup() {
  size(800, 600);
  romanTable.put("きゃ", new String[] {"kya"});
  romanTable.put("きぃ", new String[] {"kyi"});
  romanTable.put("きゅ", new String[] {"kyu"});
  romanTable.put("きぇ", new String[] {"kye"});
  romanTable.put("きょ", new String[] {"kyo"});
  romanTable.put("しゃ", new String[] {"sya", "sha"});
  romanTable.put("しぃ", new String[] {"syi"});
  romanTable.put("しゅ", new String[] {"syu", "shu"});
  romanTable.put("しぇ", new String[] {"sye", "she"});
  romanTable.put("しょ", new String[] {"syo", "sho"});
  romanTable.put("ちゃ", new String[] {"tya"});
  romanTable.put("ちぃ", new String[] {"tyi", "cyi"});
  romanTable.put("ちゅ", new String[] {"tyu", "chu", "cyu"});
  romanTable.put("ちぇ", new String[] {"tye", "che", "cye"});
  romanTable.put("ちょ", new String[] {"tyo", "cho", "cyo"});
  romanTable.put("にゃ", new String[] {"nya"});
  romanTable.put("にぃ", new String[] {"nyi"});
  romanTable.put("にゅ", new String[] {"nyu"});
  romanTable.put("にぇ", new String[] {"nye"});
  romanTable.put("にょ", new String[] {"nyo"});
  romanTable.put("ひゃ", new String[] {"hya"});
  romanTable.put("ひぃ", new String[] {"hyi"});
  romanTable.put("ひゅ", new String[] {"hyu"});
  romanTable.put("ひぇ", new String[] {"hye"});
  romanTable.put("ひょ", new String[] {"hyo"});
  romanTable.put("みゃ", new String[] {"mya"});
  romanTable.put("みぃ", new String[] {"myi"});
  romanTable.put("みゅ", new String[] {"myu"});
  romanTable.put("みぇ", new String[] {"mye"});
  romanTable.put("みょ", new String[] {"myo"});

  romanTable.put("ぎゃ", new String[] {"gya"});
  romanTable.put("ぎぃ", new String[] {"gyi"});
  romanTable.put("ぎゅ", new String[] {"gyu"});
  romanTable.put("ぎぇ", new String[] {"gye"});
  romanTable.put("ぎょ", new String[] {"gyo"});
  romanTable.put("じゃ", new String[] {"jya", "ja"});
  romanTable.put("じぃ", new String[] {"jyi", "ji"});
  romanTable.put("じゅ", new String[] {"jyu", "ju"});
  romanTable.put("じぇ", new String[] {"jye", "je"});
  romanTable.put("じょ", new String[] {"jyo", "jo"});
  romanTable.put("ぢゃ", new String[] {"dya"});
  romanTable.put("ぢぃ", new String[] {"dyi"});
  romanTable.put("ぢゅ", new String[] {"dyu"});
  romanTable.put("ぢぇ", new String[] {"dye"});
  romanTable.put("ぢょ", new String[] {"dyo"});
  romanTable.put("びゃ", new String[] {"pya"});
  romanTable.put("びぃ", new String[] {"pyi"});
  romanTable.put("びゅ", new String[] {"pyu"});
  romanTable.put("びぇ", new String[] {"pye"});
  romanTable.put("びょ", new String[] {"pyo"});
  romanTable.put("ぴゃ", new String[] {"pya"});
  romanTable.put("ぴぃ", new String[] {"pyi"});
  romanTable.put("ぴゅ", new String[] {"pyu"});
  romanTable.put("ぴぇ", new String[] {"pye"});
  romanTable.put("ぴょ", new String[] {"pyo"});
  romanTable.put("りゃ", new String[] {"rya"});
  romanTable.put("りぃ", new String[] {"ryi"});
  romanTable.put("りゅ", new String[] {"ryu"});
  romanTable.put("りぇ", new String[] {"rye"});
  romanTable.put("りょ", new String[] {"ryo"});
  romanTable.put("てゃ", new String[] {"tha"});
  romanTable.put("てぃ", new String[] {"thi"});
  romanTable.put("てゅ", new String[] {"thi"});
  romanTable.put("てぇ", new String[] {"the"});
  romanTable.put("てょ", new String[] {"tho"});
  romanTable.put("でゃ", new String[] {"dha"}); 
  romanTable.put("でぃ", new String[] {"dhi"});
  romanTable.put("でゅ", new String[] {"dhu"});
  romanTable.put("でぇ", new String[] {"dhe"});
  romanTable.put("でょ", new String[] {"dho"});
  romanTable.put("ふぁ", new String[] {"fa"});
  romanTable.put("ふぃ", new String[] {"fi"});
  romanTable.put("ふぇ", new String[] {"fe"});
  romanTable.put("ふゃ", new String[] {"fya"});
  romanTable.put("ふぃ", new String[] {"fyi"});
  romanTable.put("ふゅ", new String[] {"fyu"});
  romanTable.put("ふぇ", new String[] {"fye"});
  romanTable.put("ふょ", new String[] {"fyo"});
  romanTable.put("ゔぁ", new String[] {"va"});
  romanTable.put("ゔぃ", new String[] {"vi"});
  romanTable.put("ゔぇ", new String[] {"ve"});
  romanTable.put("ゔぉ", new String[] {"vo"});
  romanTable.put("ゔ", new String[] {"vu"});
  romanTable.put("あ", new String[] {"a"});
  romanTable.put("い", new String[] {"i"});
  romanTable.put("う", new String[] {"u"});
  romanTable.put("え", new String[] {"e"});
  romanTable.put("お", new String[] {"o"});
  romanTable.put("か", new String[] {"ka"});
  romanTable.put("き", new String[] {"ki"});
  romanTable.put("く", new String[] {"ku"});
  romanTable.put("け", new String[] {"ke"});
  romanTable.put("こ", new String[] {"ko"});
  romanTable.put("さ", new String[] {"sa"});
  romanTable.put("し", new String[] {"si", "shi"});
  romanTable.put("す", new String[] {"su"});
  romanTable.put("せ", new String[] {"se"});
  romanTable.put("そ", new String[] {"so"});
  romanTable.put("た", new String[] {"ta"});
  romanTable.put("ち", new String[] {"ti", "chi"});
  romanTable.put("つ", new String[] {"tu", "tsu"});
  romanTable.put("て", new String[] {"te"});
  romanTable.put("と", new String[] {"to"});
  romanTable.put("な", new String[] {"na"});
  romanTable.put("に", new String[] {"ni"});
  romanTable.put("ぬ", new String[] {"nu"});
  romanTable.put("ね", new String[] {"ne"});
  romanTable.put("の", new String[] {"no"});
  romanTable.put("は", new String[] {"ha"});
  romanTable.put("ひ", new String[] {"hi"});
  romanTable.put("ふ", new String[] {"hu", "fu"});
  romanTable.put("へ", new String[] {"he"});
  romanTable.put("ほ", new String[] {"ho"});
  romanTable.put("ま", new String[] {"ma"});
  romanTable.put("み", new String[] {"mi"});
  romanTable.put("む", new String[] {"mu"});
  romanTable.put("め", new String[] {"me"});
  romanTable.put("も", new String[] {"mo"});
  romanTable.put("や", new String[] {"ya"});
  romanTable.put("ゆ", new String[] {"yu"});
  romanTable.put("よ", new String[] {"yo"});
  romanTable.put("ら", new String[] {"ra"});
  romanTable.put("り", new String[] {"ri"});
  romanTable.put("る", new String[] {"ru", "ru"});
  romanTable.put("れ", new String[] {"re"});
  romanTable.put("ろ", new String[] {"ro"});
  romanTable.put("わ", new String[] {"wa"});
  romanTable.put("を", new String[] {"wo"});
  romanTable.put("ん", new String[] {"n"});

  romanTable.put("が", new String[] {"ga"});
  romanTable.put("ぎ", new String[] {"gi"});
  romanTable.put("ぐ", new String[] {"gu"});
  romanTable.put("げ", new String[] {"ge"});
  romanTable.put("ご", new String[] {"go"});
  romanTable.put("ざ", new String[] {"za"});
  romanTable.put("じ", new String[] {"zi", "ji"});
  romanTable.put("ず", new String[] {"zu"});
  romanTable.put("ぜ", new String[] {"ze"});
  romanTable.put("ぞ", new String[] {"zo"});
  romanTable.put("だ", new String[] {"da"});
  romanTable.put("ぢ", new String[] {"di"});
  romanTable.put("づ", new String[] {"du"});
  romanTable.put("で", new String[] {"de"});
  romanTable.put("ど", new String[] {"do"});
  
  romanTable.put("ぱ", new String[] {"pa"});
  romanTable.put("ぴ", new String[] {"pi"});
  romanTable.put("ぷ", new String[] {"pu"});
  romanTable.put("ぺ", new String[] {"pe"});
  romanTable.put("ぽ", new String[] {"po"});
  romanTable.put("ぁ", new String[] {"xa", "la", "xya", "lya"});
  romanTable.put("ぃ", new String[] {"xi", "li", "xyi", "lyi"});
  romanTable.put("ぅ", new String[] {"xu", "lu", "xyu", "lyu"});
  romanTable.put("ぇ", new String[] {"xe", "le", "xye", "lye"});
  romanTable.put("ぉ", new String[] {"xo", "lo", "xyo", "lyo"});
  romanTable.put("っ", new String[] {"xtu", "ltu", "xtsu", "ltsu"});
  romanTable.put("ゃ", new String[] {"xya", "lya"});
  romanTable.put("ゅ", new String[] {"xyu", "lyo"});
  romanTable.put("ょ", new String[] {"xyo", "lyo"});

  parser = new RomanParser(romanTable, problems[0]);
  println(parser.remainRomanText()); // => {"toukyou", "toukiyou"}
}

void draw() {
  background(255);
  fill(0);
  textSize(30);
  text(parser.currentKanaText(), 100, 80);
  
  float acceptedRomanTextWidth = textWidth(parser.acceptedRomanText());
  fill(200);
  text(parser.acceptedRomanText(), 100, 130);
  fill(0);
  text(parser.remainRomanText(), 100 + acceptedRomanTextWidth, 100);
}

void keyTyped() {
  if (parser.input(str(key))) {
    println("ok");
  } else {
    println("ng", "" + str(key));
  }
}
public class Game {
  Problem[] problems;
  int index;
  
  public Game(Problem[] problems) {
    this.problems = problems;
    this.index = 0;
  }
  
  public boolean isFinished() {
    return this.index >= this.problems.length;
  }
  
  public void next() {
    this.index++;
  }
  
  public void reset() {
    this.index = 0;
  }
  
  public Problem currentProblem() {
    return this.problems[index];
  }
}
public class Match {
  String roman;
  String kana;
  
  public Match(String roman, String kana) {
    this.roman = roman;
    this.kana = kana;
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
import java.util.Map;
import java.util.List;

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

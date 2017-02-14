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
      String nextInput = null;
      if (fields.length >= 3) nextInput = fields[2];
      this.add(input, output, nextInput);
    }
  }
  
  public Iterator<Roman> iterator() {
    return this.table.iterator();
  }
}
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
      
      problems.add(new Problem(fields[0], fields[1]));
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
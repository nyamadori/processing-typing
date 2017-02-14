import java.util.AbstractList;
import java.util.Collections;

public class ProblemSet {
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
  
  public void set(int index, Problem problem) {
    this.problems.set(index, problem);
  }
  
  public int size() {
    return problems.size();
  }
  
  public void shuffle() {
    for (int i = size() - 1; i > 0; i--) {
      int index = (int)random(0, i + 1);
      Problem a = get(index);
      problems.set(index, problems.get(i));
      problems.set(i, a);
    }
  }
}
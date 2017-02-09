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
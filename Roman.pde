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
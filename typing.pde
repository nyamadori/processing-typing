RomanParser parser;
Game game;

void setup() {
  size(800, 600);

  Problem[] problems = {
    new Problem("東京特許許可局", "とうきょうとっきょきょかきょく"),
    new Problem("彼はよく柿食う客だ", "かれはよくかきくうきゃくだ")
  };
  
  parser = new RomanParser(romanTable, problems[0]);
  game = new Game(problems);
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
  if (parser.isFinished()) {
    
  }
  if (parser.input(str(key))) {
    println("ok");
  } else {
    println("ng", "" + str(key));
  }
}
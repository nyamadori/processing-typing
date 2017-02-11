Game game;

void setup() {
  size(800, 600);

  Problem[] problems = {
    new Problem("東京特許許可局", "とうきょうとっきょきょかきょく"),
    new Problem("彼はよく柿喰う客だ", "かれはよくかきくうきゃくだ")
  };
  
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
class Edge {
  Node from; 
  Node to; 
  float minutes;
  String col;
  
  char letter;
  static final color r = #E61310;
  static final color g = #016842;
  static final color b = #00308C;
  static final color o = #FF8305;
  
  Edge(Node from, Node to, float minutes, String col) {
    this.from = from; 
    this.to = to; 
    this.minutes = minutes;
    this.col = col;
  }
  
  Node getFromNode() {
    return from;
  }
  
  Node getToNode() {
    return to;
  }
  
  float getMinutes() {
    return minutes;
  }
  
  String getCol() {
    return col;
  }
  
  void draw() {
    if (col == "red") {
      letter = 'r'; 
    } 
    else if (col == "green") {
      letter = 'g'; 
    }
    else if (col == "blue") {
      letter = 'b'; 
    } 
    else if (col == "orange") {
      letter = 'o';
    }
    
    switch (letter) {
      case 'r':
        stroke(r);
        break;
      case 'g':
        stroke(g);
        break;
      case 'b':
        stroke(b);
        break;
      case 'o':
        stroke(o);
        break;
      default:
        stroke(0);
        break;
    }
     
    strokeWeight(2);
    line(from.x, from.y, to.x, to.y);
  }
}  

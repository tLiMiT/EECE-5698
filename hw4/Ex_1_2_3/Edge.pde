class Edge {
  Node from; 
  Node to; 
  float minutes;
  color col;
  
  Edge(Node from, Node to, float minutes, String col) {
    this.from = from; 
    this.to = to; 
    this.minutes = minutes;
    
    if (col.substring(0,1).equals("r")) {
      this.col = color(230, 19, 16);
    }
    else if (col.substring(0,1).equals("g")) {
      this.col = color(1, 104, 66);
    }
    else if (col.substring(0,1).equals("b")) {
      this.col = color(0, 48, 140);
    }
    else if (col.substring(0,1).equals("o")) {
      this.col = color(255, 131, 5);
    }
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
  
  void draw() {
    stroke(this.col);
    strokeWeight(2);
    line(from.x, from.y, to.x, to.y);
  }
}  

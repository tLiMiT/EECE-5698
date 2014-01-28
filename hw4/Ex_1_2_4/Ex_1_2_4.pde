import processing.pdf.*;

// tables
Table locationTable;
Table connectionTable;

// arrays
boolean activeNodes[];
boolean activeEdges[];

// globals
Node A;
Node B;
int numOfNodes = 0;
float numOfMinutes = 0;

// nodes
int nodeCount; 
Node[] nodes = new Node[100];
HashMap nodeTable = new HashMap();

// selection
Node selection;

// record
boolean record; 

// edges
int edgeCount; 
Edge[] edges = new Edge[500];

// font
PFont font; 

void setup() {
  size(559, 559);
  font = createFont("SansSerif", 10);
  locationTable = new Table("locations.csv");
  connectionTable = new Table("connections.csv");
  loadData();
  initializeActiveDataStructures();
  initializeAdjacencyMatrix();
}

void loadData() {
  for (int i = 0; i < connectionTable.getRowCount(); i++) {
    addEdge(connectionTable.getString(i, 1), connectionTable.getString(i, 0), 
            connectionTable.getFloat(i, 3), connectionTable.getString(i, 2));
  }
}

void addEdge(String fromLabel, String toLabel, float minutes, String col) {
  // find nodes
  Node from = findNode(fromLabel);
  Node to = findNode(toLabel);
  
  // old edge?
  for (int i = 0; i < edgeCount; i++) {
    if (edges[i].from == from && edges[i].to == to) {
      return; 
    }
  }
  
  // add edge
  Edge e = new Edge(from, to, minutes, col);
  if (edgeCount == edges.length) {
    edges = (Edge[]) expand(edges);
  }
  edges[edgeCount++] = e; 
}

Node findNode(String label) {
  Node n = (Node) nodeTable.get(label);
  if (n == null) {
    return addNode(label);
  }
  return n; 
}

Node addNode(String label) {
  int i = locationTable.getRowIndex(label);
  float x = locationTable.getFloat(i, 1);
  float y = locationTable.getFloat(i, 2);
  Node n = new Node(label, x, y, nodeCount);
  if (nodeCount == nodes.length) {
    nodes = (Node[]) expand(nodes);
  }
  nodeTable.put(label, n);
  nodes[nodeCount++] = n;
  return n; 
}

void draw() {
  if (record) {
    beginRecord(PDF, "output.pdf");
  }
  
  textFont(font); 
  smooth();
  
  background(255); 
  
  if (numOfNodes != 2) {
    // draw the edges
    for (int i = 0; i < edgeCount; i++) {
      edges[i].draw();
    }
    
    // draw the nodes
    for (int i = 0; i < nodeCount; i++) {
      nodes[i].draw();
    }
  }
  
  if (numOfNodes == 2) {
    // draw the edges
    for (int i = 0; i < edgeCount; i++) {
      if (activeEdges[i]) {
        edges[i].draw();
      }
    }
    
    // draw the nodes
    for (int i = 0; i < nodeCount; i++) {
      if (activeNodes[i]) {
        nodes[i].draw();
      }
    }  
    
    textSize(14);
    fill(0);
    text("From: ", 20, 20);
    text(A.getLabel(), 70, 20);
    text("To: ", 20, 40);
    text(B.getLabel(), 70, 40);
    text("Travel Time: ", 20, 60);
    text(shortestPath(A.getIndex(), B.getIndex()), 110, 60);
  }
    
  float closest = 5;
  for (int i = 0; i < nodeCount; i++) {
    Node n = nodes[i];
    float d = dist(mouseX, mouseY, n.x, n.y);
    if (d < closest) {
      selection = n;
      closest = d;
      
      textSize(14);
      fill(0);
      text(n.getLabel(), 250, 20);
    }
  }
  
  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    if (numOfNodes == 2) {
      numOfNodes = 0;
    }
    
    float closest = 5;
    for (int i = 0; i < nodeCount; i++) {
      Node n = nodes[i];
      float d = dist(mouseX, mouseY, n.x, n.y);
      if (d < closest) {
        selection = n;
        closest = d;
        
        if (numOfNodes == 0) {
          A = n;
          numOfNodes += 1;
        }
        else if (numOfNodes == 1) {
          B = n;
          numOfNodes += 1;
          numOfMinutes = shortestPath(A.getIndex(), B.getIndex());
        }
      }
    }
  }
  
  if (mouseButton == LEFT) {
    float closest = 5;
    for (int i = 0; i < nodeCount; i++) {
      Node n = nodes[i];
      float d = dist(mouseX, mouseY, n.x, n.y);
      if (d < closest) {
        selection = n;
        closest = d;
      }
    }
  }
}

void mouseDragged() {
  if (selection != null) {
    selection.x = mouseX;
    selection.y = mouseY;
  }
}

void mouseReleased() {
  selection = null;
}

void keyPressed() {
  if (key == 'p') {
    record = true;
  }
}


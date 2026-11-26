import java.util.ArrayList;
import java.util.Collections;

int numNodes = 15;
ArrayList<PVector> nodes = new ArrayList<PVector>();
ArrayList<Edge> allEdges = new ArrayList<Edge>();
ArrayList<Edge> mstEdges = new ArrayList<Edge>();

int[] parent;
int edgeIndex = 0;
boolean isFinished = false;

void setup() {
  size(800, 600);
  frameRate(15);
  initGraph();
}

void draw() {
  background(25);
  
  stroke(60);
  strokeWeight(1);
  for (Edge e : allEdges) {
    PVector a = nodes.get(e.u);
    PVector b = nodes.get(e.v);
    line(a.x, a.y, b.x, b.y);
  }
  
  if (!isFinished) {
    if (edgeIndex < allEdges.size() && mstEdges.size() < numNodes - 1) {
      Edge current = allEdges.get(edgeIndex);
      
      stroke(255, 220, 0);
      strokeWeight(2);
      PVector a = nodes.get(current.u);
      PVector b = nodes.get(current.v);
      line(a.x, a.y, b.x, b.y);
      
      if (find(current.u) != find(current.v)) {
        union(current.u, current.v);
        mstEdges.add(current);
      }
      edgeIndex++;
    } else {
      isFinished = true;
    }
  }
  
  stroke(0, 230, 150);
  strokeWeight(4);
  for (Edge e : mstEdges) {
    PVector a = nodes.get(e.u);
    PVector b = nodes.get(e.v);
    line(a.x, a.y, b.x, b.y);
  }
  
  noStroke();
  fill(255);
  for (int i = 0; i < nodes.size(); i++) {
    PVector p = nodes.get(i);
    ellipse(p.x, p.y, 14, 14);
  }
  
  fill(200);
  textSize(14);
  text("Click anywhere to generate new nodes", 20, 30);
  text("MST Edges: " + mstEdges.size() + " / " + (numNodes - 1), 20, 50);
  if (isFinished) {
    fill(0, 230, 150);
    text("Completed!", 20, 70);
  }
}

void mousePressed() {
  initGraph();
}

void initGraph() {
  nodes.clear();
  allEdges.clear();
  mstEdges.clear();
  edgeIndex = 0;
  isFinished = false;
  
  for (int i = 0; i < numNodes; i++) {
    nodes.add(new PVector(random(60, width - 60), random(80, height - 60)));
  }
  
  for (int i = 0; i < numNodes; i++) {
    for (int j = i + 1; j < numNodes; j++) {
      float d = dist(nodes.get(i).x, nodes.get(i).y, nodes.get(j).x, nodes.get(j).y);
      allEdges.add(new Edge(i, j, d));
    }
  }
  
  Collections.sort(allEdges);
  
  parent = new int[numNodes];
  for (int i = 0; i < numNodes; i++) {
    parent[i] = i;
  }
}

int find(int i) {
  if (parent[i] == i) return i;
  return parent[i] = find(parent[i]);
}

void union(int i, int j) {
  int rootI = find(i);
  int rootJ = find(j);
  if (rootI != rootJ) {
    parent[rootI] = rootJ;
  }
}

class Edge implements Comparable<Edge> {
  int u, v;
  float weight;
  
  Edge(int u, int v, float weight) {
    this.u = u;
    this.v = v;
    this.weight = weight;
  }
  
  @Override
  public int compareTo(Edge other) {
    return Float.compare(this.weight, other.weight);
  }
}

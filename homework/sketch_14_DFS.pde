import java.util.ArrayList;

ArrayList<ArrayList<Integer>> adj;
ArrayList<Integer> traversalOrder;
float[] nodeX = new float[6];
float[] nodeY = new float[6];

void setup() {
    size(500, 500);
    int V = 6;
    adj = new ArrayList<>();
    
    for (int i = 0; i < V; i++)
        adj.add(new ArrayList<>());

    addEdge(adj, 1, 2);
    addEdge(adj, 0, 3);
    addEdge(adj, 2, 0);
    addEdge(adj, 5, 4);

    traversalOrder = dfs(adj);

    float cx = width / 2;
    float cy = height / 2 - 40;
    float r = 120;
    for (int i = 0; i < V; i++) {
        float angle = TWO_PI / V * i;
        nodeX[i] = cx + cos(angle) * r;
        nodeY[i] = cy + sin(angle) * r;
    }
}

void draw() {
    background(255);
    
    stroke(150);
    strokeWeight(2);
    for (int u = 0; u < adj.size(); u++) {
        for (int v : adj.get(u)) {
            if (u < v) {
                line(nodeX[u], nodeY[u], nodeX[v], nodeY[v]);
            }
        }
    }

    for (int i = 0; i < nodeX.length; i++) {
        fill(255, 220, 200);
        stroke(0);
        ellipse(nodeX[i], nodeY[i], 40, 40);
        
        fill(0);
        textSize(16);
        textAlign(CENTER, CENTER);
        text(i, nodeX[i], nodeY[i]);
    }

    fill(0);
    textSize(14);
    textAlign(LEFT, TOP);
    text("DFS 탐색 순서: " + traversalOrder.toString(), 30, height - 60);
}

void dfsRec(ArrayList<ArrayList<Integer>> adj, boolean[] visited, int s, ArrayList<Integer> res) {
    visited[s] = true;
    res.add(s);

    for (int i : adj.get(s)) {
        if (!visited[i]) {
            dfsRec(adj, visited, i, res);
        }
    }
}

ArrayList<Integer> dfs(ArrayList<ArrayList<Integer>> adj) {
    boolean[] visited = new boolean[adj.size()];
    ArrayList<Integer> res = new ArrayList<>();

    for (int i = 0; i < adj.size(); i++) {
        if (!visited[i]) {
            dfsRec(adj, visited, i, res);
        }
    }

    return res;
}

void addEdge(ArrayList<ArrayList<Integer>> adj, int u, int v) {
    adj.get(u).add(v);
    adj.get(v).add(u);
}

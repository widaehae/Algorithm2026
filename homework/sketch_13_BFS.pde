import java.util.ArrayList;
import java.util.Queue;
import java.util.LinkedList;

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
    addEdge(adj, 2, 0);
    addEdge(adj, 0, 3);
    addEdge(adj, 4, 5);

    traversalOrder = bfs(adj);

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
        fill(200, 220, 255);
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
    text("BFS 탐색 순서: " + traversalOrder.toString(), 30, height - 60);
}

void bfsConnected(ArrayList<ArrayList<Integer>> adj, int src, boolean[] visited, ArrayList<Integer> res) {
    Queue<Integer> q = new LinkedList<>();
    visited[src] = true;
    q.add(src);

    while (!q.isEmpty()) {
        int curr = q.poll();
        res.add(curr);

        for (int x : adj.get(curr)) {
            if (!visited[x]) {
                visited[x] = true;
                q.add(x);
            }
        }
    }
}

ArrayList<Integer> bfs(ArrayList<ArrayList<Integer>> adj) {
    int V = adj.size();
    boolean[] visited = new boolean[V];
    ArrayList<Integer> res = new ArrayList<>();

    for (int i = 0; i < V; i++) {
        if (!visited[i])
            bfsConnected(adj, i, visited, res);
    }
    return res;
}

void addEdge(ArrayList<ArrayList<Integer>> adj, int u, int v) {
    adj.get(u).add(v);
    adj.get(v).add(u);
}

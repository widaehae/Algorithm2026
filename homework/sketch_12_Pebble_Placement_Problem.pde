void setup() {
  size(400, 400);
  
  int[][] table = {
    {6, 7, 12, -5, 5, 3, 11, 3}, 
    {-8, 10, 14, 9, 7, 13, 8, 5}, 
    {11, 12, 7, 4, 8, -2, 9, 4}
  };
  
  int result = maxSum3nTable(table);
  println("\n========================");
  println("최대 합: " + result);
}

int maxSum3nTable(int[][] table) {
  int n = table[0].length;
  int[][] Value = new int[4][n];
  
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < n; j++) {
      Value[i][j] = table[i][j];
    }
  }
  
  for (int j = 0; j < n; j++) {
    Value[3][j] = Value[0][j] + Value[2][j];
  }
  
  int[][] DP = new int[4][n];
  int[][] parent = new int[4][n];
  
  DP[0][0] = Value[0][0];
  DP[1][0] = Value[1][0];
  DP[2][0] = Value[2][0];
  DP[3][0] = Value[3][0];
  
  println("=== DP 테이블 계산 과정 ===");
  println("열 0 -> DP[0][0]: " + DP[0][0] + ", DP[1][0]: " + DP[1][0] + ", DP[2][0]: " + DP[2][0] + ", DP[3][0]: " + DP[3][0]);
  
  for (int i = 1; i < n; i++) {
    int v1 = DP[1][i - 1];
    int v2 = DP[2][i - 1];
    if (v1 >= v2) {
      DP[0][i] = v1 + Value[0][i];
      parent[0][i] = 1;
    } else {
      DP[0][i] = v2 + Value[0][i];
      parent[0][i] = 2;
    }
    
    int u0 = DP[0][i - 1];
    int u2 = DP[2][i - 1];
    int u3 = DP[3][i - 1];
    int max_u = max(u0, max(u2, u3));
    DP[1][i] = max_u + Value[1][i];
    if (max_u == u0) parent[1][i] = 0;
    else if (max_u == u2) parent[1][i] = 2;
    else parent[1][i] = 3;
    
    int w0 = DP[0][i - 1];
    int w1 = DP[1][i - 1];
    if (w0 >= w1) {
      DP[2][i] = w0 + Value[2][i];
      parent[2][i] = 0;
    } else {
      DP[2][i] = w1 + Value[2][i];
      parent[2][i] = 1;
    }
    
    DP[3][i] = DP[1][i - 1] + Value[3][i];
    parent[3][i] = 1;
    
    println("열 " + i + " -> DP[0]: " + DP[0][i] + " | DP[1]: " + DP[1][i] + " | DP[2]: " + DP[2][i] + " | DP[3]: " + DP[3][i]);
  }
  
  int bestRow = 0;
  int maxSum = DP[0][n - 1];
  for (int r = 1; r < 4; r++) {
    if (DP[r][n - 1] > maxSum) {
      maxSum = DP[r][n - 1];
      bestRow = r;
    }
  }
  
  println("\n=== 선택된 상태 역추적 (Backtracking) ===");
  int[] pathRow = new int[n];
  int currRow = bestRow;
  for (int i = n - 1; i >= 1; i--) {
    pathRow[i] = currRow;
    currRow = parent[currRow][i];
  }
  pathRow[0] = currRow;
  
  for (int i = 0; i < n; i++) {
    println("열 " + i + " 의 선택된 상태(행): " + pathRow[i] + " (값: " + table[pathRow[i] == 3 ? 0 : pathRow[i]][i] + (pathRow[i] == 3 ? " + " + table[2][i] : "") + ")");
  }
  
  return maxSum;
}

void draw() {
}

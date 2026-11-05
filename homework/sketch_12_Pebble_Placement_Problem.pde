void setup() {
  size(400, 400);
  
  int[][] table = {
    {6, 7, 12, -5, 5, 3, 11, 3}, 
    {-8, 10, 14, 9, 7, 13, 8, 5}, 
    {11, 12, 7, 4, 8, -2, 9, 4}
  };
  
  int result = maxSum3nTable(table);
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
  
  DP[0][0] = Value[0][0];
  DP[1][0] = Value[1][0];
  DP[2][0] = Value[2][0];
  DP[3][0] = Value[3][0];
  
  for (int i = 1; i < n; i++) {
    DP[0][i] = max(DP[1][i - 1], DP[2][i - 1]) + Value[0][i];
    DP[1][i] = max(DP[0][i - 1], max(DP[2][i - 1], DP[3][i - 1])) + Value[1][i];
    DP[2][i] = max(DP[0][i - 1], DP[1][i - 1]) + Value[2][i];
    DP[3][i] = DP[1][i - 1] + Value[3][i];
  }
  
  int maxSum = max(max(DP[0][n - 1], DP[1][n - 1]), max(DP[2][n - 1], DP[3][n - 1]));
  
  return maxSum;
}

void draw() {
}

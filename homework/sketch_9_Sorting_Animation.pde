int[] values;
int i = 0;
int j = 0;
int minIdx = 0;
boolean finished = false;

void setup() {
  size(800, 400);
  values = new int[width / 40];
  
  for (int k = 0; k < values.length; k++) {
    values[k] = int(random(height - 20)) + 10;
  }
  
  frameRate(30);
}

void draw() {
  background(30);

  if (!finished) {
    if (values[j] < values[minIdx]) {
      minIdx = j;
    }
    
    j++;
    
    if (j >= values.length) {
      swap(values, i, minIdx);
      i++;
      minIdx = i;
      j = i + 1;
      
      if (i >= values.length - 1) {
        finished = true;
      }
    }
  }

  float barWidth = width / (float)values.length;
  
  for (int k = 0; k < values.length; k++) {
    stroke(0);
    
    if (finished) {
      fill(100, 255, 100);
    } else if (k < i) {
      fill(100, 200, 255);
    } else if (k == minIdx) {
      fill(255, 50, 50);
    } else if (k == j) {
      fill(255, 255, 0);
    } else {
      fill(200);
    }
    
    rect(k * barWidth, height - values[k], barWidth, values[k]);
  }
}

void swap(int[] arr, int a, int b) {
  int temp = arr[a];
  arr[a] = arr[b];
  arr[b] = temp;
}

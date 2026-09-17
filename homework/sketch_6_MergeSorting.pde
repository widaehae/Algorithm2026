int[] arr;

void setup() {
  intArr(16);
  printArr();
  mergeSorting();
  printArr();
}

void intArr(int n) {
  int i;
  arr = new int[n];
  for(i = 0; i < arr.length; i++) {
    arr[i] = (int) random(100);
  }
}

void printArr() {
  int i;
  for(i = 0; i < arr.length; i++) {
    print(arr[i], " ");
  }
  println();
}

void mergeSorting() {
  mergeSort(0, arr.length - 1);
}

void mergeSort(int left, int right) {
  if (left < right) {
    int mid = (left + right) / 2;
    mergeSort(left, mid);
    mergeSort(mid + 1, right);
    merge(left, mid, right);
  }
}

void merge(int left, int mid, int right) {
  int[] temp = new int[right - left + 1];
  int i = left;
  int j = mid + 1;
  int k = 0;

  while (i <= mid && j <= right) {
    if (arr[i] <= arr[j]) {
      temp[k++] = arr[i++];
    } else {
      temp[k++] = arr[j++];
    }
  }

  while (i <= mid) {
    temp[k++] = arr[i++];
  }

  while (j <= right) {
    temp[k++] = arr[j++];
  }

  for (int m = 0; m < temp.length; m++) {
    arr[left + m] = temp[m];
  }
}

void draw() {
}

#include <bits/stdc++.h>
using namespace std;

// Linear Search (using flag)
int linearSearch(vector<int> &arr, int key) {
  int flag = 0, pos = -1;
  for (int i = 0; i < arr.size(); i++) {
    if (arr[i] == key) {
      flag = 1;
      pos = i;
      break;
    }
  }
  if (flag == 1)
    return pos;
  else
    return -1;
}

// Binary Search (using flag)
int binarySearch(vector<int> &arr, int key) {
  int low = 0, high = arr.size() - 1, flag = 0, pos = -1;
  while (low <= high) {
    int mid = low + (high - low) / 2;
    if (arr[mid] == key) {
      flag = 1;
      pos = mid;
      break;
    }
    else if (arr[mid] < key)
      low = mid + 1;
    else
      high = mid - 1;
  }
  if (flag == 1)
    return pos;
  else
    return -1;
}

// Bubble Sort (using flag for optimization)
void bubbleSort(vector<int> &arr) {
  int n = arr.size();
  for (int i = 0; i < n - 1; i++) {
    int flag = 0; // to check if any swap happened
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        swap(arr[j], arr[j + 1]);
        flag = 1;
      }
    }
    // if no swap occurred → array already sorted
    if (flag == 0)
      break;
  }
}

// Selection Sort
void selectionSort(vector<int> &arr) {
  int n = arr.size();
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < n; j++) {
      if (arr[j] < arr[minIndex])
        minIndex = j;
    }
    swap(arr[i], arr[minIndex]);
  }
}

// Insertion Sort
void insertionSort(vector<int> &arr) {
  int n = arr.size();
  for (int i = 1; i < n; i++) {
    int key = arr[i];
    int j = i - 1;
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
    }
    arr[j + 1] = key;
  }
}

// Maximum Subarray Sum (Kadane’s Algorithm)
int maxSubarraySum(vector<int> &arr) {
  int maxSum = INT_MIN, currentSum = 0;
  for (int x : arr) {
    currentSum = max(x, currentSum + x);
    maxSum = max(maxSum, currentSum);
  }
  return maxSum;
}

// 🔹 Helper Function to Print Vector
void printArray(vector<int> &arr) {
  for (int x : arr)
    cout << x << " ";
  cout << "\n";
}

int main() {
  vector<int> arr = {5, 3, 8, 4, 2};
  int key = 4;

  cout << "Original Array: ";
  printArray(arr);

  // Linear Search
  cout << "\nLinear Search for " << key << ": ";
  int idx = linearSearch(arr, key);
  if (idx != -1)
    cout << "Found at index " << idx << endl;
  else
    cout << "Not found\n";

  // Binary Search
  sort(arr.begin(), arr.end());
  cout << "\nSorted Array for Binary Search: ";
  printArray(arr);
  cout << "🔎 Binary Search for " << key << ": ";
  idx = binarySearch(arr, key);
  if (idx != -1)
    cout << "Found at index " << idx << endl;
  else
    cout << "Not found\n";

  // Bubble Sort
  vector<int> b1 = {5, 3, 8, 4, 2};
  bubbleSort(b1);
  cout << "\nAfter Bubble Sort: ";
  printArray(b1);

  // Selection Sort
  vector<int> b2 = {5, 3, 8, 4, 2};
  selectionSort(b2);
  cout << "After Selection Sort: ";
  printArray(b2);

  // Insertion Sort
  vector<int> b3 = {5, 3, 8, 4, 2};
  insertionSort(b3);
  cout << "After Insertion Sort: ";
  printArray(b3);

  // Kadane’s Algorithm
  vector<int> nums = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
  cout << "\nMaximum Subarray Sum (Kadane's): " << maxSubarraySum(nums) << endl;

  return 0;
}

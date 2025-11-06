#include <bits/stdc++.h>
using namespace std;

int main() {
  vector<int> arr = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
  int maxSum = INT_MIN, currentSum = 0;

  for (int x : arr) {
    currentSum = max(x, currentSum + x);
    maxSum = max(maxSum, currentSum);
  }

  cout << "Maximum Subarray Sum = " << maxSum << endl;
  return 0;
}


/*
int kadane(int arr[], int n) {
int maxSum = INT_MIN, currentSum = 0;
for (int i = 0; i < n; i++) {
 currentSum += arr[i];
 maxSum = max(maxSum, currentSum);
 if (currentSum < 0) currentSum = 0;
 }
return maxSum;}

*/
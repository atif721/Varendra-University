// maximum subarray sum problem

#include <algorithm>
#include <iostream>

using namespace std;

int main() {

  int subArray[] = {-1, -2, -3, -4, -5, -6};
  int length = sizeof(subArray) / sizeof(subArray[0]);

  int maxSum = subArray[0];

  for (int i = 0; i < length; i++) {
    int sum = 0;
    for (int j = i; j < length; j++) {
      sum += subArray[j];
      maxSum = max(maxSum, sum);
    }
  }

  cout << "Maximum subarray sum : " << maxSum << endl;

  return 0;
}
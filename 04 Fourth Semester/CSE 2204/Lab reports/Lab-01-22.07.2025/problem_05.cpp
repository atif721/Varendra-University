#include<iostream>
using namespace std;

int arraySize() {
  int size;
  cout << "Enter the size of array : ";
  cin >> size;

  return size;
}

int* defineArray(int size) {

  int* array = new int[size];

  cout << "Enter array elements : " << endl;
  for (int i = 0; i < size; i++) {
    cout << "[" << i << "] : ";
    cin >> array[i];
  }

  return array;
}

void printArray(int* array, int size) {
  cout << "The Array is : [";
  for (int i = 0; i < size; i++) {
    cout << array[i];
    if (i != size - 1) {
      cout << ", ";
    }
  }
  cout << "]\n";
}

void matchingTargetValue(int* array, int target, int size) {

  for (int i = 0; i < size; i++) {
    for (int j = i + 1; j < size; j++) {
      if (array[i] + array[j] == target) {
        cout << "Ouput : [" << i << ", " << j << "]\n";
        return;
      }
    }
  }

  // If no pair is found, print a message
  cout << "No matching pair found.";
}

void deleteArray(int* array) {
  delete [] array;
}


int main() {

  int size = arraySize();
  int* array = defineArray(size);
  printArray(array, size);

  int targetValue;
  cout << "Enter a target value : ";
  cin >> targetValue;

  matchingTargetValue(array, targetValue, size);

  deleteArray(array);

  return 0;
}
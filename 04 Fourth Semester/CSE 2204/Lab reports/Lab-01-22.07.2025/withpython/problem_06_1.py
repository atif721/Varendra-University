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

void shiftZeroToEnd(int* array, int size) {
  int pos = 0;
  for (int i = 0; i < size; i++) {
    if (array[i] != 0) {
      // cout << "Position before:" << pos << endl;
      array[pos++] = array[i];
    }
    // cout << "Position :" << pos << endl;
  }

  while (pos < size) {
    array[pos++] = 0;
  }
}

void deleteArray(int* array) {
  delete [] array;
}

int main() {

  int size = arraySize();
  int* array = defineArray(size);
  printArray(array, size);

  shiftZeroToEnd(array, size);
  printArray(array, size);

  deleteArray(array);

  return 0;
}
#include <iostream>
using namespace std;

void displayArray(int size, int arr []) {
      for (int i = 0; i < size; i++) {
            cout << "Element " << i + 1 << " : ";
            cout << arr[i] << endl;
      }
}

int binarySearch(int array [], int size, int item) {
      int BEG = 0;
      int END = size - 1;
      int MID = (BEG + END) / 2;

      int LOC = -1;

      while (BEG <= END) {
            MID = (BEG + END) / 2;

            if (item == array[MID]) {
                  return MID;
            }
            else if (item < array[MID]) {
                  END = MID - 1;
            }
            else {
                  BEG = MID + 1;
            }
      }
      return LOC;  // Item not found
}



int main() {
      cout << "Enter array size : ";
      int size;
      cin >> size;

      int array[size];

      cout << "Enter elements in sorted order:\n";
      for (int i = 0; i < size; i++) {
            cout << "Enter element " << i + 1 << " : ";
            cin >> array[i];
      }

      displayArray(size, array);

      cout << "Enter element you want to search : ";
      int search;
      cin >> search;

      int index = binarySearch(array, size, search);

      if (index == -1) {
            cout << "Item not found" << endl;
      }
      else {
            cout << "Array index : " << index << endl;
      }

      return 0;
}

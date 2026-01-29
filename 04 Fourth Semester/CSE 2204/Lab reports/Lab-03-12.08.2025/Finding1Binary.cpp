#include <iostream>

using namespace std;

int main() {

    int length;
    cout << "Enter length of array : ";
    cin >> length;

    int* array = new int[length];
    cout << "Enter " << length << " elements : ";
    for (int i = 0; i < length; i++) {
        cin >> array[i];
    }

    int BEG = 0;
    int END = length - 1;
    int MID = 0;
    int found = -1;

    while (BEG <= END) {
        MID = BEG + int((END - BEG) / 2);
        if (array[MID] == 1) {
            found = MID;
            END = MID - 1;
        }
        else {
            BEG = MID + 1;
        }
    }

    if (found != -1)
        cout << "Found at index : " << found;
    else
        cout << "Not found" << endl;

    delete[] array;
    return 0;
}
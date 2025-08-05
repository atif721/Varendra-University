#include <iostream>
using namespace std;

int integerSqrt(int number) {
    int BEG = 0;
    int END = number;
    int sqrtAnswer = 0;
    while (BEG <= END) {
        int MID = BEG + (END - BEG) / 2;
        int sq = (int)MID * MID;

        if (sq <= number) {
            sqrtAnswer = MID;
            BEG = MID + 1;
        }
        else {
            END = MID - 1;
        }
    }
    return sqrtAnswer;
}

int main() {
    int number;
    cout << "Enter a non-negative integer: ";
    cin >> number;
    cout << "Integer square root: " << integerSqrt(number) << endl;
    return 0;
}

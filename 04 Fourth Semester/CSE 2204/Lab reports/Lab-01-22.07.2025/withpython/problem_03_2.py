#include <iostream>
using namespace std;

int inputColumn() {
    int n;
    cout << "Enter the column of the matrix : ";
    cin >> n;

    return n;
}

int** inputMatrix(int n, int m = 3) {
    int** matrix = new int* [m];
    for (int i = 0; i < m; i++) {
        matrix[i] = new int[n];
    }

    for (int i = 0; i < m; i++)
    {

        for (int j = 0; j < n; j++)
        {
            cout << "Enter (row-" << i + 1 << ",column-" << j + 1 << ") : ";
            cin >> matrix[i][j];
        }
    }

    return matrix;
}

void printMatrix(int** matrix, int n, int m = 3) {
    cout << endl
        << "------ " << m << "*" << n << " Matrix -----" << endl
        << endl;

    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }

    for (int i = 0; i < m; i++) {
        delete [] matrix[i];
    }
    delete [] matrix;
}

int main() {


    int n = inputColumn();

    int** matrix = inputMatrix(n);
    printMatrix(matrix, n);


    return 0;
}
#include <iostream>
using namespace std;

int inputDimension(string text) {
  int value;
  cout << text;
  cin >> value;
  return value;
}

int** inputMatrix(int rows, int cols, string name) {
  int** matrix = new int* [rows];
  for (int i = 0; i < rows; i++) {
    matrix[i] = new int[cols];
    for (int j = 0; j < cols; j++) {
      cout << "Enter " << name << "[" << i + 1 << "][" << j + 1 << "] : ";
      cin >> matrix[i][j];
    }
  }
  return matrix;
}

int** multiplyMatrix(int** A, int** B, int m, int n, int p) {
  int** result = new int* [m];
  for (int i = 0; i < m; i++) {
    result[i] = new int[p];
    for (int j = 0; j < p; j++) {
      result[i][j] = 0;
      for (int k = 0; k < n; k++) {
        result[i][j] += A[i][k] * B[k][j];
      }
    }
  }
  return result;
}

void printMatrix(int** matrix, int rows, int cols, string name) {
  cout << "\n--- " << name << " (" << rows << "x" << cols << ") ---\n";
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      cout << matrix[i][j] << " ";
    }
    cout << endl;
  }
}

void deleteMatrix(int** matrix, int rows) {
  for (int i = 0; i < rows; i++) {
    delete [] matrix[i];
  }
  delete [] matrix;
}

int main() {
  int m = inputDimension("Enter number of rows for Matrix A: ");
  int n = inputDimension("Enter number of columns for Matrix A (and rows for B): ");
  int p = inputDimension("Enter number of columns for Matrix B: ");

  cout << "\nInput Matrix A:\n";
  int** A = inputMatrix(m, n, "A");

  cout << "\nInput Matrix B:\n";
  int** B = inputMatrix(n, p, "B");

  int** C = multiplyMatrix(A, B, m, n, p);

  printMatrix(A, m, n, "Matrix A");
  printMatrix(B, n, p, "Matrix B");
  printMatrix(C, m, p, "A * B = Result");

  deleteMatrix(A, m);
  deleteMatrix(B, n);
  deleteMatrix(C, m);

  return 0;
}

#include <bits/stdc++.h>

using namespace std;

int ReturnDivisor(int x, int y){
  return x%y;
}

int main(){
  int x,y;
  x=77;
  y=8;

  cout<<ReturnDivisor(x,y)<<endl;\

  return 0;
}
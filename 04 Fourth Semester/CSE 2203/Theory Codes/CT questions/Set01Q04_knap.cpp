#include <bits/stdc++.h>
using namespace std;

struct Item {
  char name;
  double weight, value, ratio;
};

int main() {
  vector<Item> items = {
      {'A', 5, 30},
      {'B', 10, 50},
      {'C', 15, 60},
      {'D', 7, 70},
      {'E', 8, 40}
  };
  double capacity = 20; // change to 10 for second part

  for (auto &it : items)
    it.ratio = it.value / it.weight;

  sort(items.begin(), items.end(),
    [](const Item &a, const Item &b) {
      return a.ratio > b.ratio;  // descending
    });

  double remaining = capacity;
  double totalValue = 0.0;

  cout << fixed << setprecision(2);
  cout << "Capacity: " << capacity << " kg\n";
  cout << "Take items (possibly fractional):\n";

  for (auto &it : items) {
    if (remaining <= 0) break;
    if (it.weight <= remaining) {
      cout << "Take full item " << it.name
        << " (w=" << it.weight << ", v=" << it.value << ")\n";
      remaining -= it.weight;
      totalValue += it.value;
    }
    else { 
      double frac = remaining / it.weight;
      double w = remaining;
      double v = frac * it.value;
      cout << "Take " << frac * 100 << "% of item " << it.name
        << " (w=" << w << ", v=" << v << ")\n";
      totalValue += v;
      remaining = 0;
    }
  }

  cout << "Maximum total value = " << totalValue << "\n";
  return 0;
}

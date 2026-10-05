setprecision()
fixed 
scientific

On the other hand, if your program crashes, then the characters on an unflushed stream are usually lost

<< std::numeric_limits<long>::min() << "\t"
<< std::numeric_limits<long>::max() << "\t"
<< std::numeric_limits<long>::digits << "\n";

std::random_shuffle   linear to the size of containner

• std::set_intersection to compute the intersection,
• std::set_union to compute the union,
• std::set_difference to compute the difference, and
• std::set_symmetric_difference to compu
all O(n+m)

For double 
#include <cmath>
The function std::abs computes the absolute value of its argument.
• The function std::floor computes the largest integer not greater than its argument.
• The function std::ceil computes the smallest integer not less than its argument.
• The function std::sqrt computes the square root of its argument. Given that the result
is stored in a double, it is an approximation only in general. Yet this approximation is
required to be exact within the limits of double. That is, the result is the same as if
you take the real result (with infinite precision) and then round it to the nearest double
representation.

you can use find in a vector.

#undef NDEBUG

Below is how to do two ponters properly

```cpp
#include <bits/stdc++.h>
#include <iostream>
using namespace std;
// #define d(x...) cout<<'['<<#x<<"]:",[](auto&&...a){auto _={(cout<<' '<<a, 0)...};}(x),cout<<endl;
#define d(x...)

void solve() {
  d("-----");
  int n; int k; cin>>n>>k;
  vector<int> V(n);
  for(auto& vi:V){
    cin>>vi;
  }
  struct E {
    int v,i,j;
    bool operator<(const E& o){
      return tie(v,i,j) < tie(o.v,o.i,o.j);
    }
  };
  
  vector<E> S;
  int sum=0;
  for(int i=0,j=0; i<n && j<=n && i<=j;){
    if((sum<k && j!=n) || i==j){
      sum+=V[j];
      d(abs(k-sum),i,j);
      j++;
    } else {
      sum-=V[i];
      d(abs(k-sum),i,j);
      i++;
    }
    S.push_back({abs(k-sum),i,j-1});
  }
  
  sort(S.begin(), S.end());
  
  cout<<S[0].i<<' '<<S[0].j<<'\n';
}

int main() {
  ios_base::sync_with_stdio(false);
  int t; cin>>t;
  while(t--) solve();
}
```

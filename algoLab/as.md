1. 

```cpp
#include <bits/stdc++.h>
#include <iostream>
using namespace std;

#define dg 0

#if dg
#define d(X) cout<<"["#X"]: ";
#define dd(X) d(X);cout<<X<<endl;
#define dv(X) d(X);for(auto& x:X)cout<<x<<' ';cout<<endl;
#define dvv(X) d(X);cout<<endl;for(auto& xi:X){for(auto& xij:xi){cout<<xij<<' ';}cout<<endl;}
#else
#define d(X)
#define dd(X)
#define dv(X)
#define dvv(X)
#endif

#define MAX INT_MAX-10
#define MIN INT_MIN+10

struct N{
  int min,max;
};
ostream& operator<<(ostream& out, const N& x){
  return out<<"{"<<x.min<<','<<x.max<<"}";
}

void solve() {
  int n,m; cin>>n>>m; dd(n); dd(m);
  int r,b; cin>>r>>b; r--; b--; dd(r); dd(b);
  vector<vector<int>> G(n);
  for(int i=0; i<m; i++){
    int a,b; cin>>a>>b; a--; b--;
    G[a].push_back(b);
  } dvv(G);
  
  vector<N> DP(n,{MAX,MIN});
  for(int i=n-1; i>=0; i--){
    if(i==n-1) {
      DP[i]={0,0};
      continue;
    }
    for(auto& e:G[i]){
      DP[i] = {
        min(DP[e].max+1, DP[i].min),
        max(DP[e].min+1, DP[i].max)
      };
    }
  }
  dv(DP);
  
  int rr = DP[r].min;
  int bb = DP[b].min;
  dd(rr); dd(bb);
  
  if(rr<bb){
    cout<<0<<endl;
  }else if(rr==bb) {
    if(rr%2==1) {
      cout<<0<<endl;
    } else {
      cout<<1<<endl;
    }
  } else {
    cout<<1<<endl;
  }
  
}

int main() {
  ios_base::sync_with_stdio(false);
  int t; cin>>t; while(t--) solve();
}
```

```debug
[n]: 3
[m]: 2
[r]: 0
[b]: 0
[G]: 
0: 1 
1: 2 
2:
[DP]: {2,2} {1,1} {0,0} 
[rr]: 2
[bb]: 2
Output: 1


[n]: 7
[m]: 9
[r]: 0
[b]: 1
[G]: 
0: 1 4 
1: 2 
2: 3 4 
3: 4 5 
4: 5 
5:
[DP]: {3,5} {4,4} {3,3} {2,3} {2,2} {1,1} {0,0} 
[rr]: 3
[bb]: 4
Output: 0
```

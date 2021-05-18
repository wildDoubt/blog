---
title: "Codeforces_round636_div3" # Title of the blog post.
date: 2021-05-18T14:19:48+09:00 # Date of post creation.
description: "Codeforces Round #636 Div3" # Description used for search engine.
featured: true # Sets if post is a featured post, making appear on the home page side bar.
draft: true # Sets whether to render this page. Draft of true will not be rendered.
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
#featureImage: "/images/path/file.jpg" # Sets featured image on blog post.
#thumbnail: "/images/path/thumbnail.png" # Sets thumbnail image appearing inside card on homepage.
#shareImage: "/images/path/share.png" # Designate a separate image for social media sharing.
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Algorithm
tags:
  - codeforces
# comment: false # Disable comment if false.
---

# 1. [Candies](https://codeforces.com/contest/1343/problem/A)

n의 최대값이 10^9이기 때문에 k가 31일때까지 각각 x의 계수의 합을 계산한다. n에 이 값을 나누고 나누어 떨어지면 몫이 x가 되기 때문에 그대로 출력하면 된다.

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>
#include <set>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using p = pair<int, int>;

const int INF = 0x66554433;

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
ll arr[32];
ll pArr[32];
int main(){
    quick_IO();
    int t;
    cin>>t;
    arr[1] = 1l;
    pArr[1] = 1l;
    for(int i = 2;i<32;i++){
        arr[i] = arr[i-1]*2;
        pArr[i] = pArr[i-1] + arr[i];
    }

    while(t--){
        int n;
        ll answer = 0;
        cin>>n;
        for(int i = 2;i<32;i++){
            if(n%pArr[i]==0) {
                answer = n/pArr[i];
                break;
            }
        }
        cout<<answer<<"\n";
    }
    return 0;
}
```



# 2. [Balanced Array](https://codeforces.com/contest/1343/problem/B)

홀수의 개수가 홀수면 그 홀수들의 합은 홀수이기 때문에 짝수들의 합과 같아질 수 없다. 따라서 n/2이 홀수면 NO를 출력하면 된다. n/2이 짝수면 n/2의 길이를 가진 초기값이 2이고 공차가 2인 등차수열을 만든다. n/2-1의 길이를 가진 초기값이 1이고 공차가 2인 등차수열을 만들어서 첫 번째 등차수열의 합에서 두 번째 등차수열의 합을 빼면 마지막 값을 구할 수 있다.

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>
#include <set>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using p = pair<int, int>;

const int INF = 0x66554433;

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
ll arr[32];
ll pArr[32];
int main(){
    quick_IO();
    int t;
    cin>>t;


    while(t--){
        int n, i;
        cin>>n;
        if((n/2)%2==1){
            cout<<"NO\n";
            continue;
        }else{
            cout<<"YES\n";
            int counts1 = 0;
            int counts2 = 0;
            for(i = 2;i<=n;i+=2){
                counts1+=i;
                cout<<i<<" ";
            }
            for(i = 1;i<n-1;i+=2){
                counts2+=i;
                cout<<i<<" ";
            }
            cout<<counts1-counts2<<"\n";
        }

    }
    return 0;
}
```



# 3. [Alternating Subsequence](https://codeforces.com/contest/1343/problem/C)

양수 - 음수 - 양수 이런식으로 반복되도록 부분수열를 구성하면 되는데 이렇게 만든 부분수열의 합이 최대가 되도록 만들면 된다. 양수가 연속된 부분, 음수가 연속된 부분이 번갈아가면서 나타나는데 이 부분 중 최대값을 선택해 나가면 답을 구할 수 있다.

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>
#include <set>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using p = pair<int, int>;

const int INF = 0x66554433;

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
ll arr[200005];
ll dp[2][200005];
int main(){
    quick_IO();
    int t;
    cin>>t;

    while(t--){
        int n;
        ll answer = 0;
        cin>>n;
        ll a;
        cin>>a;
        ll temp = a;
        bool positive = a>0?true:false;
        for (int i = 1; i < n; ++i) {
            cin>>a;
            if(positive){
                // 이전 값이 양수
                if(a>0){
                    temp = max(temp, a);
                }else{
                    positive = false;
                    answer += temp;
                    temp = a;
                }
            }else{
                // 이전 값이 음수
                if(a>0){
                    positive = true;
                    answer += temp;
                    temp = a;
                }else{
                    temp = max(temp, a);
                }
            }
        }
        cout<<answer+temp<<"\n";

    }
    return 0;
}
```



# 4. [Constant Palindrome Sum](https://codeforces.com/contest/1343/problem/D)

x의 범위는 1부터 2*k이므로 하나씩 x를 정해서 최소값이 되는 답을 구하면 된다. x를 선택했을 때 변할 수 있는 개수는 0, 1, 2개이다. 각 경우를 계산해서 답을 구하면 된다. 쌍의 합이 x와 같은 경우는 바꾸지 않아도 되고 현재 쌍에서 1개만 바꾸면 하한, 상한값을 정할 수 있는데 이 범위에 x가 포함되어 있으면 1개만 바꾸면 된다. 나머지 경우는 2개 모두를 바꿔야 한다.

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>
#include <set>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using p = pair<int, int>;

const int INF = 0x66554433;

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
int arr[200005];
vector<ll> low;
vector<ll> high;
map<int, int> noChange;
int answer = INF;
int main(){
    quick_IO();
    int t;
    cin>>t;

    while(t--){
        int n, k;
        cin>>n>>k;
        for(int i = 1;i<=n;i++){
            cin>>arr[i];
        }
        for(int i = 1;i<=n/2;i++){
            noChange[arr[i]+arr[n-i+1]]++;
            high.push_back(max(arr[i], arr[n-i+1]) + k);
            low.push_back(min(arr[i], arr[n-i+1]) + 1);
        }
        sort(low.begin(), low.end());
        sort(high.begin(), high.end());
        // x의 범위는 1~2*k

        for (int x = 1; x <= 2*k; ++x) {
            int a = upper_bound(low.begin(), low.end(), x) - low.begin(); // low가 x 이하인 개수
            int b = high.end() - lower_bound(high.begin(), high.end(), x); // high가 x 이상인 개수

            int A = min(a, b); // 두 값 중 최소값이 x를 완전히 포함하는 범위의 개수
            answer = min(answer, A - noChange[x] + 2*(n/2-A));
        }
        low.clear();
        high.clear();
        noChange.clear();
        cout<<answer<<endl;
        answer = INF;
    }
    return 0;
}
```




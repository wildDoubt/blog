---
title: "Codeforce_round719_div3" # Title of the blog post.
date: 2021-05-12T18:00:37+09:00 # Date of post creation.
description: "Codeforces Round #719 Div3" # Description used for search engine.
featured: true # Sets if post is a featured post, making appear on the home page side bar.
draft: false # Sets whether to render this page. Draft of true will not be rendered.
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
featureImage: #"/images/path/file.jpg" # Sets featured image on blog post.
thumbnail: #"/images/path/thumbnail.png" # Sets thumbnail image appearing inside card on homepage.
shareImage: #"/images/path/share.png" # Designate a separate image for social media sharing.
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Algorithm
tags:
  - codeforces
# comment: false # Disable comment if false.
---
> Kalgory Contest #1

# 1. [Do Not Be Distracted!](https://codeforces.com/contest/1520/problem/A)

이전에 나온 문자가 나중에 또 나오면 NO를 출력하고 아니면 YES를 출력하면 된다. 처음 등장해서 연속으로 나오는 경우는 허용하니까 이 부분만 잘 고려해서 구현하면 된다.
# 2. [Ordinary Numbers](https://codeforces.com/contest/1520/problem/B)

n이라는 정수가 입력으로 들어오면 1부터 n까지 ordinary number가 몇 개 있는지 출력하는 문제이다.

string을 이용해서 미리 ordinary number를 만들고 오름차순으로 정렬한 후 upper_bound를 사용해서 답을 출력했다.

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

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

vector<int> num;
int main(){
    quick_IO();
    int t;
    cin>>t;
    for(int i = 1;i<=9;i++){
        string a;
        for(int j = 0;j<=8;j++){
            a+=string(1, i+'0');
            num.push_back(stoi(a));
        }
        cout<<endl;
    }
    sort(num.begin(), num.end());
    while(t--){
        int n;
        cin>>n;
        cout<<upper_bound(num.begin(), num.end(), n) - num.begin()<<endl;
    }
    return 0;
}
```



# 3. [Not Adjacent Matrix](https://codeforces.com/contest/1520/problem/C)

주위 상하좌우의 값이 현재 값과의 차이가 1이 되면 안 되도록 matrix를 설계하는 문제이다. 

![](/images/codeforces_719_div3_1.png)

먼저 위에 있는 그림처럼 한 칸씩 띄워서 숫자를 배치한다.

![](/images/codeforces_719_div3_2.png)

남은 칸들에 대해서도 한 칸씩 띄워서 숫자를 배치하면 n>3일 때는 Not Adjacent Matrix를 만들 수 있다.

![](/images/codeforces_719_div3_3.png)

n이 3일 때는 위와 같은 경우가 생겨서 따로 처리를 해줬다.

n이 2일 때는 모든 칸들이 서로 인접하기 때문에 무조건 -1을 출력해줘야 한다.

```c++
#include <iostream>
#include <algorithm>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using p = pair<int, int>;

const int INF = 0x66554433;
int arr[100][100];
inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

void construct(int a){
    int num = 1;
    if(a==3){
        cout<<"2 9 7\n";
        cout<<"4 6 3\n";
        cout<<"1 8 5\n";
        return;
    }
    for(int i = 0;i<a;i++){
        for(int j = 0;j<a;j+=2){
            arr[i][j] = num;
            num++;
        }
    }
    for(int i = 0;i<a;i++){
        for(int j = 1;j<a;j+=2){
            arr[i][j] = num;
            num++;
        }
    }
    for (int i = 0; i < a; ++i) {
        for (int j = 0; j < a; ++j) {
            cout<<arr[i][j]<<" ";
        }
        cout<<endl;
    }
}

int main(){
    quick_IO();
    int t;
    cin>>t;
    while(t--){
        int n;
        cin>>n;
        if(n==2){
            cout<<-1<<'\n';
            continue;
        }
        construct(n);
    }
    return 0;
}
```
# 4. [Same Differences](https://codeforces.com/contest/1520/problem/D)

어떤 배열 arr이 있을 때 `arr[j] - arr[i] == j - i`을 모두 만족하는 순서쌍의 개수를 구하는 문제이다. 

n의 최대값이 `200,000`이기 때문에 `O(n^2)`으로는 풀 수 없는데, 식을 `arr[j] - j == arr[i] - i`로 정리하면 시간 내에 문제를 해결할 수 있다. map 컨테이너를 사용해서 현재값과 인덱스의 차이가 같은 값들을 더해나가면 된다.

```c++
#include <iostream>
#include <algorithm>
#include <vector>
#include <map>

using namespace std;

using ll = long long;

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
int main(){
    quick_IO();
    int t;
    cin>>t;
    while(t--){
        ll answer = 0l;
        int n;
        int temp;
        cin>>n;
        map<ll, ll> arr;
        for (int i = 0; i < n; ++i) {
            cin>>temp;
            answer += arr[temp-i];
            arr[temp-i]++;
        }

        cout<<answer<<"\n";
    }
    return 0;
}
```

각 테스트케이스의 시간 복잡도는 `O(n)`이다.
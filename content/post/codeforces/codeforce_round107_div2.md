---
title: "Codeforce round #107 div2 upsolving" # Title of the blog post.
date: 2021-04-14T00:23:20+09:00 # Date of post creation.
description: "Codeforce round div2" # Description used for search engine.
featured: false # Sets if post is a featured post, making appear on the home page side bar.
draft: false # Sets whether to render this page. Draft of true will not be rendered.
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
#featureImage: "/images/path/file.jpg" # Sets featured image on blog post.
#thumbnail: "/images/path/thumbnail.png" # Sets thumbnail image appearing inside card on homepage.
shareImage: "/images/path/share.png" # Designate a separate image for social media sharing.
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Algorithm
tags:
  - codeforces
# comment: false # Disable comment if false.
---
> C번까지 풀어보고 시험이 끝나고 E번까지 다시 풀어보겠습니다.

# 1. Review Site

문제가 좀 거창하게 쓰여있는데 그냥 1, 3일 때만 count해서 출력하면 되는 아주 간단한 문제다. 1번은 항상 문제를 이해하느라 시간을 많이 쓰는데 빨리 읽는 연습도 해야될 것 같다.
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
int types[51];

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}


int main(){
    quick_IO();
    int t;
    int i, j, k;
    cin>>t;

    while(t--){
        int n, temp;
        int answer = 0;
        cin>>n;
        for(i = 0;i<n;i++){
            cin>>temp;
            if(temp == 1) answer++;
            if(temp == 3) answer++;
        }
        cout<<answer<<"\n";
    }
    return 0;
}
```
# 2. GCD Length

두 수의 자리수 a, b와 그 둘의 최대공약수의 자리수 c가 입력으로 들어올 때 자리수를 만족하는 (a, b, c)를 구하면 된다. 

처음에 떠오른 생각은 아래와 같다.

1. 에라토스테네스 체로 `10^9`까지 소수를 모두 구한 다음 각 자리수 별로 가장 작은 소수를 정한다.
2. c로 들어온 자리수에 맞는 가장 작은 소수를 구하고 a, b에 맞는 자리수의 값이 되도록 다른 소수들은 곱해나간다.

이 풀이는 1번부터 TLE가 날 게 뻔하기 때문에 코드조차 못 짜고 다음 문제로 넘어갔다.

얼마 뒤에 올라온 공식 풀이를 보니 테스트케이스 하나당 `O(1)`으로 처리해준다고 한다.

만들어야하는 수 x, y의 형태를 아래와 같이 고정시켜놓는다.

 - `x = 10..00..0`
 - `y = 11..10..0`

x, y 둘 다 맨 앞에 있는 1은 고정시켜놓고 x는 나머지 값들을 전부 0으로 만들고, y는 마지막 c-1번째 숫자들만 0으로 처리한다. 그렇게 하면 두 수의 gcd는 `10^(c-1)`이다.

풀이를 보고 많이 허탈한 문제...

# 3. Yet Another Card Deck

1~50의 값을 가진 n개의 카드가 있다. m개의 쿼리가 들어오는데 쿼리가 하는 일은 쿼리의 값을 가진 카드를 카드 덱에서 찾은 다음 인덱스를 출력하고 카드 덱의 맨 앞으로 보내는 것이다. 

일단 각 번호별로 몇 번째 인덱스에서 처음 등장하는지 알아야 한다. 이건 카드 덱을 입력받으면서 `firstEx`배열에 저장해두었다. 이후 쿼리를 받는데 쿼리값이 처음으로 등장하는 인덱스를 바로 출력해주고, 그 인덱스보다 앞에서 처음 등장하는 값들을 모두 1씩 더해준다. 여기서 다행히 등장하는 값의 범위가 1~50이기 때문에 시간복잡도는 `O(50*m)`이고 TLE가 발생하지 않는다.

다른 풀이를 찾아보니 세그먼트 트리로 푸는 방법이 정석인 것 같다.
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
const int MAX = 300000;
int colors[MAX+1];
int firstEx[51];
int isNotFirst[51];
inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}


int main(){
    quick_IO();
    int n, q;
    int i, j, k;
    int temp;
    cin>>n>>q;
    for(i=0;i<n;i++){
        cin>>temp;
        colors[i] = temp;
        if(!isNotFirst[temp]){
            firstEx[temp] = i+1;
            isNotFirst[temp] = true;
        }
    }
    // for(i=0;i<n;i++) cout<<firstEx[i]<<" ";
    int query;
    for(i=0;i<q;i++){
        cin>>query;
        cout<<firstEx[query]<<" ";
        for(j=1;j<=50;j++){
            if(firstEx[j]< firstEx[query]) firstEx[j]++;
        }
        firstEx[query] = 1;
    }

    return 0;
}
```
# 6 결론

이번 라운드에서 느낀점은

- 문제를 빠르게 읽고 이해해야한다.
- 코드포스에는 수학 관련 문제가 많다.
- A번은 생각보다 단순한 문제가 많이 출제된다.
- 세그먼트 트리를 공부해야겠다.

이렇게 4가지로 정리할 수 있다.
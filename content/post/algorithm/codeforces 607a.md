---
title: "Codeforces 607A" # Title of the blog post.
date: 2021-04-08T19:00:24+09:00 # Date of post creation.
description: "Codeforces 602A 문제풀이" # Description used for search engine.
featured: true # Sets if post is a featured post, making appear on the home page side bar.
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
  - C++
  - dp
math: true
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/607/problem/A

# 1. 문제 정리 및 접근

n개의 비콘과 각 비콘에 맞는 파워가 존재한다. 해당 비콘이 활성화되면 해당 파워의 거리에 있는 모든 왼쪽의 비콘들은 폭파되어 활성화될 수 없다. 이때 가장 오른쪽의 비콘보다 무조건 오른쪽에 하나의 비콘이 추가된다고 할 때 최대로 비콘을 활성화할 수 있는 개수를 구하는게 문제이다. 단, 추가되는 비콘의 좌표와 파워는 어떤 값이든 상관없다.

## 1.1 입력

테스트케이스 예제들은 좌표로 정렬된 값이 들어오지만, 입력이 정렬되어 있다는 말이 문제에 없기 때문에 입력을 정렬해줘야 한다.

```
> n
> a1 b1
> a2 b2
> ...
> an bn
```

a: 비콘의 좌표

b: 비콘의 파워

a는 0이상 1,000,000이하의 값을 가질 수 있고, b는 1이상 1,000,000이하의 값을 가질 수 있다. 여기서 같은 좌표에는 무조건 하나의 비콘만 들어갈 수 있다.

## 1.2 출력

가장 오른쪽에 비콘을 추가해서 최대로 비콘을 활성화하도록 하는데 이 때 활성화되는 비콘들의 개수를 출력한다.

# 2. 문제 해결방안 구상

가장 오른쪽 어딘가에 비콘을 추가한다는 말을 생각해보면 추가된 비콘의 파워 내에 있는 모든 비콘들은 폭파되므로 어떤 비콘을 활성화하는지 선택할 수 있다. 즉 입력으로 주어진 비콘들을 하나씩 보면서 자신의 오른쪽 비콘들을 항상 터지니까 자신이 활성화될 때 최대로 활성화 되는 비콘들의 값을 구해나가면 된다.


# 3. 코드 작성

```c++
#include <bits/stdc++.h>
#include <iostream>
#include <algorithm>
#include <vector>
#include <map>

using namespace std;

using p = pair<int, int>;

const int MAX = 1000000;
vector<p> arr;
int dp[MAX+1];

inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

bool comp(const p& a, const p& b){
    return a.first < b.first;
}

int main(){
    quick_IO();
    int n;
    cin>>n;
    arr.resize(n);
    int i;
    int position, power;
    for(i=0;i<n;i++) {
        cin>>position>>power;
        arr[i] = p(position, power);
    }
    sort(arr.begin(), arr.end(), comp);
    dp[0] = 1;
    for(i=1;i<n;i++){
        auto it = lower_bound(arr.begin(), arr.begin()+i, p(arr[i].first-arr[i].second, 0), comp);
        int num = distance(it, arr.begin()+i);
        dp[i] = dp[i - (num + 1)] + 1;
    }
    cout<<n-*max_element(dp, dp+n)<<"\n";
    return 0;
}
```

# 4. 결과 및 분석

- 현재 비콘의 좌표와 파워의 차이보다 같거나 큰 비콘들은 모두 터지니까 lower_bound를 사용해서 터지지 않는 비콘 중 가장 오른쪽에 있는 비콘을 구했다.

- 입력이 정렬되어 있다고 착각해서 첫 제출에서 `out of bounds`에러가 발생했다. pair로 값을 저장했기 때문에 pair의 첫 번째 값인 좌표로 정렬해주면 된다.


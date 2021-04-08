---
title: "Codeforces 602b" # Title of the blog post.
date: 2021-04-08T19:00:24+09:00 # Date of post creation.
description: "Codeforces 602b" # Description used for search engine.
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
  - dp
math: true
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/607/problem/A

# 1. 문제 정리 및 접근


## 1.1 입력
```
> 
> 
```


## 1.2 출력



# 2. 문제 해결방안 구상




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


# 5. 참고 자료
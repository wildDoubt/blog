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
  - two pointer
math: true
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/602/problem/B

# 1. 문제 정리 및 접근

n개의 정수 데이터가 주어진다.

연속된 데이터는 이전 값과의 차이가 항상 1보다 작아야 한다. 이 조건을 만족하는 가장 긴 연속된 배열을 찾아서 길이를 출력하면 된다.

## 1.1 입력
```
> n
> a1 a2 ... an
```

- n: 2 이상 100,000이하인 정수
- 각 a값은 1이상 100,000이하인 정수이다.

## 1.2 출력

위에서 설명한 조건을 만족하는 가장 긴 배열의 길이를 출력하면 된다.

# 2. 문제 해결방안 구상




# 3. 코드 작성

```c++
#include <iostream>
#include <algorithm>

using namespace std;

const int MAX = 100000;
int arr[MAX + 1];
int dp[MAX + 1];

inline void quick_IO() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

int main() {
    quick_IO();
    int n;
    int i;
    cin >> n;
    for (i = 0; i < n; i++) {
        cin >> arr[i];
    }
    int lo = 0;
    int hi = 1;
    int minValue = arr[0];
    int maxValue = arr[0];
    int lastMinIndex = 0;
    int lastMaxIndex = 0;
    dp[0] = hi - lo;

    for (; hi < n; hi++) {
        if (abs(minValue - arr[hi]) < 2 && abs(maxValue - arr[hi]) < 2) {
            dp[hi] = hi - lo + 1;
            if (arr[hi] <= minValue) {
                minValue = arr[hi];
                lastMinIndex = hi;
            }
            if (arr[hi] >= maxValue) {
                maxValue = arr[hi];
                lastMaxIndex = hi;
            }
        } else {
            // lo를 skip 처리할 수 있는 상황인 경우
            if (minValue != maxValue) {
                if (maxValue - 2 == arr[hi]) {
                    lo = lastMaxIndex + 1;
                    lastMaxIndex = lastMinIndex;
                    lastMinIndex = hi;
                    maxValue = minValue;
                    minValue = arr[hi];
                }
                if (minValue + 2 == arr[hi]) {
                    lo = lastMinIndex + 1;
                    lastMinIndex = lastMaxIndex;
                    lastMaxIndex = hi;
                    minValue = maxValue;
                    maxValue = arr[hi];
                }
                dp[hi] = hi - lo + 1;
                continue;
            }
            // hi부터 새로 카운트를 시작하는 경우
            minValue = arr[hi];
            maxValue = arr[hi];
            lastMaxIndex = hi;
            lastMinIndex = hi;
            lo = hi;
            dp[hi] = hi - lo + 1;
        }
    }
//    for (i = 0; i < n; i++) cout << dp[i] << " ";
    cout<<*max_element(dp, dp+n);
    cout << endl;
    return 0;
}
```


# 4. 결과 및 분석


# 5. 참고 자료
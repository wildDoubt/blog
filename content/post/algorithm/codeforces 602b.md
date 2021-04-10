---
title: "Codeforces 602B" # Title of the blog post.
date: 2021-04-08T19:00:24+09:00 # Date of post creation.
description: "Codeforces 602B 문제풀이" # Description used for search engine.
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

dp배열에는 해당 인덱스까지의 보았을 때 조건에 맞는 가장 긴 배열의 길이를 저장한다. 그러면 이전 값을 활용해서 다음 값을 보고 추가할 수 있으면 +1을 하는 방식으로 탐색하면 된다.

문제 조건에 맞는 배열의 시작과 끝을 저장하는 2개의 인덱스를 관리하면서 해당 인덱스에 포함되는 최대값과 최소값을 저장한다. 배열의 끝을 늘려나가면서 즉 하나씩 값을 추가하면서 시작 인덱스를 스킵할 수 있는 조건은 다음과 같다.

1. 추가하려는 값이 배열의 최대값 - 2인 경우

   해당 최대값이 마지막으로 등장한 인덱스 바로 다음이 시작점이 된다.

2. 추가하려는 값이 배열의 최소값 +2인 경우

    해당 최소값이 마지막으로 등장한 인덱스 바로 다음이 시작점이 된다.

위 두 조건 외에 바로 추가할 수 있는 경우와 새로 카운트하는 경우까지 판단해주면 답을 구할 수 있다.


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

`O(n^2)`으로 모든 l, r에 대해서 볼 수도 있지만 이 경우에는 시간 초과가 발생할 수 있기 때문에 투 포인터 알고리즘을 사용해야 한다. 


# 5. 참고 자료
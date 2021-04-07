---
title: "Codeforces 706C" # Title of the blog post.
date: 2021-04-08T01:37:48+09:00 # Date of post creation.
description: "Codeforces 706C" # Description used for search engine.
featured: true # Sets if post is a featured post, making appear on the home page side bar.
draft: true # Sets whether to render this page. Draft of true will not be rendered.
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
# featureImage: "/images/path/file.jpg" # Sets featured image on blog post.
# thumbnail: "/images/path/thumbnail.png" # Sets thumbnail image appearing inside card on homepage.
shareImage: "/images/path/share.png" # Designate a separate image for social media sharing.
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Algorithm
tags:
  - dp
  - string
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/706/problem/C

# 1. 문제 정리 및 접근
n개의 문자열이 차례대로 주어졌을 때 모든 문자열은 항상 이전 문자열보다 사전적으로 정렬했을 때 더 커야 한다. 즉 오름차순으로 정렬되어 있어야 한다. 두 문자열 A와 B가 있을 때 사전적으로 A가 B보다 더 작으려면 아래의 조건들을 만족해야 한다.

1. |A| < |B| 일 때

   문자열 A가 문자열 B보다 더 짧으면 항상 A가 작다.
2. |A| = |B| 일 때

   문자열 A와 B의 길이가 서로 같으면 앞에서부터 문자 하나씩 체크하면서 A의 문자가 B의 문자보다 항상 작거나 같아야 한다.

이 때, 각 문자열은 거꾸로 뒤집을 수 있다. 단, 뒤집을 때 각 문자열마다 주어진 비용이 발생한다. 문제는 모든 문자열이 사전적으로 오름차순 정렬이 되어있는 상태 중 가장 비용이 적게 발생하는 경우를 찾아 출력하면 된다.

## 1.1 입력

```
> n
> c1 c2 ... cn
> string1
> string2
> ...
> stringn
```

첫 번째 줄에 n이 들어오면 다음 줄에 각 문자열을 뒤집을 때 발생하는 비용이 c1, c2, ..., cn까지 입력으로 들어온다. 그 다음 줄부터 문자열이 n개 주어진다.

## 1.2 출력

오름차순 정렬된 상태를 만들 때 드는 모든 비용들 중 최소값을 출력하면 된다.

# 2. 문제 해결방안 구상

- 현재 인덱스를 뒤집지않았을 때 최소 비용을 저장하는 DP배열과 현재 인덱스를 뒤집었을 때 최소 비용을 저장하는 rDP 배열을 선언한다. 여기서 비용의 최대값은 `10^9`이고 `n`의 최대값은 `100,000`이니까 int로 두 배열을 선언하면 오버플로우가 발생할 수 있기 때문에 `long long` 자료형을 사용했다.

- 문자열은 입력받는 대로 뒤집은 문자열 배열도 함께 만들어준다. 

- 현재 인덱스를 k라고 했을 때 DP[k]를 만드는 방법부터 생각해보자. k-1을 뒤집지 않았을 때의 최소값과 k-1을 뒤집었을 때의 최소값 중 더 작은 값을 선택하면 DP[k]가 된다. 여기서 -1인 경우와 현재 보고 있는 문자열을 포함했을 때 정렬되지 않은 경우에는 값을 갱신해주면 안 된다.

  `DP[k] = min(DP[k-1], rDP[k-1])`

  rDP[k]를 만드는 방법도 위와 비슷하다. 다만 현재 보고 있는 문자열을 뒤집기 때문에 cost[k]까지 고려해줘야 한다.


# 3. 코드 작성

```c++
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

using ll = long long;

const int MAX = 100000;
ll cost[MAX + 1];
string strings[MAX + 1];
string rStrings[MAX + 1];
ll DP[MAX + 1];
ll rDP[MAX + 1];
int n;

inline void quick_IO() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

bool isSort(string a, string b) {
    if (a.compare(b) <= 0) return true;
    return false;
}

int main() {
    quick_IO();
    int i;
    cin >> n;
    fill(DP, DP + n + 1, 10e+15);
    fill(rDP, rDP + n + 1, 10e+15);
    for (i = 1; i <= n; i++) {
        cin >> cost[i];
    }
    for (i = 1; i <= n; i++) {
        cin >> strings[i];
        rStrings[i] = string(strings[i].rbegin(), strings[i].rend());
    }
    DP[1] = 0;
    rDP[1] = cost[1];
    for (i = 2; i <= n; i++) {
        if (DP[i - 1] != -1 && (isSort(strings[i - 1], strings[i]))) {
            DP[i] = min(DP[i], DP[i - 1]);
        }
        if (rDP[i - 1] != -1 && (isSort(rStrings[i - 1], strings[i]))) {
            DP[i] = min(DP[i], rDP[i - 1]);
        }
        if (DP[i] == 10e+15) DP[i] = -1;
        if (DP[i - 1] != -1 && (isSort(strings[i - 1], rStrings[i]))) {
            rDP[i] = min(rDP[i], DP[i - 1] + cost[i]);
        }
        if (rDP[i - 1] != -1 && (isSort(rStrings[i - 1], rStrings[i]))) {
            rDP[i] = min(rDP[i], rDP[i - 1] + cost[i]);
        }
        if (rDP[i] == 10e+15) rDP[i] = -1;
    }
    if (min(DP[n], rDP[n]) != -1) {
        cout << min(DP[n], rDP[n]);
    }
    else {
        if (DP[n] == -1) cout << rDP[n];
        else if (rDP[n] == -1) cout << DP[n];
        else cout << -1;
    }
    cout << "\n";
    return 0;
}
```

# 4. 결과 및 분석

dp설계는 제대로 한 것 같은데 처음 제출했을 때 Wrong answer가 떴다. 

이유를 찾기 위해 우선순위를 다음과 같이 잡고 직접 생각하면서 디버깅 해보았다.

1. 산술 오버플로우

   int형으로 배열을 만들었을 때 산술 오버플로우가 발생할 수 있는 cost배열과 관련된 연산을 하는 부분이 전부 long long으로 처리되고 있는지 확인함.

2. dp배열과 rdp배열을 채워나가는 과정

   비슷한 케이스가 4개를 다뤄야 해서 구현할 때 많이 헷갈렸고, 머리로 디버깅할 때 꼼꼼히 체크해서 몇몇 군데 오류가 있는 부분을 고쳤다.

3. 최종적으로 답을 출력하는 부분

   dp배열과 rdp배열을 비교하는 조건식에 오류가 있어서 알맞게 고쳤다.

4. 두 문자열의 크기를 비교하는 함수

   처음에는 쉽게 구현할 수 있을 줄 알고 자신있게 구현했다가 실패해서 string 헤더에 있는 compare함수로 바꾸었다.

위의 4가지 사항을 확인하고 문제에서 주어진 모든 테스트케이스를 통과한 것을 확인하고 제출하고 Accept를 받았다. 당장 어떻게 구현할 지 아이디어가 떠올랐어도 한 번 더 침착하게 확인하는 습관을 들여야 할 것 같다. 

원래 dp를 사용할 때 배열의 이름을 dp라고 소문자로 짓는데, 그렇게 하면 r을 붙였을 때 이상해서 DP, rDP로 배열 이름을 바꿨다.


# 5. 참고 자료


---
title: "백준 1005번 ACM Craft"
date: 2021-08-26T00:07:21+09:00
description: "백준 1005번 ACM Craft 풀이"
featured: true
draft: false
toc: false
codeMaxLines: 100
codeLineNumbers: true
figurePositionShow: true
categories:
  - Algorithm
tags:
  - dp
---

문제: https://www.acmicpc.net/problem/1005

# 1. 문제 정리 및 접근

한 건물을 짓기 위해서는 필요한 건물들이 이미 지어져 있어야 한다. 대학교의 선수과목과 비슷한 개념이라고 생각하면 되는데 두 건물의 관계를 이용해서 건물 W를 건설하는데 드는 최소 시간을 구하면 된다.

# 2. 문제 해결방안 구상

parent 배열에 각 건물마다 필요한 건물을 벡터로 저장해서 DFS로 탐색하면 된다. 이 때 필요한 건물들 중 가장 오래 걸리는 건물을 짓는데 드는 시간과 W를 짓는데 필요한 시간을 더해주면 되는데 이를 재귀적으로 처리해주면 된다.

# 3. 코드 작성

```c++
#include <iostream>
#include <algorithm>

using namespace std;

inline void Quick_IO() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

int dp[1001];
int times[1001];
vector<int> parents[1001];

int calc(int target) {
    int &ret = dp[target];
    if (ret != -1) {
        return ret;
    }
    int result = times[target];
    int maxValue = 0;
    for (auto parent:parents[target]) {
        maxValue = max(maxValue, calc(parent));
    }
    return ret = result + maxValue;
}

int main() {
    Quick_IO();
    int T;
    cin >> T;

    while (T--) {
        for (auto &parent : parents) {
            parent.clear();
        }

        int N, K, W;

        cin >> N >> K;
        fill(dp + 1, dp + N + 1, -1);
        for (int i = 1; i <= N; ++i) {
            cin >> times[i];
        }
        for (int i = 0, x, y; i < K; ++i) {
            cin >> x >> y;
            parents[y].push_back(x);
        }
        cin >> W;
        cout << calc(W) << '\n';

    }

    return 0;
}
```


# 4. 결과 및 분석

동시에 건물을 지을 수 있다는 조건과 문제에서 주어진 그림 덕분에 쉽게 풀 수 있었던 문제인 것 같다.

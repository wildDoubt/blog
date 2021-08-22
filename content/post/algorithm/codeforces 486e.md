---
title: "Codeforces 486e" # Title of the blog post.
date: 2021-05-01T22:03:00+09:00 # Date of post creation.
description: "Codeforces 486E 문제풀이" # Description used for search engine.
featured: false # Sets if post is a featured post, making appear on the home page side bar.
draft: false # Sets whether to render this page. Draft of true will not be rendered.
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
  - LIS
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/486/problem/E

# 1. 문제 정리 및 접근
최대 100000길이를 가질 수 있는 배열이 주어졌을 때 현재 원소가 LIS에 어떤 방식으로 포함되어 있는지 출력하는 문제이다. 여기서는 총 3가지 경우에 따라 1, 2, 3을 출력한다.

  1. 어떤 LIS에도 속하지 않은 경우
    2. LIS에 하나 이상 속하지만 모든 LIS에 속해있지 않은 경우
    3. 가능한 모든 LIS에 속해있는 경우

# 2. 문제 해결방안 구상

현재 원소가 LIS에 속해있는지 판단하기 위해서는 현재 원소가 시작점일 때와 끝점일 때의 LIS 길이를 알아야 한다. 그러면 전체 배열의 LIS 길이와 비교해서 현재 원소가 LIS에 속해있는지 판단할 수 있다.

먼저

`F1[i]: i번째 원소가 끝점일 때의 LIS 길이 `

`F2[i]: i번째 원소가 시작점일 때 LIS 길이 `

이렇게 정의하자.

- 1의 경우가 되기 위해서는 `F1[i] + F2[i]`가 전체 LIS길이 - 1이 되어야 한다.
- 위의 경우가 아닐 때 선택한 원소의 왼쪽에는 자신보다 크거나 같은 `F1[u]`값이 있어서는 안 되고, 오른쪽에는 자신보다 작거나 같은 `F2[v]` 값이 있어서는 안 된다. 이 경우는 3이 되고 만약 앞에서 언급한 조건을 하나라도 만족하지 못하면 2의 경우가 된다. (`1<=u<i<v<=N`)

다음과 같은 배열을 생각해보자.

![](/images/codeforces_486e_img.png)

여기서 4번째 원소인 3이 어떤 경우에 속하는지 알아보자.

![](/images/codeforces_486e_img1.png)

빨간색 원은 해당 원소가 끝점일 때의 LIS원소이고 파란색 원은 해당원소가 시작점일 때의 선택한 LIS원소이다. 

먼저 왼쪽에서 LIS에 속하고 3보다 크거나 같은 `F1[u]`값이 있으면 해당 원소는 2의 경우로 처리하면 된다. 이런 경우는 현재 원소를 포함하지 않고도 LIS를 만들 수 있다는 말이니까 2의 경우라고 생각하면 된다. 마찬가지로 오른쪽에서도 LIS에 속하는 원소중 2보다 작거나 같은 `F2[v]`값이 있으면 해당 원소는 2의 경우로 처리하면 된다. 

![](/images/codeforces_486e_img2.png)

해당 예시에서 `F1`과 `F2`를 구한 배열인데 여기서 우리가 살펴봐야 할 부분은 빨간색 원과 파란색 원이다. 각각 2번씩 N번 반복해주면 2의 경우를 걸러낼 수 있다.


# 3. 코드 작성

```c++
#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

const int INF = 0x66554433;
const int MAX = 100000;
int lisLengths[MAX];
int reverseLisLengths[MAX];
int answer[MAX+1];
int arr[MAX+1];
int rArr[MAX+1];
inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
void calc(int arr1[], vector<int> lis, int n, bool reverse = false){
    lis.clear();
    lis.push_back(-1);
    for(int i = 0;i<n;i++){
        if(arr1[i] > lis.back()){
            lis.push_back(arr1[i]);
        }
        auto it = lower_bound(lis.begin(), lis.end(), arr1[i]);
        *it = arr1[i];
        if(!reverse) lisLengths[i] = (it-lis.begin());
        else reverseLisLengths[n-i-1] = (it-lis.begin());
    }
}
int main(){
    quick_IO();
    int N, i;
    int lMax, rMin;
    vector<int> lis;
    lis.push_back(-INF);
    cin>>N;

    for(i=0;i<N;i++) {
        cin>>arr[i];
    }
    calc(arr, lis, N);
    for(i = 0;i<N;i++){
        rArr[N-i-1] = INF - arr[i];
    }
    calc(rArr, lis, N, true);

    for(i=0;i<N;i++) answer[i] = 1;
    int l = *max_element(lisLengths, lisLengths+N);

    for(i=0;i<N;i++){
        if(lisLengths[i] + reverseLisLengths[i]-1 == l) answer[i] = 3;
    }
    lMax = 0;
    for(i=0;i<N;i++){
        if(answer[i]!=1){
            if(arr[i]<=lMax) answer[i] = 2;
            lMax = max(lMax, arr[i]);
        }
    }

    rMin = INF;
    for(i=N-1;i>=0;i--){
        if(answer[i]!=1){
            if(arr[i]>=rMin) answer[i] = 2;
            rMin = min(rMin, arr[i]);
        }
    }
    for(i=0;i<N;i++) cout<<answer[i];
    return 0;
}
```


# 4. 결과 및 분석

해당 원소까지의 최대 LIS의 길이는 구할 수 있었는데 끝점이거나 시작점일 때의 LIS 길이를 구할 수 있는 방법은 모르고 있었다. 이번 문제를 풀면서 lower_bound로 들어가는 index가 각각 LIS 길이가 된다는 것을 알 수 있었다. 


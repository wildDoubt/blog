---
title: "Codeforces 219d" # Title of the blog post.
date: 2021-04-22T15:31:23+09:00 # Date of post creation.
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
  - DFS
  - C++
# comment: false # Disable comment if false.
---

문제: https://codeforces.com/contest/219/problem/D

# 1. 문제 정리 및 접근

n개의 도시가 있을 때 단방향의 도로가 주어진다. 수도가 될 수 있는 도시는 그 도시에서 다른 모든 도시로 갈 수 있어야 한다. 이 조건을 만족하기 위해 도로의 방향을 뒤집을 수 있는데 가장 적게 도로를 뒤집는 횟수를 구하고 해당 횟수만 뒤집어서 수도가 될 수 있는 모든 도시를 출력하는 문제이다.

## 1.1 입력

```
> n
> s1, t1
> ...
> s(n-1), t(n-1)
```
수도의 개수 n을 입력받고 다음 n-1개의 줄에서 출발하는 도시와 도착하는 도시를 연결하는 도로를 입력받는다.

## 1.2 출력

가장 적게 도로를 뒤집어서 수도가 될 수 있는지 판단하고 해당 도시를 출력한다.

# 2. 문제 해결방안 구상

각각을 루트로 잡고 문제를 접근해보니 n의 최대 개수가 200000이기 때문에 시간 초과가 날 것 같았다. 그래서 모든 노드에 대해서 각자 구하는 방법은 배제하고 임의의 루트를 잡는 방법을 생각해보았다.

- 현재 노드와 루트까지의 경로를 무조건 반대방향으로만 이루어지게 만들고 나머지는 전부 내려가는 방향으로 만들면 된다.

이를 수식으로 나타내보자.

`노드 X가 최소로 뒤집는 횟수 = 루트부터 노드 X까지 순방향으로 내려가는 도로의 개수 - 나머지 모든 도로의 역방향 도로의 개수`

만약 아래와 같은 입력이 주어졌다고 하자. 

```
8
1 3
1 2
4 1
8 4
2 5
6 3
7 3
```
여기서 1을 루트로 잡고 트리를 그려보면
![img](/static/images/codeforces_219d_img.png)
위와 같이 나온다.

노드 8을 수도로 잡았을 때 도로를 최소한으로 뒤집는 개수를 구해보자. 위에서 정의한 공식을 사용하면 아래와 같이 바꿀 수 있다. 

![img1](/static/images/codeforces_219d_img1.png)

DFS로 각 노드의 level과 해당 노드로 갈 때 몇개의 역방향 도로가 존재하는지 구하고 최종적으로 답을 구할 수 있다.

# 3. 코드 작성

```c++
#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

using namespace std;
using p = pair<int, int>;

const int MAX = 200000;
vector<p> adj[MAX+1];
int dist[MAX+1];
int backOnNode[MAX+1];
int totalBack;
inline void quick_IO(){
    ios_base :: sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}
int dfs(int prevNode, int currNode, int level, int back){
    dist[currNode] = level;
    backOnNode[currNode] = back;
    int childBack = 0;
    for(auto x:adj[currNode]){
        if(x.first!=prevNode){
            if(x.second){
                childBack += dfs(currNode, x.first, level+1, back+1)+1;
            }else{
                childBack += dfs(currNode, x.first, level+1, back);
            }
        }
    }
    return childBack;
}
int main(){
    quick_IO();
    int n;
    int i;
    cin>>n;
    int a, b;
    for(i=0;i<n-1;i++){
        cin>>a>>b;
        adj[a].emplace_back(b, 0);
        adj[b].emplace_back(a, 1);
    }
    vector<p> answer;
    totalBack = dfs(-1, 1, 0, 0);
    for(i=1;i<=n;i++){
        answer.emplace_back(dist[i] - backOnNode[i] + (totalBack - backOnNode[i]), i);
    }
    sort(answer.begin(), answer.end(), less<>());
    int temp = answer[0].first;
    cout<<temp<<"\n";
    for(auto x:answer){
        if(temp!=x.first) break;
        cout<<x.second<<" ";
    }
    cout<<"\n";

    return 0;
}
```


# 4. 결과 및 분석

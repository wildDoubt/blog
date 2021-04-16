---
title: "Codeforces Round #713 Div3 upsolving" # Title of the blog post.
date: 2021-04-11T22:36:57+09:00 # Date of post creation.
description: "Codeforces Round #713 Div3" # Description used for search engine.
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
  - codeforces
# comment: false # Disable comment if false.
---

> 코드포스 div3 716라운드 중 못 푼 문제들을 다시 풀어보겠습니다. E, F, G 문제는 중간고사가 끝난 후 갱신할 예정입니다.

# 1. 1512A - Spy Detected

배열 중 한 값만 중복이 아닌 값이 들어오는데 이 값의 인덱스를 찾아내는 문제다. key는 입력값, value는 배열에 나타난 횟수로 map을 만들고 value값을 기준으로 오름차순 정렬을 했다. 그러면 첫 번째 값에 찾고자 하는 index가 있으니까 이를 원래 배열의 인덱스를 찾아서 출력하면 된다.

# 2. 1512B - Almost Rectangle

2차원 배열형태로 `.`또는 `*` 2가지 입력만 들어오는데 `*`은 정확히 2개만 입력으로 들어온다. 이 때 `*`로 사각형을 만들어서 출력하면 된다. 단순 구현문제이다.

# 3. 1512C - A-B Palindrome

입력은 `0, 1, ?` 세 가지만 들어오는데 `?`에는 0과 1 둘 중 하나만 들어갈 수 있다. 전체 문자열에서 0의 개수와 1의 개수가 정해져 있을 때 palindrome 문자를 만들어 출력하는 문제다. 양쪽 인덱스를 확인하면서 무조건 0과 1이 대칭되도록 만들고 만들 수 없으면 -1을 바로 출력하면 된다. 

내가 해결한 흐름은 다음과 같다.

## 3.1 ?랑 짝지어 주기

1. 일단 들어온 문자를 양쪽에서 확인해주면서 둘 중 하나만 ?인 경우 짝과 같은 문자로 바꾸어준다. 이때 짝과 다른 숫자가 발견되면 바로 -1을 리턴한다.
2. 위의 처리가 끝나면 0의 개수와 1의 개수에 해당하는 값을 빼준다.
3. 위에서 문자열의 길이가 홀수인 경우에 중앙값은 확인하지 않아서 따로 중앙값을 확인해준다.
4. 0의 개수와 1의 개수를 저장하는 변수의 값이 음수면 -1을 리턴한다.

## 3.2 ?에 값 채워넣기

1. 3.1의 과정이 끝나면 ?쌍들만 존재하기 때문에 0 또는 1로 값을 채워넣고 필요한 0의 개수와 1의 개수에 모순이 발생하면 -1을 리턴한다.
2. 문자열의 길이가 홀수이고 만약 중앙에 ?가 있으면 어떤 값이 들어가도 상관없기 때문에 이를 처리한다.
3. 마지막으로 홀수 중앙값을 처리한다.

## 3.3 출력

위의 과정을 모두 다 거친 후, a와 b가 둘 다 0일 때 답을 출력하고 아니면 -1을 출력한다.



조건을 신경쓰느라 시간을 많이 썼는데 이건 문제를 많이 풀면서 익숙해지는 것말고는 따로 방법이 없을 것 같다.

# 4. 1512D - Corrupted Array

이 문제는  `O(n^2)`으로 풀 수 있는 아이디어밖에 생각나지 않아서 못 풀었다. 먼저 `x`값을 정하고 `x`값을 제외한 배열에서 다시 하나씩 보면서 자신을 제외한 나머지 값들의 합이 자신이 되는 인덱스를 찾으면 된다. 여기서 n의 최대값은 200,000이기 때문에 분명히 TLE가 날거라 생각하고 시도하지 않았고 editorial을 참고해서 어떻게 해결하는지 알아보았다.

## 4.1 풀이

x로 임의의 값을 지우기 때문에 입력으로 주어지는 배열 b의 합은 2a + x이다. 이 사실을 이용해서 문제를 해결할 수 있다.

1. 먼저 multiset have에 b의 배열을 넣어주고 sum에 b배열의 합을 저장한다.
2. b의 배열을 순서대로 x값이라고 가정하고 반복문을 돌린다. have에 x값을 빼고 sum에서 x값을 뺀다.
3. have에서 sum/2한 값이 있는지 찾았으면 sum/2값을 have에서 제거한 후 출력한다.
4. sum/2한 값이 없으면 sum과 have를 복구시킨후 다시 반복한다.

위 풀이는 시간복잡도는 n번 돌면서 find를 해주기 때문에 `O(nlogn)`이다.
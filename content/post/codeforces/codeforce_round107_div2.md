---
title: "Codeforce round 107 div2" # Title of the blog post.
date: 2021-04-14T00:23:20+09:00 # Date of post creation.
description: "Codeforce round div2" # Description used for search engine.
featured: true # Sets if post is a featured post, making appear on the home page side bar.
draft: true # Sets whether to render this page. Draft of true will not be rendered.
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
#featureImage: "/images/path/file.jpg" # Sets featured image on blog post.
#thumbnail: "/images/path/thumbnail.png" # Sets thumbnail image appearing inside card on homepage.
shareImage: "/images/path/share.png" # Designate a separate image for social media sharing.
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Technology
tags:
  - Tag_name1
  - Tag_name2
# comment: false # Disable comment if false.
---
>시험기간이지만 갑자기 꽂혀서 이틀 연속 대회에 참가하게 되었습니다. D번까지 풀어보고 시험이 끝나고 E번까지 다시 풀어보겠습니다.

# 1. Review Site

문제가 좀 거창하게 쓰여있는데 그냥 1, 3일 때만 count해서 출력하면 되는 아주 간단한 문제다. 1번은 항상 문제를 이해하느라 시간을 많이 쓰는데 빨리 읽는 연습도 해야될 것 같다.

# 2. GCD Length

두 수와 그 둘의 최대공약수의 자리수가 입력으로 들어올 때 자리수를 만족하는 값들을 구하면 된다. 

처음에 떠오른 생각은 아래와 같다.

1. 에라토스테네스 체로 `10^9`까지 소수를 모두 구한 다음 각 자리수 별로 가장 작은 소수를 정한다.
2. c로 들어온 자리수에 맞는 가장 작은 소수를 구하고 a, b에 맞는 자리수의 값이 되도록 다른 소수들은 곱해나간다.

이 풀이는 1번부터 TLE가 날 게 뻔하기 때문에 코드조차 못 짜고 다음 문제로 넘어갔다.

수학은 제일 싫어하는 유형 중 하나인데 코드포스에서 높은 점수를 따려면 어쩔 수 없이 해야한다.

# 3. Yet Another Card Deck

# 6 결론

이번 라운드에서 느낀점은

- 문제를 빠르게 읽고 이해해야한다.
- 수학 관련 문제가 많다.
- A번은 꽤 단순한 문제가 많이 출제된다.

이렇게 3가지로 정리할 수 있다.
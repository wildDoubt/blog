---
title: "PyQt5로 간단한 이미지처리 프로그램 제작" # Title of the blog post.
date: 2021-04-10T23:09:03+09:00 # Date of post creation.
description: "Python GUI 프레임워크로 이미지처리 프로그램 제작" # Description used for search engine.
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
  - image processing
tags:
  - python
  - pyqt5
# comment: false # Disable comment if false.
---

> 학교 수업으로 이미지 처리에 대해 배우고 있는데 이를 한 프로그램에 넣어서 테스트하면 좋겠다는 생각이 들어 제작하게 되었다. 1차적인 목표는 사진을 프로그램에 올리면 다양한 이미지 처리를 할 수 있도록 하는 것이다. 추가적으로 drag and drop기능이나 여러 사진을 동시에 처리하는 등의 기능도 시간이 난다면 추가할 예정이다. GUI Framework는 참고할 한글 자료가 있는 PyQt5를 선택하였다.

# 1. 환경 설정

아나콘다를 설치 후 파이참에서 프로젝트를 생성하였다. 

# 2. 
---
title: "Hugo로 블로그 개설하는 방법"
date: 2021-04-03T14:34:24+09:00
draft: false
---

# Hugo로 블로그 만드는 방법
> test
> test1
> test2
> test3
## 1. 깃허브 저장소 만들기

- Hugo의 컨텐츠를 저장할 저장소: wildDoubt/blog로 생성

- github.io 저장소 생성: wildDoubt/github.io로 생성

## 2. Hugo 설치

- https://github.com/gohugoio/hugo/releases 여기서 os에 맞게 hugo를 다운받는다.(extended 버전은 SASS/SCSS를 지원해준다고 함.)

- `C:\Hugo\bin` 폴더를 생성한다.

- 해당 폴더에 위에서 다운받은 파일을 풀어서 넣어준다.

- 시스템 속성 창을 열어서 환경 변수(Path)에 `C:\Hugo\bin`을 등록해준다. (Win + R -> `sysdm.cpl ,3` 하면 바로 시스템 속성 창이 열린다.)

- cmd창을 열어서 `hugo version`을 입력한 후 제대로 뜨는지 확인하자.

## 3. 테마 적용

- https://themes.gohugo.io/ 에서 고른 테마를 submodule로 추가해준다.
- `config.toml`에 내가 고른 테마의 이름을 `theme = "inkblotty"` 이런 형태로 추가해준다.

## 4. 컨텐츠 생성

- `hugo new post/test.md`로 새로운 컨텐츠를 생성할 수 있다.
- cmd에서 `hugo server` 또는 `hugo server -D`로 컨텐츠를 확인할 수 있다.
- -D는 draft가 true인 문서들도 보이는 옵션이다.
- `C:\Hugo\blog`, `C:\Hugo\blog\publish` 둘 다 commit하고 push하기.


# 참고한 자료

1. https://github.com/Integerous/Integerous.github.io
2. https://github.com/tosi29/inkblotty/
3. https://ialy1595.github.io/post/blog-construct-2/
4. https://gohugo.io/categories/getting-started
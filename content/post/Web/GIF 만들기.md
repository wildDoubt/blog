---
title: "스크린 캡쳐를 이용하여 GIF 만들기 1"
date: 2021-07-20T00:30:34+09:00
description: "Convert Screen Capture to GIF"
featured: true
draft: true
toc: false
codeMaxLines: 100
codeLineNumbers: true 
figurePositionShow: true 
categories:
  - Web
tags:
  - Javascript
  - FFmpeg
# comment: false # Disable comment if false.

---

# 제작 계기

 React로 간단하게 만든 webgame의 시연 영상을 README에 첨부하려면 GIF로 변환해야 했다. 화면 녹화를 해서 mp4파일을 만들고 이 파일을 GIF로 변환하고 최종적으로 원하는 부분만 잘라내는 과정이 생각보다 귀찮았고 한 번에 할 수 있도록 프로그램을 만들면 편하겠다는 생각이 들었다.

# 개발 플랫폼 선택

 Electron으로 만들고 싶었는데 빠르게 결과물을 내고 싶어서 며칠 전부터 공부하던 **React**로 만들기로 했다. Javascript가 어느정도 익숙해지면 데스크탑 앱으로 만들어 볼 예정이다.

 # 초기 설정

 Create React App으로 초기 프로젝트 설정을 하고 추가로 ESLint + Pretierr를 설정했다. 팀 단위로 작업할 때 코딩 스타일을 통일시켜주는 라이브러리는 필수이기 때문에 혼자 작업하더라도 두 라이브러리에 익숙해져야 할 것 같아서 설치했다. 

# 프로젝트 구조

```bash
GIF_PROJECT
│  App.jsx
│  index.css
│  index.js
│  logo.png
│  reportWebVitals.js
│  
├─Data
│      Menu.jsx
│      
├─Plugins
│  ├─Downloader
│  │      index.js
│  │      
│  ├─FFmpeg
│  │      index.js
│  │      
│  └─ScreenRecorder
│          index.js
│          
└─view
    ├─App
    │      AppContent.jsx
    │      AppFooter.jsx
    │      AppHeader.jsx
    │      
    └─GIF-Maker
            Config.jsx
            GIFMaker.jsx
            StreamPreview.jsx
            
```

초기 구조는 Data, Plugins, view로 나누었다. Data에는 라우팅에 필요한 메뉴 데이터를 넣었고 Plugins에는 화면 녹화나 gif로 변환하는 등 클라이언트에서 작업하는 기능을 모았다. view는 React 컴포넌트로만 이루어질 수 있도록 구성하였다. 이후 확장성을 고려하여 라우팅 구조와 폴더 구조를 최대한 일치시켰다.

# 고민사항

### 1. 이후 추가될 컨텐츠를 고려해서 라우팅과 폴더 구조를 깔끔하게 정리할 수 있을까?
App.js는 Header, Content, Footer로 구성되어 있는데 AppContent에서 라우팅을 할 수 있도록 분리시켰다.
```javascript
// AppContent.jsx
...
<Switch>
  <Route exact path="/">
    <Redirect to={DEFAULT_MENU} />
  </Route>
  <Route path={`/${DEFAULT_MENU}`} component={GIFMaker} />
</Switch>
...
```
`react-router-dom`을 사용해서 컨텐츠의 내용만 바뀔 수 있도록 구성하였다. 
### 2. mp4 또는 gif  파일의 다운로드를 관리하는 클래스 생성

### 3. 클라이언트에서 바로 mp4 -> gif 변환을 할 수 있을까?

### 4. 현재 윈도우 창 사이즈가 바뀌면 따라서 컨텐츠의 사이즈를 동적으로 바꿀 수 있을까?

# 에러

### 1. ffmpeg 를 load할 때 발생하는 문제

로컬 환경에서 ffmpeg 라이브러리를 로드하는 경우 에러가 발생했는데

https://github.com/ffmpegwasm/ffmpeg.wasm#why-it-doesnt-work-in-my-local-environment

여기서 바로 해결할 수 있었다.






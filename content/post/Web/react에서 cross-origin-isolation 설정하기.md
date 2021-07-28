---
title: "React에서 cross-origin-isolation 설정하기" # Title of the blog post.
date: 2021-07-28T23:53:28+09:00 # Date of post creation.
description: "Apply COOP and COEP in react apps" # Description used for search engine.
featured: true
draft: false
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - Web
tags:
  - react
# comment: false # Disable comment if false.
---

# 문제 상황

FFMpeg 웹 어셈블리 라이브러리를 사용하고 있는데 어느 날 갑자기 load가 안되는 문제가 발생했다.  https://developer.chrome.com/blog/enabling-shared-array-buffer/ 여기서 원인을 알 수 있었는데 간단하게 요약하자면 크롬 92 버전부터 [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)를 브라우저에서 사용하기 위해서 cross-origin-isolated 한 환경으로 만들어줘야 한다고 한다.

# 해결 방법

구글링을 해보니 https://web.dev/coop-coep/ cross-origin 환경이 왜 중요하고 어떻게 개인 서버에 적용하는지 알려주기는 하지만 나는 react-create-app으로 프로젝트를 만들었기 때문에 별로 도움이 되지 않았다. 그래서 SharedArrayBuffer를 직접 사용하는 [ffmpeg.wasm](https://github.com/ffmpegwasm/ffmpeg.wasm) 깃허브에 들어가면 해결방법이 있지 않을까 싶어서 Issue 탭을 찾아보니 react app을 사용하는 사람들을 위한 방법이 있었다. 

- https://github.com/timarney/react-app-rewired#how-to-rewire-your-create-react-app-project

react의 webpack 설정을 커스텀마이징할 수 있도록 도와주는 패키지

- https://github.com/ffmpegwasm/ffmpegwasm.github.io/blob/main/config-overrides.js

rewire 설정하는 코드

단순히 `react-app-rewired` 깃허브에 있는 README를 읽고서는 해결할 수 없었을 것 같다. 위에 있는 `config-overrides.js` 코드를 보면 headers를 다시 설정해주는 부분이 있는데 이건 webpack에 대해 잘 알지 않으면 작성할 수 없는 코드이기 때문에 webpack에 대해 공부해야겠다는 생각이 들었다. [여기](https://webpack.js.org/configuration/dev-server/#devserverheaders-)에 devServer의 headers에 대한 정보가 짤막하게 있다.




## 요약

`create-react-app`으로 프로젝트를 구성한 사람들을 위한 요약입니다.

1. `react-app-rewired` 패키지를 설치한다.

`npm i react-app-rewired --save-dev`

2. 프로젝트 루트에 `config-overrides.js` 파일을 만들고 다음과 같이 코드를 작성한다.

```javascript
module.exports = {
  devServer(configFunction) {
    return function (proxy, allowedHost) {
      const config = configFunction(proxy, allowedHost);

      config.headers = {
        'Cross-Origin-Embedder-Policy': 'require-corp',
        'Cross-Origin-Opener-Policy': 'same-origin',
      };

      return config;
    };
  },
};

```

3. `package.json`의 scripts에서 `react-scripts`를 `react-app-rewired`로 바꿔준다. 단 여기서 eject는 그대로 두어야 한다.

4. start하거나 build하고 개발자 도구를 열어서 `crossOriginIsolated`을 확인하면 `true`가 나오는 것을 확인할 수 있다.
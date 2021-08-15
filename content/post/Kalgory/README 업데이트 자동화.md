---
title: "README 업데이트 자동화" # Title of the blog post.
date: 2021-08-06T01:25:18+09:00 # Date of post creation.
description: "Auto regenerated README.md using github actions." # Description used for search engine.
featured: true
draft: false
toc: false # Controls if a table of contents should be generated for first-level links automatically.
# menu: main
codeMaxLines: 100 # Override global value for how many lines within a code block before auto-collapsing.
codeLineNumbers: true # Override global value for showing of line numbers within code block.
figurePositionShow: true # Override global value for showing the figure label.
categories:
  - GitHub
tags:
  - github_actions
# comment: false # Disable comment if false.
---

# Resources

- [Auto-Updating Your Github Profile With Python](https://towardsdatascience.com/auto-updating-your-github-profile-with-python-cde87b638168)

위 글을 참고해서 main 브랜치에 푸시되면 현재 폴더 구조에 맞게 README 파일을 자동으로 재생성하도록 github action을 설정하였다. 

# 문제 상황 및 해결 방법

[여러 개의 깃 리포지토리 병합하기](https://wilddoubt.github.io/post/%EC%97%AC%EB%9F%AC-%EA%B0%9C%EC%9D%98-%EA%B9%83-%EB%A6%AC%ED%8F%AC%EC%A7%80%ED%86%A0%EB%A6%AC-%EB%B3%91%ED%95%A9%ED%95%98%EA%B8%B0)에서 이어지는 내용인데 한 리포지토리 안에 문제 별로 팀원들이 만든 리포지토리가 제대로 들어간 것 까진 좋았으나, 이를 기록하는 README파일은 여전히 손으로 수정해야 한다는 단점이 있다. 그래서 폴더 구조에 맞게 자동으로 생성할 수 있는 여러 방법을 찾아보았는데 그 중 가장 간단해보이는 github actions를 사용하기로 했다. 

## 자동화를 위한 파일 구조
```bash
Kalgory/PS
│  main.py          # README 파일을 읽어서 수정하는 작업
│  problem.json     # 문제 출처를 남기기 위해 링크 저장
│  README.md        # README 파일
│  requirements.txt # 필요한 라이브러리
│  
├─.github
│  └─workflows
│          main.yml # GitHub Actions를 위한 파일
│          
└─sections
        FOOTER.md   # README 파일의 Footer
        HEADER.md   # README 파일의 Header
```
### Header and Footer

```markdown
# Header 파일
<h1>Kalgory_PS</h1>
<div>
    {problem_numbers} problems solved
</div>
<h2> Solved Problem List</h2>

# Footer 파일
<hr>
<div align="center">
README.md last auto generated {timestamp}
</div>
```

Header에는 현재 몇 문제를 풀었는지 기록하고 Footer에는 언제 README가 업데이트되었는지 알려준다.

### main.py

```python
def update_header():
    problem_numbers = len(read_problem_reference())
    header = Path('sections/HEADER.md').read_text()
    return header.format(problem_numbers=problem_numbers)


def update_footer():
    timestamp = datetime.datetime.now(pytz.timezone("Asia/Seoul")).strftime("%c")
    footer = Path('sections/FOOTER.md').read_text()
    return footer.format(timestamp=timestamp)
```

두 함수로 Header와 Footer를 업데이트 해주었다. 

```python
def regenerate_posts():
    problem_list = [f for f in listdir('./') if isdir(join('./', f)) and f not in ignore_list]
    folder_list = {folder: [item for item in listdir(folder) if isdir(join('./', folder, item))] for folder in
                   problem_list}
    posts = []
    problem_references = read_problem_reference()
    index = 1
    for problem, subdirectories in OrderedDict(sorted(folder_list.items())).items():
        created_at = datetime.datetime.strptime("20" + problem.split("_")[0], "%Y%m%d").strftime("%Y.%m.%d")
        problem_name = problem.split("_")[1]
        post = f'- #{index} {created_at} [{problem_name}]({problem_references[problem_name]})'
        for subdirectory in subdirectories:
            member_name = subdirectory.split("_")[-1]
            post += f'\n\t - [{members[member_name]}]({problem}/{subdirectory})'
        index += 1
        posts.append(post)
    return posts

updated_readme = update_header() + "\n" + "\n".join(regenerate_posts()) + "\n" + update_footer()
# for item in regenerate_posts():
#     print(item)

with open('./README.md', 'w', encoding='utf-8') as file:
    file.write(updated_readme)
```

`regerate_posts`함수에서 각 문제마다 누가 풀었는지 기록한 내용을 생성한다. 여기서 markdown 문법에 맞춰서 문자열을 만들고 배열에 담아서 리턴한다.

마지막으로 `README.md`파일을 열고 재작성하면 된다.

### GitHub Actions

```yaml
name: Python application

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python 3.9
      uses: actions/setup-python@v2
      with:
        python-version: 3.9
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
    - name: Update README
      run: |
        python main.py
    - name: Deploy
      run: |
        git config user.name "${GITHUB_ACTOR}"
        git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
        git add .
        git commit -am "feat(auto generate): Updated content"
        git push --all -f https://${{ secrets.GITHUB_TOKEN }}@github.com/${GITHUB_REPOSITORY}.git
```

새 workflow 생성을 python을 위한 기본 템플릿이 있는데 그걸 기반으로 main.py가 푸시되면 바로 실행되도록 만들었다. 

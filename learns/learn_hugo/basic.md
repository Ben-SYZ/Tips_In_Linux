1. 建一个hugo blog project directory(quickstart):
```sh
hugo new site quickstart
```

2. Theme
```sh
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

```config
# ./config.toml
theme = "ananke"
title = "Ben's blog"
```

3. 新建一篇文章
```sh
# ./archetypes/...
hugo new posts/my-first-post.md
```

4. preview
```sh
# preview
hugo server -D
# publish 
hugo

-D # include draft
```
## meta data
```yaml
draft: false
publishdate: 2021-04-28
expirydate: 2021-04-30
```

## directory structure
https://gohugo.io/getting-started/directory-structure/
1. archetypes: template of hugo new file.md
2. [config](https://gohugo.io/getting-started/configuration/#all-variables-yaml)
	* 每个subdirectory: config.toml 中的 [Params] 就是params.toml
	* config/_default, config/production, .. 
	* `hugo --envionment production`= `_default` + `production`
	* Default environments are development with `hugo server` and production with `hugo`.
3. content: markdown file. you can create sub-directory
4. static: ![](/20210429_license/a.png) root is /static
...

## [config](https://gohugo.io/getting-started/configuration/)
`hugo --config a.toml,b.toml`
...

## front matter(meta data)
https://gohugo.io/content-management/front-matter/

```yaml
title: "My First Post"
categories:
- Development
- VIM
date: "2012-04-06"
description: spf13-vim is a cross platform distribution of vim plugins and resources
  for Vim.
slug: spf13-vim-3-0-release-and-new-website
tags:
- .vimrc
- plugins
- spf13-vim
- vim
title: spf13-vim 3.0 release and new website
```








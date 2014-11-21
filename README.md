WSK-War Machine ( Beta )
========================
轻量级混合前端工程模板

> 项目名称命名规则参阅 [*项目名称命名规则 & 描述*](http://baike.baidu.com/item/%E5%A4%8D%E4%BB%87%E8%80%85%E8%81%94%E7%9B%9F%EF%BC%9A%E5%A5%A5%E5%88%9B%E6%97%B6%E4%BB%A3 '点击 · Click')

> [*演示*]( '点击 · Click')



帮助 WSK-War Machine
--------------------
***你不一定会在这儿找到令你惊讶的东西，但是 `WSK-War Machine` 需要你的热情！^_^***

#### WSK-War Machine 接下来要实现些什么?

* 你可以在 [*Trello*](https://trello.com/b/9jZa2tS7 '点击 · Click') 和 [*Github Wiki*](https://github.com/iTonyYo/web.starter.kit-war.machine/wiki '点击 · Click') 上查看 `WSK-War Machine` 的开发、计划等动态，我们在 [*Trello*](https://trello.com/b/9jZa2tS7 '点击 · Click') 上头更多地会进行各种讨论、信息收集等活动。

#### 发现BUG!!!

如果你发现一些总是出现的问题，无论是在访问网站时发现，亦或是在查看我们的代码时发现，可以在 [Github Issues](https://github.com/iTonyYo/web.starter.kit-war.machine/issues '点击 · Click') 上查看是否存在相关特征描述的条目，如果不存在，我们欢迎你提出问题，并与我们展开讨论。[*这儿*]( '点击 · Click')是相关 `BUG` 的定义规范、创建流程及方式等。

#### 我想帮忙一起写代码!!!

那真的是太棒了！！！请查看 [*《如何创建独属于你的拷贝》*](https://github.com/iTonyYo/web.starter.kit-war.machine#%E5%A6%82%E4%BD%95%E5%88%9B%E5%BB%BA%E7%8B%AC%E5%B1%9E%E4%BA%8E%E4%BD%A0%E7%9A%84%E6%8B%B7%E8%B4%9D '点击 · Click')！

#### 我有一个想法，但是我不懂如何去编写程序!!!

如果你在功能上或者其他方面有些自己的想法，请查阅 [Trello](https://trello.com/b/9jZa2tS7 '点击 · Click') 上的面板是否已经存在相关的卡片。如果你的想法非常棒，面板上却没有相关明确内容，我们会通知你并将你的提议加入功能储备，并竭尽可能尽快去实现它！



主要开发规范
-----------

+ [*工程模板指南*]( '点击 · Click')

+ [*语义版本号规范*](http://semver.org/lang/zh-CN/ '点击 · Click')

+ [*HTML 指南*]( '点击 · Click')

+ [*Jade 指南*]( '点击 · Click')

+ [*CSS 指南*]( '点击 · Click')

+ [*Sass 指南*]( '点击 · Click')

+ [*JavaScript 指南*]( '点击 · Click')

+ [*CoffeeScript 指南*]( '点击 · Click')

> 参阅
 [*GitHub's CSS*](http://markdotto.com/2014/07/23/githubs-css/ '点击 · Click'),
 [*Refining The Way We Structure Our CSS At Trello*](http://blog.trello.com/refining-the-way-we-structure-our-css-at-trello/ '点击 · Click'),
 [*Medium’s CSS is actually pretty f***ing good.*](https://medium.com/@fat/mediums-css-is-actually-pretty-fucking-good-b8e2a6c78b06 '点击 · Click'),
 [*CodePen's CSS*](http://codepen.io/chriscoyier/blog/codepens-css '点击 · Click'),
 [*CSS at Lonely Planet*](http://ianfeather.co.uk/css-at-lonely-planet/ '点击 · Click'),
 [*Buffer’s CSS*](http://blog.brianlovin.com/buffers-css/ '点击 · Click'),
 [*CSS at Groupon*](http://mikeaparicio.com/2014/08/10/css-at-groupon/ '点击 · Click'),
 [*CSS Guidelines*](http://cssguidelin.es/ '点击 · Click'),
 [*How we do CSS at Ghost*](http://dev.ghost.org/css-at-ghost/ '点击 · Click'),
 [*Website Style Guide Resources*](http://styleguides.io/ '点击 · Click')



主要开发依赖
-----------

+ [*Git*](http://git-scm.com/ '点击 · Click')

+ [*Node.js*](http://nodejs.org/ '点击 · Click')

+ [*Gulp.js*](http://gulpjs.com/ '点击 · Click')

+ [*UglifyJS 2*](http://lisperator.net/uglifyjs/ '点击 · Click')

+ [*Jade*](http://jade-lang.com/ '点击 · Click')

+ [*Sass*](http://sass-lang.com/ '点击 · Click')

+ [*CoffeeScript*](http://coffeescript.org/ '点击 · Click')

+ [*NPM*](http://npmjs.org/ '点击 · Click')

+ [*Bower*](http://bower.io/ '点击 · Click')

> 顺序安装；所有依赖均安装在全局环境下。

####Git

整个项目使用 [*Git*](http://git-scm.com/ '点击 · Click') 进行版本控制，并托管在 [*Github*](https://github.com/ '点击 · Click') 上。你可以通过下述命令检查 [*Git*](http://git-scm.com/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
git --version
```

####Node

整个项目中的很多构建任务基于 [*Node.js*](http://nodejs.org/ '点击 · Click') 运行。你可以通过下述命令检查 [*Node.js*](http://nodejs.org/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
node --version
```

####Gulp.js

项目中的所有构建任务目前完全使用 [*Gulp.js*](http://gulpjs.com/ '点击 · Click') 。你可以通过下述命令检查 [*Gulp.js*](http://gulpjs.com/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
gulp --version
```

####UglifyJS 2

项目中的所有构建任务目前完全使用 [*UglifyJS 2*](http://lisperator.net/uglifyjs/ '点击 · Click') 。你可以通过下述命令检查 [*UglifyJS 2*](http://lisperator.net/uglifyjs/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
uglifyjs --version
```

####NPM

项目中的所有构建任务目前完全使用 [*NPM*](https://www.npmjs.org/ '点击 · Click') 。你可以通过下述命令检查 [*NPM*](https://www.npmjs.org/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
npm --version
```

####Bower

项目中的所有构建任务目前完全使用 [*Bower*](http://bower.io/ '点击 · Click') 。你可以通过下述命令检查 [*Bower*](http://bower.io/ '点击 · Click') 在你的电脑上是否被安装成功：

```bash
bower --version
```



主要构建任务
-----------

+ 在 `WEB` 容器内实时开发；

+ 使用 `Jade` 预处理 `HTML`；

+ 压缩 `HTML` 超文本标记文件；

+ 使用 `Sass` 预处理 `CSS`；

+ 压缩 `CSS` 样式表文件；

+ 使用 `UNCSS` 移除页面相关样式表内未应用的 `CSS` 内容（选择器）;

+ 使用 `CSSO` 优化 `CSS`;

+ 使用 `CoffeeScript` 预处理 `JavaScript`；

+ 压缩 `JavaScript` 脚本文件；

+ 生成、更新 `HTML5` 应用缓存清单文件；

+ 将贡献者以清单的形式生成并放置在相关 `README` 文件中；

> 使用 Bower 包管理器管理浏览器端静态资源

> 确保开发活动中在无论线上亦或线下的 `HTML`, `CSS`, `JavaScript`, `字体`, `图片` 等资源环境下都可以有效进行

> 确保某些任务可以按指定序列同步执行

> 只处理被修改过的 `Jade`, `Sass`, `CoffeeScript` 文件

> 使用外部配置文件（ `config.json` ）

> 从命令行传输参数

> 使得在一个任务中可以使用复合源

> 将每一个任务的多个管道按相关规则独立出来，注重管道的重用

```bash
gulp
```

可以通过这个命令开始编辑模式。

> 可添加 `--minhtml`，实时输出被压缩的 `HTML` 文件

```bash
gulp -p
```

先对所有相关预处理文件预处理，然后计入编辑模式。

> 使用 `SASS` 预处理输出的 `CSS` 文件为被压缩的状态，可在该命令后添加 `--csso`，实时输出被优化（[CSSO](https://github.com/css/csso '点击 · Click')）的 `CSS` 文件。

```bash
gulp cmprs
```

对所有非第三方 `HTML`, `CSS`, `JavaScript` 静态资源优化、压缩。

> 上述命令均可添加 `--size`, `--notify` 参数，以输出处理好的文件的容量（体积） & 输出相关操作成功的提示消息。



如何创建独属于你的拷贝
--------------------

如果你已经在自己的电脑上安装并配置了上述[*开发依赖*](https://github.com/iTonyYo/web.starter.kit-war.machine#%E4%B8%BB%E8%A6%81%E5%BC%80%E5%8F%91%E4%BE%9D%E8%B5%96 '点击 · Click')，你可以克隆一份
[*"web.starter.kit-war.machine" 主要镜像*](https://github.com/iTonyYo/web.starter.kit-war.machine '点击 · Click') 副本至指定文件目录：

```bash
git clone https://github.com/iTonyYo/web.starter.kit-war.machine.git
```

你也可以使用 [*Github for Windows*](https://windows.github.com '点击 · Click') 或者 [*GitHub for Mac*](https://mac.github.com '点击 · Click') 客户端从
[*"web.starter.kit-war.machine" 主要镜像*](https://github.com/iTonyYo/web.starter.kit-war.machine '点击 · Click') 位置克隆一份副本。

克隆完全后，进入 "web.starter.kit-war.machine" 文件夹，安装所有基于 [*Gulp*](http://gulpjs.com/ '点击 · Click') 的开发依赖：

```bash
npm install
```

如果你是在 Mac 等系统上操作，需要提升操作权限：

```bash
sudo npm install
```

如果你所处网络环境访问外网存在不稳定的情况且没法儿使用 VPN 访问相关国外代理服务器，那么你可以通过国内 [TAONPM](http://npm.taobao.org/ '点击 · Click') 安装所有模块：

```bash
npm install --registry=https://registry.npm.taobao.org
```

如果你需要在安装的过程中输出相关安装日志，可在上述命令后添加 `-d` 或 `-dd` 或 `-ddd`。

安装完所有基于 [*Gulp*](http://gulpjs.com/ '点击 · Click') 的开发依赖后，从 [*Bower*]http://bower.io/ '点击 · Click') 安装相关静态资源依赖：

```bash
bower install
```

如果你是在 Mac 等系统上操作，需要提升操作权限：

```bash
sudo bower install
```

至此，所有开发依赖就安装完了。运行 [*./tool/build.gulpfile.bat*](https://github.com/iTonyYo/web.starter.kit-war.machine/tree/master/tool '点击 · Click') 生成 `gulpfile.js` 文件，不要关闭打开的命令行界面，这样的话你每次对 `gulpfile.coffee` 的修改都会被实时生成至 `gulpfile.js`。新打开一个命令行界面，输入下述命令（具体参阅 [**](https://github.com/iTonyYo/web.starter.kit-war.machine#%E4%B8%BB%E8%A6%81%E6%9E%84%E5%BB%BA%E4%BB%BB%E5%8A%A1 '点击 · Click')）**开始编辑这个工程**：

```bash
gulp
```

接下来也许（或不）你会需要阅读 [*《如何协作 & 贡献》*]( '点击 · Click') ！^_^



贡献者
------
...



许可证
------
...
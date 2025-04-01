# Command-Line Cheatsheets 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/funnyzak/cli-cheatsheets?style=flat)](https://github.com/funnyzak/cli-cheatsheets/stargazers)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/funnyzak/cli-cheatsheets?style=flat)](https://github.com/funnyzak/cli-cheatsheets/commits/main)

**cli-cheatsheets** 是一个集中化的命令行工具速查表仓库，通过简单的 Shell 脚本，快速查询和查看各种常用命令速查表。

## 📋 特性

- **丰富的速查表:** 涵盖 Android, Build Tools, Database, Media, Network, Package Managers, Runtime, System, Tools, Web Servers 等多个类别，持续更新和扩充。
- **快速查询:** 通过简单的命令即可查看指定工具的速查表。
- **别名支持:** 方便配置 Bash/Zsh/Fish 别名，实现更快速的调用。
- **简单易用:** 脚本简洁明了，操作简单直观。
- **多系统支持:** 兼容 Linux 和 macOS 系统。

![交互式命令行界面](https://github.com/user-attachments/assets/74aea647-0aff-4f4e-b650-c6c7ca39318c)


## 🚀 使用方法

1. **配置别名 (可选)**: 为了更快速地调用速查表，建议配置 Shell 别名。
2. **远程使用**: 无需下载项目，直接通过 `curl` 命令远程执行脚本。
3. **本地使用**: 下载项目后，赋予执行权限并运行脚本。

直接使用 `curl` 命令远程执行脚本：

```bash
curl https://cs.yycc.dev | bash -s -- git
# 或者 显示所有支持的命令速查表
curl -sSL https://cs.yycc.dev | bash -s -- -l
```

或者使用 `wget` 命令：

```bash
wget -qO- https://cs.yycc.dev | bash -s -- git
```

> 以上`URL`是一个短地址，实际指向的是 [`/get-cheatsheet.sh`](https://github.com/funnyzak/cli-cheatsheets/blob/main/get-cheatsheet.sh)，你可以在分支 [`gh-pages`](https://github.com/funnyzak/cli-cheatsheets/tree/gh-pages) 中找到它。
> 你也可以直接使用 [`https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh`](https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh) 进行远程执行。
> 国区可以使用`Gitee` 的镜像地址： [`https://gitee.com/funnyzak/cli-cheatsheets/raw/main/cheatsheet.sh`](https://gitee.com/funnyzak/cli-cheatsheets/raw/main/cheatsheet.sh)。

### 1. 配置别名 (Bash/Zsh/Fish)

为了更快速地调用速查表，建议配置 Shell 别名。

#### Bash/Zsh

将以下代码添加到你的 `~/.bashrc` 或 `~/.zshrc` 文件中：

**简化版本：**

```bash
alias cs='() { curl -s https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- "$@" }'
```

使用如下命令查看速查表：

```bash
# 显示GIT速查表
cs git
# 显示所有支持的命令速查表
cs
```

**完整版本：** 此方式包含交互式菜单。

在 `~/.zshrc` 中添加以下代码：
```bash
alias cs='() {
  local tmpfile=$(mktemp)
  curl -sSL "https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/${REPO_BRANCH:-main}/cheatsheet.sh" -o "$tmpfile" && chmod +x "$tmpfile" && "$tmpfile" "$@" && rm -f "$tmpfile"
}'
```
配置完成后，然后执行 `source ~/.bashrc` 或 `source ~/.zshrc` 使配置生效。

#### Fish

将以下代码添加到你的 `~/.config/fish/config.fish` 文件中：

```fish
function cs
  curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- $argv
end
```

然后执行 `source ~/.config/fish/config.fish` 使配置生效。

**配置别名后，你就可以使用 `cs` 命令快速访问速查表了：**

```bash
cs git
cs docker -l
cs # 交互式菜单
```

### 2. 远程使用

无需下载项目，直接通过 `curl` 命令远程执行脚本：

* **交互式菜单:**

```bash
curl -s https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh -o cheatsheet.sh && chmod +x cheatsheet.sh && ./cheatsheet.sh
```

* **查看指定命令的速查表:**

```bash
curl -s https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- git
```

* **列出所有支持的命令:**

```bash
curl -s https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- -l
```
### 3. 本地使用(离线)

1. **下载项目:**
    ```bash
    git clone https://github.com/funnyzak/cli-cheatsheets.git
    cd cli-cheatsheets
    # 后续更新可以使用
    git pull origin main
    ```
    或着直接从 [`Release`](https://github.com/funnyzak/cli-cheatsheets/releases) 页面下载最新的压缩包，解压后进入目录。

2. **赋予执行权限:**
    ```bash
    chmod +x cheatsheet.sh
    ```
3. **运行脚本:**

    ```bash
    # 交互式菜单 (无参数)
    ./cheatsheet.sh
    
    # 查看指定命令的速查表
    ./cheatsheet.sh git
    ./cheatsheet.sh docker
    ./cheatsheet.sh mongo
    
    # 列出所有支持的命令
    ./cheatsheet.sh -l
    ./cheatsheet.sh --list
    
    # 显示帮助信息
    ./cheatsheet.sh -h
    ./cheatsheet.sh --help
    
    # 使用自定义 URL 前缀 (高级用法)
    # 如果你将 cheatsheets 目录部署在自定义的 Web 服务器上
    ./cheatsheet.sh -u https://example.com/path/ git
    ```

    > 注意: 如果你在本地使用，确保确保 `cheatsheet.sh` 文件具有执行权限。并且脚本同级目录下的 `cheatsheets/` 目录包含了所有速查表文件。或者你也可以在环境变量设置 `CLI_CHEATSHEET_PATH` 指向你本地的速查表文件目录。
    > 例如:
    ```bash
    export CLI_CHEATSHEET_PATH="/Users/yourname/cli-cheatsheets/cheatsheets/"
    ```

## 目录结构

CLI 速查表按类别组织在以下目录中：

```text
├── LICENSE
├── cheatsheet.sh         # 主脚本文件
├── cheatsheets           # 速查表目录
│   ├── android
│   ├── build
│   ├── cli
│   ├── cloud
│   ├── container
│   ├── data-process
│   ├── database
│   ├── media
│   ├── network
│   ├── os
│   ├── package
│   ├── runtime
│   ├── security
│   ├── version-control 
│   └── webserver
└── get-cheatsheet.sh      # 远程获取速查表的脚本
```

## 速查表类别

* **[Android](#android)**: Android 开发相关命令
* **[Build Tools](#build-tools)**: 构建工具
* **[CLI Tools](#cli-tools)**: 命令行工具
* **[Cloud Tools](#cloud-tools)**: 云平台工具
* **[Container Tools](#container-tools)**: 容器化工具
* **[Data Process Tools](#data-process-tools)**: 数据处理工具
* **[Database](#database)**: 数据库工具
* **[Media](#media)**: 媒体处理工具
* **[Network](#network)**: 网络工具
* **[OS Commands](#os-commands)**: 操作系统命令
* **[Package Managers](#package-managers)**: 包管理器
* **[Runtime](#runtime)**: 运行时环境
* **[Security](#security)**: 安全工具
* **[Version Control](#version-control)**: 版本控制工具
* **[Web Servers](#web-servers)**: Web 服务器

---

### Android

(`cheatsheets/android/`) Android 开发相关命令

* `adb-cheatsheet.txt`: Android Debug Bridge (ADB) 命令

### Build Tools

(`cheatsheets/build/`) 构建工具

* `cmake-cheatsheet.txt`: CMake 构建系统命令
* `gradle-cheatsheet.txt`: Gradle 构建工具命令
* `mvn-cheatsheet.txt`: Maven 构建工具命令

### CLI Tools

(`cheatsheets/cli/`) 命令行工具

* `ansible-cheatsheet.txt`: Ansible 自动化工具命令
* `helm-cheatsheet.txt`: Helm Kubernetes 包管理器命令
* `watchman-cheatsheet.txt`: Watchman 文件监控工具命令


### Cloud Tools

(`cheatsheets/cloud/`) 云平台工具

* `awscli-cheatsheet.txt`: AWS 命令行界面 (AWS CLI) 命令
* `az-cheatsheet.txt`: Azure 命令行界面 (Azure CLI) 命令
* `rclone-cheatsheet.txt`: Rclone 云存储同步工具命令
* `rsync-cheatsheet.txt`: Rsync 远程文件同步工具命令


### Container Tools

(`cheatsheets/container/`) 容器化工具

* `docker-cheatsheet.txt`: Docker 容器平台命令

### Data Process Tools

(`cheatsheets/data-process/`) 数据处理工具

* `jq-cheatsheet.txt`: jq JSON 处理器命令
* `yq-cheatsheet.txt`: yq YAML 处理器命令


### Database

(`cheatsheets/database/`) 数据库工具

* `mongo-cheatsheet.txt`: mongo MongoDB 客户端命令
* `mysql-cheatsheet.txt`: mysql MySQL 客户端命令
* `psql-cheatsheet.txt`: psql PostgreSQL 客户端命令
* `redis-cli-cheatsheet.txt`: redis-cli Redis 客户端命令

### Media

(`cheatsheets/media/`) 媒体处理工具

* `ffmpeg-cheatsheet.txt`: FFmpeg 音视频处理命令
* `Imagemagick-cheatsheet.txt`: ImageMagick 图像处理命令

### Network

(`cheatsheets/network/`) 网络工具

* `curl-cheatsheet.txt`: curl 网络请求工具命令
* `dig-cheatsheet.txt`: dig DNS 查询工具命令
* `frp-cheatsheet.txt`: frp 内网穿透工具命令
* `ifconfig-cheatsheet.txt`: ifconfig 网络接口配置命令
* `nc-cheatsheet.txt`: nc (netcat) 网络工具命令
* `netstat-cheatsheet.txt`: netstat 网络连接状态查看命令
* `nmcli-cheatsheet.txt`: nmcli NetworkManager 命令行工具命令
* `nslookup-cheatsheet.txt`: nslookup DNS 查询命令
* `ping-cheatsheet.txt`: ping 网络连通性测试命令
* `route-cheatsheet.txt`: route 路由表管理命令
* `scp-cheatsheet.txt`: scp 安全文件拷贝命令
* `ssh-cheatsheet.txt`: ssh 安全 Shell 连接命令
* `tcpdump-cheatsheet.txt`: tcpdump 网络数据包分析命令
* `telnet-cheatsheet.txt`: telnet 远程登录命令
* `traceroute-cheatsheet.txt`: traceroute 路由追踪命令
* `wget-cheatsheet.txt`: wget 文件下载工具命令

### OS Commands

(`cheatsheets/os/`) 操作系统命令

* `apt-cheatsheet.txt`: apt Debian/Ubuntu 包管理器命令
* `awk-cheatsheet.txt`: awk 文本处理命令
* `cat-cheatsheet.txt`: cat 查看文件内容命令
* `chmod-cheatsheet.txt`: chmod 修改文件权限命令
* `chown-cheatsheet.txt`: chown 修改文件所有者命令
* `cut-cheatsheet.txt`: cut 文本列提取命令
* `date-cheatsheet.txt`: date 显示或设置系统日期命令
* `df-cheatsheet.txt`: df 磁盘空间使用情况命令
* `diff-cheatsheet.txt`: diff 文件比较命令
* `du-cheatsheet.txt`: du 磁盘使用量统计命令
* `free-cheatsheet.txt`: free 内存使用情况命令
* `grep-cheatsheet.txt`: grep 文本搜索命令
* `gzip-cheatsheet.txt`: gzip 文件压缩命令
* `history-cheatsheet.txt`: history 命令历史记录命令
* `htop-cheatsheet.txt`: htop 交互式进程查看器命令
* `ip-cheatsheet.txt`: ip IP 地址和网络配置命令
* `iptables-cheatsheet.txt`: iptables Linux 防火墙命令
* `kill-cheatsheet.txt`: kill 终止进程命令
* `killall-cheatsheet.txt`: killall 按名称终止进程命令
* `less-cheatsheet.txt`: less 分页文件查看器命令
* `ln-cheatsheet.txt`: ln 创建链接命令
* `lsof-cheatsheet.txt`: lsof 列出打开文件命令
* `more-cheatsheet.txt`: more 分页文件查看器命令
* `mount-cheatsheet.txt`: mount 挂载文件系统命令
* `nano-cheatsheet.txt`: nano 文本编辑器命令
* `operators-cheatsheet.txt`: operators Shell 操作符参考
* `pmap-cheatsheet.txt`: pmap 进程内存映射命令
* `ps-cheatsheet.txt`: ps 进程状态查看命令
* `sed-cheatsheet.txt`: sed 流文本编辑器命令
* `shutdown-cheatsheet.txt`: shutdown 系统关机命令
* `sort-cheatsheet.txt`: sort 文本排序命令
* `systemctl-cheatsheet.txt`: systemctl Systemd 服务管理命令
* `tail-cheatsheet.txt`: tail 显示文件尾部命令
* `tar-cheatsheet.txt`: tar 归档工具命令
* `top-cheatsheet.txt`: top 动态进程查看器命令
* `tree-cheatsheet.txt`: tree 以树形结构显示目录命令
* `uname-cheatsheet.txt`: uname 显示系统信息命令
* `unzip-cheatsheet.txt`: unzip 解压缩工具命令
* `uptime-cheatsheet.txt`: uptime 系统运行时间命令
* `vim-cheatsheet.txt`: vim 文本编辑器命令
* `watch-cheatsheet.txt`: watch 定期执行命令命令
* `yum-cheatsheet.txt`: yum CentOS/RHEL 包管理器命令
* `zip-cheatsheet.txt`: zip 压缩工具命令


### Package Managers

(`cheatsheets/package/`) 包管理器

* `apk-cheatsheet.txt`: apk Alpine Linux 包管理器命令
* `brew-cheatsheet.txt`: brew macOS 包管理器命令
* `cargo-cheatsheet.txt`: cargo Rust 包管理器命令
* `composer-cheatsheet.txt`: composer PHP 依赖管理器命令
* `gem-cheatsheet.txt`: gem RubyGems 包管理器命令
* `npm-cheatsheet.txt`: npm Node.js 包管理器命令
* `pacman-cheatsheet.txt`: pacman Arch Linux 包管理器命令
* `pip-cheatsheet.txt`: pip Python 包管理器命令
* `pipx-cheatsheet.txt`: pipx Python 独立程序包管理器命令
* `pnpm-cheatsheet.txt`: pnpm 高性能 Node.js 包管理器命令
* `poetry-cheatsheet.txt`: poetry Python 依赖和包管理命令
* `uv-cheatsheet.txt`: uv 快速 Python 包安装器命令
* `yarn-cheatsheet.txt`: yarn Node.js 包管理器命令

### Runtime

(`cheatsheets/runtime/`) 运行时环境

* `golang-cheatsheet.txt`: golang Go 语言运行时命令
* `java-cheatsheet.txt`: java Java 运行时命令
* `node-cheatsheet.txt`: node Node.js 运行时命令
* `php-cheatsheet.txt`: php PHP 运行时命令
* `python-cheatsheet.txt`: python Python 运行时命令

### Security

(`cheatsheets/security/`) 安全工具

* `nmap-cheatsheet.txt`: nmap 网络扫描工具命令

### Version Control

(`cheatsheets/version-control/`) 版本控制工具

* `git-cheatsheet.txt`: git 版本控制系统命令

### Web Servers

(`cheatsheets/webserver/`) Web 服务器

* `apachectl-cheatsheet.txt`: apachectl Apache 服务器控制命令
* `caddy-cheatsheet.txt`: caddy Caddy Web 服务器命令
* `nginx-cheatsheet.txt`: nginx NGINX Web 服务器命令

---

## 贡献

欢迎大家为本项目贡献速查表、改进脚本或提出建议！

**贡献速查表:**

1. 在 `cheatsheets/` 目录下找到或创建相应的类别子目录。
2. 创建 `[工具名]-cheatsheet.txt` 文件，并按照清晰易读的格式编写速查表内容。
3. 提交 Pull Request (PR) 到 `main` 分支。

**其他贡献:**

* 如果你发现了脚本的 Bug 或有改进建议，欢迎提交 Issue 或 PR。
* 如果你想添加新的功能或类别，也欢迎提出讨论。

请确保你贡献的速查表内容准确、清晰、易于理解。

## 许可证

本项目采用 [MIT License](LICENSE)。

# Command-Line Cheatsheets (cli-cheatsheets)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

**快速访问命令行工具速查表，提高你的工作效率！**

提供一个集中化的命令行工具速查表仓库，通过简单的 Shell 脚本 `cheatsheet.sh`，你可以快速查询和查看各种常用命令的速查表，无论是本地执行还是远程调用都非常方便。

## 📋 特性

- **丰富的速查表:** 涵盖 Android, Build Tools, Database, Media, Network, Package Managers, Runtime, System, Tools, Web Servers 等多个类别，持续更新和扩充。
- **快速查询:** 通过简单的命令即可查看指定工具的速查表。
- **本地和远程执行:** 既可以在本地下载脚本使用，也可以通过 `curl` 命令远程执行。
- **别名支持:** 方便配置 Bash/Zsh/Fish 别名，实现更快速的调用。
- **简单易用:** 脚本简洁明了，操作简单直观。

## 🚀 使用方法

### 1. 配置别名 (Bash/Zsh/Fish)

为了更快速地调用速查表，建议配置 Shell 别名。

**Bash/Zsh:**

将以下代码添加到你的 `~/.bashrc` 或 `~/.zshrc` 文件中：

```bash
alias cs='(){ 
curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh | bash -s -- "$@" 
}'
```

然后执行 `source ~/.bashrc` 或 `source ~/.zshrc` 使配置生效。

**Fish:**

将以下代码添加到你的 `~/.config/fish/config.fish` 文件中：

```fish
function cs
curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh | bash -s -- $argv
end
```

然后执行 `source ~/.config/fish/config.fish` 使配置生效。

**配置别名后，你就可以使用 `cs` 命令快速访问速查表了：**

```bash
cs git
cs docker -l
cs # 交互式菜单
```

### 2. 远程使用 (通过 `curl`，推荐 )

无需下载项目，直接通过 `curl` 命令远程执行脚本：

* **交互式菜单:**

```bash
curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh | bash
```

* **查看指定命令的速查表:**

```bash
curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh | bash -s -- git
```

* **列出所有支持的命令:**

```bash
curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/main/cheatsheet.sh | bash -s -- -l
```
### 3. 本地使用

1. **下载项目:**

```bash
git clone https://github.com/funnyzak/cli-cheatsheets.git
cd cli-cheatsheets
```

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

## 目录结构

CLI 速查表按类别组织在以下目录中：

```text
cli-cheatsheets/
├── cheatsheets/             # 速查表文档目录
│   ├── android/
│   ├── build/
│   ├── database/
│   ├── media/
│   ├── network/
│   ├── package/
│   ├── runtime/
│   ├── system/
│   ├── tools/
│   └── webserver/
├── cheatsheet.sh           # 核心 Shell 脚本
├── README.md               # 项目 README 文档
└── LICENSE                 # 开源许可证
```

## 速查表类别

* **[Android](#android)**: Android 开发和设备管理命令
* **[Build Tools](#build-tools)**: 构建自动化工具
* **[Database](#database)**: 数据库管理工具
* **[Media](#media)**: 媒体处理工具
* **[Network](#network)**: 网络工具
* **[Package Managers](#package-managers)**: 包管理器
* **[Runtime](#runtime)**: 编程语言运行时环境
* **[System](#system)**: 系统工具
* **[Tools](#tools)**: 通用开发工具
* **[Web Servers](#web-servers)**: Web 服务器配置和管理工具

---

### Android

(`cheatsheets/android/`) Android 开发和设备管理命令

* `adb-cheatsheet.txt`: Android Debug Bridge (ADB) 命令，用于设备管理、应用安装和调试

### Build Tools

(`cheatsheets/build/`) 构建自动化工具

* `cmake-cheatsheet.txt`: CMake 构建系统命令和配置
* `gradle-cheatsheet.txt`: Gradle 构建自动化工具命令
* `mvn-cheatsheet.txt`: Apache Maven 项目管理和构建自动化工具命令

### Database

(`cheatsheets/database/`) 数据库管理工具

* `mongo-cheatsheet.txt`: MongoDB 数据库命令
* `mysql-cheatsheet.txt`: MySQL 数据库命令
* `psql-cheatsheet.txt`: PostgreSQL 数据库命令
* `redis-cli-cheatsheet.txt`: Redis 命令行界面命令

### Media

(`cheatsheets/media/`) 媒体处理工具

* `Imagemagick-cheatsheet.txt`: ImageMagick 图像处理命令
* `ffmpeg-cheatsheet.txt`: FFmpeg 多媒体框架命令，用于音频和视频处理

### Network

(`cheatsheets/network/`) 网络工具

* `curl-cheatsheet.txt`: cURL 命令行工具，用于通过 URL 传输数据
* `dig-cheatsheet.txt`: DNS 查询工具命令
* `ifconfig-cheatsheet.txt`: 网络接口配置命令
* `nc-cheatsheet.txt`: Netcat 网络工具命令
* `netstat-cheatsheet.txt`: 网络统计命令
* `nmcli-cheatsheet.txt`: NetworkManager 命令行界面
* `nslookup-cheatsheet.txt`: DNS 查询命令
* `ping-cheatsheet.txt`: 网络连接测试命令
* `route-cheatsheet.txt`: IP 路由表管理命令
* `scp-cheatsheet.txt`: 安全复制协议命令
* `ssh-cheatsheet.txt`: Secure Shell 协议命令
* `tcpdump-cheatsheet.txt`: 网络数据包分析器命令
* `telnet-cheatsheet.txt`: Telnet 协议命令
* `traceroute-cheatsheet.txt`: 网络路由跟踪命令
* `wget-cheatsheet.txt`: 文件检索命令

### Package Managers

(`cheatsheets/package/`) 包管理器

* `apk-cheatsheet.txt`: Alpine Linux 包管理器命令
* `brew-cheatsheet.txt`: Homebrew 包管理器命令 (macOS)
* `cargo-cheatsheet.txt`: Rust 包管理器命令
* `composer-cheatsheet.txt`: PHP 依赖管理器命令
* `gem-cheatsheet.txt`: RubyGems 包管理器命令
* `npm-cheatsheet.txt`: Node.js 包管理器命令
* `pacman-cheatsheet.txt`: Arch Linux 包管理器命令
* `pip-cheatsheet.txt`: Python 包安装器命令
* `pipx-cheatsheet.txt`: Python 应用安装器命令
* `pnpm-cheatsheet.txt`: 快速、节省磁盘空间的 Node.js 包管理器命令
* `poetry-cheatsheet.txt`: Python 依赖管理和打包命令
* `uv-cheatsheet.txt`: Python 包安装器和解析器命令
* `yarn-cheatsheet.txt`: 另一种 Node.js 包管理器命令

### Runtime

(`cheatsheets/runtime/`) 编程语言运行时环境

* `golang-cheatsheet.txt`: Go 编程语言命令
* `java-cheatsheet.txt`: Java 运行时和开发命令
* `node-cheatsheet.txt`: Node.js 运行时命令
* `python-cheatsheet.txt`: Python 运行时命令

### System

(`cheatsheets/system/`) 系统工具

* `apt-cheatsheet.txt`: Debian 系系统高级包管理工具命令
* `awk-cheatsheet.txt`: 文本处理命令
* `cat-cheatsheet.txt`: 文件连接和显示命令
* `chmod-cheatsheet.txt`: 文件权限修改命令
* `chown-cheatsheet.txt`: 文件所有权修改命令
* `cut-cheatsheet.txt`: 文本切割命令
* `df-cheatsheet.txt`: 磁盘空间使用情况命令
* `diff-cheatsheet.txt`: 文件比较命令
* `du-cheatsheet.txt`: 磁盘使用情况命令
* `free-cheatsheet.txt`: 内存使用情况命令
* `grep-cheatsheet.txt`: 文本搜索命令
* `gzip-cheatsheet.txt`: 文件压缩命令
* `history-cheatsheet.txt`: 命令历史记录命令
* `htop-cheatsheet.txt`: 交互式进程查看器命令
* `ip-cheatsheet.txt`: IP 配置命令
* `iptables-cheatsheet.txt`: 防火墙配置命令
* `kill-cheatsheet.txt`: 进程终止命令
* `killall-cheatsheet.txt`: 按名称终止进程命令
* `less-cheatsheet.txt`: 文件分页命令
* `ln-cheatsheet.txt`: 链接创建命令
* `lsof-cheatsheet.txt`: 列出打开文件命令
* `mount-cheatsheet.txt`: 文件系统挂载命令
* `nano-cheatsheet.txt`: Nano 文本编辑器命令
* `operators-cheatsheet.txt`: Shell 操作符参考
* `pmap-cheatsheet.txt`: 进程内存映射命令
* `ps-cheatsheet.txt`: 进程状态命令
* `rclone-cheatsheet.txt`: 云存储同步命令
* `rsync-cheatsheet.txt`: 远程文件同步命令
* `sed-cheatsheet.txt`: 流编辑器命令
* `shutdown-cheatsheet.txt`: 系统关机命令
* `sort-cheatsheet.txt`: 文本排序命令
* `systemctl-cheatsheet.txt`: Systemd 服务管理命令
* `tar-cheatsheet.txt`: 归档创建和提取命令
* `top-cheatsheet.txt`: 进程监控命令
* `uname-cheatsheet.txt`: 系统信息命令
* `unzip-cheatsheet.txt`: 归档提取命令
* `uptime-cheatsheet.txt`: 系统运行时间命令
* `vim-cheatsheet.txt`: Vim 文本编辑器命令
* `watch-cheatsheet.txt`: 命令执行监控命令
* `yum-cheatsheet.txt`: Yellowdog Updater Modified 包管理器命令
* `zip-cheatsheet.txt`: 归档创建命令

### Tools

(`cheatsheets/tools/`) 通用开发工具

* `docker-cheatsheet.txt`: Docker 容器平台命令
* `git-cheatsheet.txt`: Git 版本控制系统命令
* `jq-cheatsheet.txt`: JSON 处理器命令
* `yq-cheatsheet.txt`: YAML 处理器命令

### Web Servers

(`cheatsheets/webserver/`) Web 服务器配置和管理工具

* `apachectl-cheatsheet.txt`: Apache HTTP Server 控制命令
* `caddy-cheatsheet.txt`: Caddy Web 服务器命令
* `nginx-cheatsheet.txt`: NGINX Web 服务器命令

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

**贡献指南:**  (可以链接到 `CONTRIBUTING.md` 文件，如果需要更详细的贡献指南)

请确保你贡献的速查表内容准确、清晰、易于理解。

## 许可证

本项目采用 [MIT License](LICENSE)。

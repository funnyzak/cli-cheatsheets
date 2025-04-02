#!/usr/bin/env bash

# cheatsheet.sh - 命令行速查表工具
# https://github.com/funnyzak/cli-cheatsheets
# 
# 此脚本用于快速查询常用命令的速查表，你可以通过命令行或交互式菜单来查看不同命令的速查表。
#
# 代码有完整的注释，你可以根据需要进行修改和扩展，或者提交PR来贡献你的修改。
#
# 本地执行:
#   chmod +x cheatsheet.sh
#   ./cheatsheet.sh                # 启动交互式菜单
#   ./cheatsheet.sh git            # 直接查看git命令速查表
#   ./cheatsheet.sh -l/--list      # 列出所有可用的命令
#   ./cheatsheet.sh -h/--help      # 显示帮助信息
#
# 远程执行:
#   curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash
#   curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- git
#   curl -sSL https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/main/cheatsheet.sh | bash -s -- -l
#
# 环境变量:
#   CLI_CHEATSHEET_PATH: 自定义速查表存放路径
#   CLI_CHEATSHEET_CACHE_DIR: 临时目录，用于缓存命令速查表(默认: /tmp/cheatsheet_cache)
#   CLI_CHEATSHEET_REGION: 设置为 "cn" 使用中国区URL(默认：自动检测)

# 脚本错误处理
set -euo pipefail

# 默认URL前缀
DEFAULT_URL="https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/${REPO_BRANCH:-main}/cheatsheets/"
# 中国地区加速URL前缀
CN_URL="https://gitee.com/funnyzak/cli-cheatsheets/raw/${REPO_BRANCH:-main}/cheatsheets/"
# 支持的命令列表及其描述和所属分类
declare -A COMMANDS
declare -A COMMAND_DESCRIPTIONS
declare -A COMMAND_CATEGORIES

# Shell 变量定义脚本

# Android 类命令
COMMAND_CATEGORIES["adb"]="android"
COMMAND_DESCRIPTIONS["adb"]="Android调试桥接器"

# 构建工具类命令
COMMAND_CATEGORIES["cmake"]="build"
COMMAND_DESCRIPTIONS["cmake"]="CMake 构建系统"

COMMAND_CATEGORIES["gradle"]="build"
COMMAND_DESCRIPTIONS["gradle"]="Gradle 构建工具"

COMMAND_CATEGORIES["mvn"]="build"
COMMAND_DESCRIPTIONS["mvn"]="Maven 构建工具"

COMMAND_CATEGORIES["vite"]="build"
COMMAND_DESCRIPTIONS["vite"]="前端构建工具"

COMMAND_CATEGORIES["webpack"]="build"
COMMAND_DESCRIPTIONS["webpack"]="前端构建工具"

# 数据库类命令
COMMAND_CATEGORIES["mongo"]="database"
COMMAND_DESCRIPTIONS["mongo"]="MongoDB 客户端"

COMMAND_CATEGORIES["mysql"]="database"
COMMAND_DESCRIPTIONS["mysql"]="MySQL 客户端"

COMMAND_CATEGORIES["psql"]="database"
COMMAND_DESCRIPTIONS["psql"]="PostgreSQL 客户端"

COMMAND_CATEGORIES["redis-cli"]="database"
COMMAND_DESCRIPTIONS["redis-cli"]="Redis 客户端"

# 命令行工具类命令 (CLI Tools)
COMMAND_CATEGORIES["ansible"]="cli"
COMMAND_DESCRIPTIONS["ansible"]="自动化工具"

COMMAND_CATEGORIES["helm"]="cli"
COMMAND_DESCRIPTIONS["helm"]="Kubernetes 包管理器"

COMMAND_CATEGORIES["watchman"]="cli"
COMMAND_DESCRIPTIONS["watchman"]="文件监控工具"


# 云平台工具类命令 (Cloud Tools)
COMMAND_CATEGORIES["awscli"]="cloud"
COMMAND_DESCRIPTIONS["awscli"]="AWS 命令行工具"

COMMAND_CATEGORIES["az"]="cloud"
COMMAND_DESCRIPTIONS["az"]="Azure 命令行工具"

COMMAND_CATEGORIES["rclone"]="cloud"
COMMAND_DESCRIPTIONS["rclone"]="云存储同步工具"

COMMAND_CATEGORIES["rsync"]="cloud"
COMMAND_DESCRIPTIONS["rsync"]="远程文件同步工具"

COMMAND_CATEGORIES["ossutil"]="cloud"
COMMAND_DESCRIPTIONS["ossutil"]="阿里云对象存储工具"

# 媒体处理类命令
COMMAND_CATEGORIES["ffmpeg"]="media"
COMMAND_DESCRIPTIONS["ffmpeg"]="音视频处理工具"

COMMAND_CATEGORIES["Imagemagick"]="media"
COMMAND_DESCRIPTIONS["Imagemagick"]="图像处理工具"

# 网络工具类命令
COMMAND_CATEGORIES["curl"]="network"
COMMAND_DESCRIPTIONS["curl"]="网络请求工具"

COMMAND_CATEGORIES["dig"]="network"
COMMAND_DESCRIPTIONS["dig"]="DNS 查询工具"

COMMAND_CATEGORIES["frp"]="network"
COMMAND_DESCRIPTIONS["frp"]="内网穿透工具"

COMMAND_CATEGORIES["ifconfig"]="network"
COMMAND_DESCRIPTIONS["ifconfig"]="网络接口配置"

COMMAND_CATEGORIES["nc"]="network"
COMMAND_DESCRIPTIONS["nc"]="网络工具 (netcat)"

COMMAND_CATEGORIES["netstat"]="network"
COMMAND_DESCRIPTIONS["netstat"]="网络连接状态查看"

COMMAND_CATEGORIES["nmcli"]="network"
COMMAND_DESCRIPTIONS["nmcli"]="NetworkManager 命令行工具"

COMMAND_CATEGORIES["nslookup"]="network"
COMMAND_DESCRIPTIONS["nslookup"]="DNS 查询工具"

COMMAND_CATEGORIES["ping"]="network"
COMMAND_DESCRIPTIONS["ping"]="网络连通性测试"

COMMAND_CATEGORIES["route"]="network"
COMMAND_DESCRIPTIONS["route"]="路由表管理"

COMMAND_CATEGORIES["scp"]="network"
COMMAND_DESCRIPTIONS["scp"]="安全文件拷贝"

COMMAND_CATEGORIES["ssh"]="network"
COMMAND_DESCRIPTIONS["ssh"]="安全 Shell 连接"

COMMAND_CATEGORIES["tcpdump"]="network"
COMMAND_DESCRIPTIONS["tcpdump"]="网络数据包分析工具"

COMMAND_CATEGORIES["telnet"]="network"
COMMAND_DESCRIPTIONS["telnet"]="远程登录工具"

COMMAND_CATEGORIES["traceroute"]="network"
COMMAND_DESCRIPTIONS["traceroute"]="路由追踪"

COMMAND_CATEGORIES["wget"]="network"
COMMAND_DESCRIPTIONS["wget"]="文件下载工具"


# 包管理工具类命令
COMMAND_CATEGORIES["apk"]="package"
COMMAND_DESCRIPTIONS["apk"]="Alpine Linux 包管理器"

COMMAND_CATEGORIES["brew"]="package"
COMMAND_DESCRIPTIONS["brew"]="macOS 包管理器"

COMMAND_CATEGORIES["cargo"]="package"
COMMAND_DESCRIPTIONS["cargo"]="Rust 包管理器"

COMMAND_CATEGORIES["composer"]="package"
COMMAND_DESCRIPTIONS["composer"]="PHP 依赖管理器"

COMMAND_CATEGORIES["gem"]="package"
COMMAND_DESCRIPTIONS["gem"]="Ruby Gems 包管理器"

COMMAND_CATEGORIES["npm"]="package"
COMMAND_DESCRIPTIONS["npm"]="Node.js 包管理器"

COMMAND_CATEGORIES["pacman"]="package"
COMMAND_DESCRIPTIONS["pacman"]="Arch Linux 包管理器"

COMMAND_CATEGORIES["pip"]="package"
COMMAND_DESCRIPTIONS["pip"]="Python 包管理器"

COMMAND_CATEGORIES["pipx"]="package"
COMMAND_DESCRIPTIONS["pipx"]="Python 独立程序包管理器"

COMMAND_CATEGORIES["pnpm"]="package"
COMMAND_DESCRIPTIONS["pnpm"]="高性能 Node.js 包管理器"

COMMAND_CATEGORIES["poetry"]="package"
COMMAND_DESCRIPTIONS["poetry"]="Python 依赖和包管理"

COMMAND_CATEGORIES["uv"]="package"
COMMAND_DESCRIPTIONS["uv"]="快速 Python 包安装器"

COMMAND_CATEGORIES["yarn"]="package"
COMMAND_DESCRIPTIONS["yarn"]="Node.js 包管理器"


# 运行时环境类命令
COMMAND_CATEGORIES["golang"]="runtime"
COMMAND_DESCRIPTIONS["golang"]="Go 语言运行时"

COMMAND_CATEGORIES["java"]="runtime"
COMMAND_DESCRIPTIONS["java"]="Java 运行时"

COMMAND_CATEGORIES["node"]="runtime"
COMMAND_DESCRIPTIONS["node"]="Node.js 运行时"

COMMAND_CATEGORIES["php"]="runtime"
COMMAND_DESCRIPTIONS["php"]="PHP 运行时"

COMMAND_CATEGORIES["python"]="runtime"
COMMAND_DESCRIPTIONS["python"]="Python 运行时"

COMMAND_CATEGORIES["venv"]="runtime"
COMMAND_DESCRIPTIONS["venv"]="Python 虚拟环境"


# 安全工具类命令
COMMAND_CATEGORIES["nmap"]="security"
COMMAND_DESCRIPTIONS["nmap"]="网络扫描工具"

COMMAND_CATEGORIES["acme.sh"]="security"
COMMAND_DESCRIPTIONS["acme.sh"]="获取和续订 Let's Encrypt 证书"

COMMAND_CATEGORIES["certbot"]="security"
COMMAND_DESCRIPTIONS["certbot"]="Let's Encrypt 证书管理工具"


# 操作系统命令 (OS Commands)
COMMAND_CATEGORIES["apt"]="os"
COMMAND_DESCRIPTIONS["apt"]="Debian/Ubuntu 包管理器"

COMMAND_CATEGORIES["awk"]="os"
COMMAND_DESCRIPTIONS["awk"]="文本处理工具"

COMMAND_CATEGORIES["cat"]="os"
COMMAND_DESCRIPTIONS["cat"]="查看文件内容"

COMMAND_CATEGORIES["chmod"]="os"
COMMAND_DESCRIPTIONS["chmod"]="修改文件权限"

COMMAND_CATEGORIES["chown"]="os"
COMMAND_DESCRIPTIONS["chown"]="修改文件所有者"

COMMAND_CATEGORIES["cut"]="os"
COMMAND_DESCRIPTIONS["cut"]="文本列提取工具"

COMMAND_CATEGORIES["date"]="os"
COMMAND_DESCRIPTIONS["date"]="显示或设置系统日期"

COMMAND_CATEGORIES["df"]="os"
COMMAND_DESCRIPTIONS["df"]="磁盘空间使用情况"

COMMAND_CATEGORIES["diff"]="os"
COMMAND_DESCRIPTIONS["diff"]="文件比较工具"

COMMAND_CATEGORIES["du"]="os"
COMMAND_DESCRIPTIONS["du"]="磁盘使用量统计"

COMMAND_CATEGORIES["free"]="os"
COMMAND_DESCRIPTIONS["free"]="内存使用情况"

COMMAND_CATEGORIES["grep"]="os"
COMMAND_DESCRIPTIONS["grep"]="文本搜索工具"

COMMAND_CATEGORIES["gzip"]="os"
COMMAND_DESCRIPTIONS["gzip"]="文件压缩工具"

COMMAND_CATEGORIES["history"]="os"
COMMAND_DESCRIPTIONS["history"]="命令历史记录"

COMMAND_CATEGORIES["htop"]="os"
COMMAND_DESCRIPTIONS["htop"]="交互式进程查看器"

COMMAND_CATEGORIES["ip"]="os"
COMMAND_DESCRIPTIONS["ip"]="IP 地址和网络配置工具"

COMMAND_CATEGORIES["iptables"]="os"
COMMAND_DESCRIPTIONS["iptables"]="Linux 防火墙工具"

COMMAND_CATEGORIES["kill"]="os"
COMMAND_DESCRIPTIONS["kill"]="终止进程"

COMMAND_CATEGORIES["killall"]="os"
COMMAND_DESCRIPTIONS["killall"]="按名称终止进程"

COMMAND_CATEGORIES["less"]="os"
COMMAND_DESCRIPTIONS["less"]="分页文件查看器"

COMMAND_CATEGORIES["ln"]="os"
COMMAND_DESCRIPTIONS["ln"]="创建链接"

COMMAND_CATEGORIES["lsof"]="os"
COMMAND_DESCRIPTIONS["lsof"]="列出打开文件"

COMMAND_CATEGORIES["more"]="os"
COMMAND_DESCRIPTIONS["more"]="分页文件查看器"

COMMAND_CATEGORIES["mount"]="os"
COMMAND_DESCRIPTIONS["mount"]="挂载文件系统"

COMMAND_CATEGORIES["nano"]="os"
COMMAND_DESCRIPTIONS["nano"]="文本编辑器"

COMMAND_CATEGORIES["operators"]="os"
COMMAND_DESCRIPTIONS["operators"]="Shell 操作符"

COMMAND_CATEGORIES["pmap"]="os"
COMMAND_DESCRIPTIONS["pmap"]="进程内存映射"

COMMAND_CATEGORIES["ps"]="os"
COMMAND_DESCRIPTIONS["ps"]="进程状态查看"

COMMAND_CATEGORIES["sed"]="os"
COMMAND_DESCRIPTIONS["sed"]="流文本编辑器"

COMMAND_CATEGORIES["shutdown"]="os"
COMMAND_DESCRIPTIONS["shutdown"]="系统关机"

COMMAND_CATEGORIES["sort"]="os"
COMMAND_DESCRIPTIONS["sort"]="文本排序工具"

COMMAND_CATEGORIES["systemctl"]="os"
COMMAND_DESCRIPTIONS["systemctl"]="Systemd 服务管理"

COMMAND_CATEGORIES["tail"]="os"
COMMAND_DESCRIPTIONS["tail"]="显示文件尾部"

COMMAND_CATEGORIES["tar"]="os"
COMMAND_DESCRIPTIONS["tar"]="归档工具"

COMMAND_CATEGORIES["top"]="os"
COMMAND_DESCRIPTIONS["top"]="动态进程查看器"

COMMAND_CATEGORIES["tree"]="os"
COMMAND_DESCRIPTIONS["tree"]="以树形结构显示目录"

COMMAND_CATEGORIES["uname"]="os"
COMMAND_DESCRIPTIONS["uname"]="显示系统信息"

COMMAND_CATEGORIES["unzip"]="os"
COMMAND_DESCRIPTIONS["unzip"]="解压缩工具"

COMMAND_CATEGORIES["uptime"]="os"
COMMAND_DESCRIPTIONS["uptime"]="系统运行时间"

COMMAND_CATEGORIES["vim"]="os"
COMMAND_DESCRIPTIONS["vim"]="文本编辑器"

COMMAND_CATEGORIES["watch"]="os"
COMMAND_DESCRIPTIONS["watch"]="定期执行命令"

COMMAND_CATEGORIES["yum"]="os"
COMMAND_DESCRIPTIONS["yum"]="CentOS/RHEL 包管理器"

COMMAND_CATEGORIES["zip"]="os"
COMMAND_DESCRIPTIONS["zip"]="压缩工具"

# 文件操作命令
COMMAND_CATEGORIES["cd"]="os"
COMMAND_DESCRIPTIONS["cd"]="切换当前工作目录"

COMMAND_CATEGORIES["cp"]="os"
COMMAND_DESCRIPTIONS["cp"]="复制文件和目录"

COMMAND_CATEGORIES["find"]="os"
COMMAND_DESCRIPTIONS["find"]="在文件系统中搜索文件"

COMMAND_CATEGORIES["ls"]="os"
COMMAND_DESCRIPTIONS["ls"]="列出目录内容"

COMMAND_CATEGORIES["mkdir"]="os"
COMMAND_DESCRIPTIONS["mkdir"]="创建新目录"

COMMAND_CATEGORIES["mv"]="os"
COMMAND_DESCRIPTIONS["mv"]="移动或重命名文件和目录"

COMMAND_CATEGORIES["pwd"]="os"
COMMAND_DESCRIPTIONS["pwd"]="显示当前工作目录的完整路径"

COMMAND_CATEGORIES["rm"]="os"
COMMAND_DESCRIPTIONS["rm"]="删除文件或目录"

COMMAND_CATEGORIES["clear"]="os"
COMMAND_DESCRIPTIONS["clear"]="清空终端屏幕"

COMMAND_CATEGORIES["man"]="os"
COMMAND_DESCRIPTIONS["man"]="显示命令的手册页"

COMMAND_CATEGORIES["service"]="os"
COMMAND_DESCRIPTIONS["service"]="控制系统服务的启动、停止和状态"

COMMAND_CATEGORIES["sudo"]="os"
COMMAND_DESCRIPTIONS["sudo"]="以超级用户或其他用户身份执行命令"

COMMAND_CATEGORIES["xargs"]="os"
COMMAND_DESCRIPTIONS["xargs"]="从标准输入构建和执行命令行"

# 文本处理命令
COMMAND_CATEGORIES["echo"]="os"
COMMAND_DESCRIPTIONS["echo"]="在终端输出文本"

COMMAND_CATEGORIES["head"]="os"
COMMAND_DESCRIPTIONS["head"]="显示文件开头的内容"

COMMAND_CATEGORIES["uniq"]="os"
COMMAND_DESCRIPTIONS["uniq"]="报告或忽略文件中的重复行"

COMMAND_CATEGORIES["wc"]="os"
COMMAND_DESCRIPTIONS["wc"]="统计文件中的行数、单词数和字符数"

# 数据处理工具类命令
COMMAND_CATEGORIES["jq"]="data-process"
COMMAND_DESCRIPTIONS["jq"]="JSON 处理工具"

COMMAND_CATEGORIES["yq"]="data-process"
COMMAND_DESCRIPTIONS["yq"]="YAML 处理工具"

# 版本控制工具类命令
COMMAND_CATEGORIES["git"]="version-control"
COMMAND_DESCRIPTIONS["git"]="版本控制系统"

# 容器化工具类命令
COMMAND_CATEGORIES["docker"]="container"
COMMAND_DESCRIPTIONS["docker"]="容器化平台"


# Web 服务器类命令
COMMAND_CATEGORIES["apachectl"]="webserver"
COMMAND_DESCRIPTIONS["apachectl"]="Apache 服务器控制"

COMMAND_CATEGORIES["caddy"]="webserver"
COMMAND_DESCRIPTIONS["caddy"]="Caddy Web 服务器"

COMMAND_CATEGORIES["nginx"]="webserver"
COMMAND_DESCRIPTIONS["nginx"]="NGINX Web 服务器"

# 通知工具类命令
COMMAND_CATEGORIES["apprise"]="notification"
COMMAND_DESCRIPTIONS["apprise"]="通知工具"

# 其他命令
COMMAND_CATEGORIES["tldr"]="tools"
COMMAND_DESCRIPTIONS["tldr"]="简化的命令行速查表"


# 临时目录，用于缓存命令速查表
CACHE_DIR="${CLI_CHEATSHEET_CACHE_DIR:-/tmp/cheatsheet_cache}"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 无色

# 显示帮助信息
show_help() {
  echo -e "${CYAN}命令行速查表工具${NC} - 快速查询常用命令的速查手册"
  echo ""
  echo "用法:"
  echo "  ${0##*/} [选项] [命令名称]"
  echo ""
  echo "选项:"
  echo "  -h, --help     显示此帮助信息并退出"
  echo "  -l, --list     列出所有支持的命令"
  echo "  -u, --url URL  指定自定义URL前缀"
  echo ""
  echo "示例:"
  echo "  ${0##*/}                # 启动交互式菜单"
  echo "  ${0##*/} git            # 查看git命令速查表"
  echo "  ${0##*/} -l             # 列出所有可用命令"
  echo "  ${0##*/} -u https://example.com/path/ git  # 使用自定义URL查看git命令速查表"
  echo "环境变量:"
  echo "  CLI_CHEATSHEET_PATH: 自定义速查表存放路径"
  echo "  CLI_CHEATSHEET_CACHE_DIR: 临时目录，用于缓存命令速查表(默认: /tmp/cheatsheet_cache)"
  echo "  CLI_CHEATSHEET_REGION: 设置为 'cn' 使用中国区URL(默认：自动检测)"
  echo ""
}

# 检测最佳URL前缀
detect_best_url() {
  local timeout=3
  if curl -s --connect-timeout "$timeout" "$CN_URL" >/dev/null 2>&1; then
    echo "$CN_URL"
  else
    echo "$DEFAULT_URL"
  fi
}

# 列出所有支持的命令
list_commands() {
  echo -e "${CYAN}支持的命令列表:${NC}"
  echo ""

  # 按类别分组显示命令
  declare -A categories

  # 收集所有类别
  for cmd in "${!COMMAND_CATEGORIES[@]}"; do
    local category="${COMMAND_CATEGORIES[$cmd]}"
    categories["$category"]=1
  done

  # 按类别显示命令
  for category in "${!categories[@]}"; do
    echo -e "${GREEN}${category^}:${NC}"

    # 找出属于该类别的所有命令
    for cmd in "${!COMMAND_CATEGORIES[@]}"; do
      if [[ "${COMMAND_CATEGORIES[$cmd]}" == "$category" ]]; then
        printf "  %-15s - %s\n" "$cmd" "${COMMAND_DESCRIPTIONS[$cmd]}"
      fi
    done
    echo ""
  done
}

notfound_tips() {
  echo ""
  echo -e "${YELLOW}如果确认命令有效但未收录，您可以到项目提交PR或提交Issue进行添加建议${NC}"
  echo ""
  echo -e "${GREEN}项目地址: https://github.com/funnyzak/cli-cheatsheets${NC}"
}

get_cheatsheet() {
  local cmd="$1"
  local base_url="$2"
  local category="${COMMAND_CATEGORIES[$cmd]}"
  local url="${base_url}${category}/${cmd}-cheatsheet.txt"
  local cache_file="$CACHE_DIR/${category}_${cmd}.txt"
  local cheatsheet_file="${category}/${cmd}-cheatsheet.txt"
  local found=false

  # 创建缓存目录（如果不存在）
  mkdir -p "$CACHE_DIR"

  # 1. 检查环境变量 CLI_CHEATSHEET_PATH
  if [[ -n "${CLI_CHEATSHEET_PATH:-}" ]] && [[ -d "$CLI_CHEATSHEET_PATH" ]]; then
    if [[ -f "$CLI_CHEATSHEET_PATH/$cheatsheet_file" ]]; then
      echo -e "${GREEN}从环境变量指定的路径获取速查表...${NC}"
      less -R "$CLI_CHEATSHEET_PATH/$cheatsheet_file"
      found=true
    fi
  fi

  # 2. 检查脚本同级目录
  if [[ "$found" == "false" ]]; then
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [[ -d "$script_dir/cheatsheets" ]] && [[ -f "$script_dir/cheatsheets/$cheatsheet_file" ]]; then
      echo -e "${GREEN}从脚本同级目录获取速查表...${NC}"
      less -R "$script_dir/cheatsheets/$cheatsheet_file"
      found=true
    fi
  fi

  # 3. 检查缓存或从网络获取
  if [[ "$found" == "false" ]]; then
    # 检查是否有缓存且不超过2天
    if [[ -f "$cache_file" ]] && [[ $(find "$cache_file" -mtime -2 -print 2>/dev/null) ]]; then
      less -R "$cache_file"
    else
      echo -e "${YELLOW}正在从网络获取 $cmd 的速查表...${NC}"

      # 尝试下载并保存到缓存
      if curl -s -o "$cache_file" "$url"; then
        if [[ -s "$cache_file" ]]; then
          less -R "$cache_file"
        else
          rm -f "$cache_file"
          echo -e "${RED}错误: 速查表内容为空${NC}"
          return 1
        fi
      else
        rm -f "$cache_file"
        echo -e "${RED}错误: 无法获取速查表，请检查命令名称和网络连接${NC}"
        echo -e "${YELLOW}尝试访问:${NC} ${url}"
        echo ""
        nanotfound_tips
        return 1
      fi
    fi
  fi
}

show_menu() {
  local base_url="$1"
  local choice

  while true; do
    clear
    echo -e "${CYAN}=== 命令行速查表工具 ===${NC}\n"
    echo -e "请选择要查看的命令速查表 (输入对应的${GREEN}编号${NC}或${GREEN}命令名${NC}):"
    echo -e "输入 '${YELLOW}q${NC}' 退出, '${YELLOW}l${NC}' 显示所有命令\n"

    # 按类别显示命令
    declare -A categories

    # 收集所有类别
    for cmd in "${!COMMAND_CATEGORIES[@]}"; do
      local category="${COMMAND_CATEGORIES[$cmd]}"
      categories["$category"]=1
    done

    local index=1
    declare -A menu_items

    # 按类别显示命令
    for category in "${!categories[@]}"; do
      echo -e "${GREEN}${category^}:${NC}"

      # 找出属于该类别的所有命令
      for cmd in "${!COMMAND_CATEGORIES[@]}"; do
        if [[ "${COMMAND_CATEGORIES[$cmd]}" == "$category" ]]; then
          printf "  ${BLUE}%2d${NC}) %-15s - %s\n" "$index" "$cmd" "${COMMAND_DESCRIPTIONS[$cmd]}"
          menu_items["$index"]="$cmd"
          ((index++))
        fi
      done
      echo ""
    done

    echo -e "${YELLOW}请输入你的选择:${NC} "
    read -r choice

    case "$choice" in
      q|Q|quit|exit)
        echo "谢谢使用，再见！"
        exit 0
        ;;
      l|L|list)
        clear
        list_commands
        echo -e "\n${YELLOW}按回车键返回菜单...${NC}"
        read -r
        continue
        ;;
      *)
        # 检查是否输入的是有效的编号
        if [[ "$choice" =~ ^[0-9]+$ ]] && [[ -n "${menu_items[$choice]}" ]]; then
          cmd="${menu_items[$choice]}"
          clear
          get_cheatsheet "$cmd" "$base_url" || {
            echo -e "\n${YELLOW}按回车键返回菜单...${NC}"
            read -r
          }
        # 检查是否输入的是命令名而不是编号
        elif [[ -n "${COMMAND_DESCRIPTIONS[${choice:-}]+_}" ]]; then
          clear
          get_cheatsheet "$choice" "$base_url" || {
            echo -e "\n${YELLOW}按回车键返回菜单...${NC}"
            read -r
          }
        else
          echo -e "${RED}无效选择，请重试${NC}"
          sleep 1
        fi
        ;;
    esac
  done
}

# 主程序
main() {
  local command_name=""
  local custom_url=""
  local base_url=""

  # 解析参数
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        show_help
        exit 0
        ;;
      -l|--list)
        list_commands
        exit 0
        ;;
      -u|--url)
        if [[ -n "$2" ]]; then
          custom_url="$2"
          shift
        else
          echo -e "${RED}错误: --url 选项需要一个参数${NC}"
          exit 1
        fi
        ;;
      -*)
        echo -e "${RED}错误: 未知选项 $1${NC}"
        show_help
        exit 1
        ;;
      *)
        command_name="$1"
        ;;
    esac
    shift
  done

  # 确定使用哪个URL前缀
  if [[ -n "$custom_url" ]]; then
    base_url="$custom_url"
  elif [[ "${CLI_CHEATSHEET_REGION:-}" =~ ^[cC][nN]$ ]]; then
    base_url="$CN_URL"
  else
    base_url=$(detect_best_url)
  fi

  # 无参数时进入交互式菜单
  if [[ -z "$command_name" ]]; then
    show_menu "$base_url"
  else
    # 检查命令是否支持
    if [[ -z "${COMMAND_DESCRIPTIONS[${command_name:-}]+_}" ]]; then
      echo -e "${RED}错误: 命令 '$command_name' 不在支持列表中${NC}"
      echo "使用 '$0 -l' 查看支持的命令列表"
      notfound_tips
      exit 1
    fi

    # 获取并显示速查表
    get_cheatsheet "$command_name" "$base_url"
  fi
}

# 运行主程序
main "$@"

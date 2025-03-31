#!/usr/bin/env bash

# cheatsheet.sh - 命令行速查表工具
# GitHub: funnyzak
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

# 脚本错误处理
set -euo pipefail

# 默认URL前缀
DEFAULT_URL="https://raw.githubusercontent.com/funnyzak/cli-cheatsheets/refs/heads/${REPO_BRANCH:-main}/cheatsheets/"
# 中国地区加速URL前缀
CN_URL="https://raw.gitcode.com/funnyzak/cli-cheatsheets/raw/${REPO_BRANCH:-main}/cheatsheets/"

# 支持的命令列表及其描述和所属分类
declare -A COMMANDS
declare -A COMMAND_DESCRIPTIONS
declare -A COMMAND_CATEGORIES

# 系统类命令
COMMAND_CATEGORIES["apt"]="system"
COMMAND_DESCRIPTIONS["apt"]="Debian/Ubuntu包管理器"

COMMAND_CATEGORIES["awk"]="system"
COMMAND_DESCRIPTIONS["awk"]="文本处理工具"

COMMAND_CATEGORIES["cat"]="system"
COMMAND_DESCRIPTIONS["cat"]="查看文件内容"

COMMAND_CATEGORIES["chmod"]="system"
COMMAND_DESCRIPTIONS["chmod"]="修改文件权限"

COMMAND_CATEGORIES["chown"]="system"
COMMAND_DESCRIPTIONS["chown"]="修改文件所有者"

COMMAND_CATEGORIES["cut"]="system"
COMMAND_DESCRIPTIONS["cut"]="文本处理工具"

COMMAND_CATEGORIES["df"]="system"
COMMAND_DESCRIPTIONS["df"]="查看磁盘空间使用情况"

COMMAND_CATEGORIES["diff"]="system"
COMMAND_DESCRIPTIONS["diff"]="文件比较工具"

COMMAND_CATEGORIES["du"]="system"
COMMAND_DESCRIPTIONS["du"]="查看文件和目录占用的磁盘空间"

COMMAND_CATEGORIES["free"]="system"
COMMAND_DESCRIPTIONS["free"]="查看内存使用情况"

COMMAND_CATEGORIES["grep"]="system"
COMMAND_DESCRIPTIONS["grep"]="文本搜索工具"

COMMAND_CATEGORIES["gzip"]="system"
COMMAND_DESCRIPTIONS["gzip"]="压缩工具"

COMMAND_CATEGORIES["history"]="system"
COMMAND_DESCRIPTIONS["history"]="查看命令历史"

COMMAND_CATEGORIES["htop"]="system"
COMMAND_DESCRIPTIONS["htop"]="交互式进程查看器"

COMMAND_CATEGORIES["ip"]="system"
COMMAND_DESCRIPTIONS["ip"]="显示/操作路由、设备、策略路由和隧道"

COMMAND_CATEGORIES["iptables"]="system"
COMMAND_DESCRIPTIONS["iptables"]="Linux防火墙工具"

COMMAND_CATEGORIES["kill"]="system"
COMMAND_DESCRIPTIONS["kill"]="终止进程"

COMMAND_CATEGORIES["killall"]="system"
COMMAND_DESCRIPTIONS["killall"]="按名称终止进程"

COMMAND_CATEGORIES["less"]="system"
COMMAND_DESCRIPTIONS["less"]="文件内容分页查看器"

COMMAND_CATEGORIES["tail"]="system"
COMMAND_DESCRIPTIONS["tail"]="查看文件尾部内容"

COMMAND_CATEGORIES["ln"]="system"
COMMAND_DESCRIPTIONS["ln"]="创建链接文件"

COMMAND_CATEGORIES["lsof"]="system"
COMMAND_DESCRIPTIONS["lsof"]="列出打开文件"

COMMAND_CATEGORIES["date"]="system"
COMMAND_DESCRIPTIONS["date"]="显示或设置系统日期和时间"

COMMAND_CATEGORIES["more"]="system"
COMMAND_DESCRIPTIONS["more"]="分页查看文件内容"


COMMAND_CATEGORIES["mount"]="system"
COMMAND_DESCRIPTIONS["mount"]="挂载文件系统"

COMMAND_CATEGORIES["nano"]="system"
COMMAND_DESCRIPTIONS["nano"]="简易文本编辑器"

COMMAND_CATEGORIES["operators"]="system"
COMMAND_DESCRIPTIONS["operators"]="Shell操作符"

COMMAND_CATEGORIES["pmap"]="system"
COMMAND_DESCRIPTIONS["pmap"]="显示进程内存映射"

COMMAND_CATEGORIES["ps"]="system"
COMMAND_DESCRIPTIONS["ps"]="查看进程状态"

COMMAND_CATEGORIES["rclone"]="system"
COMMAND_DESCRIPTIONS["rclone"]="云存储同步工具"

COMMAND_CATEGORIES["rsync"]="system"
COMMAND_DESCRIPTIONS["rsync"]="远程文件同步工具"

COMMAND_CATEGORIES["sed"]="system"
COMMAND_DESCRIPTIONS["sed"]="流编辑器"

COMMAND_CATEGORIES["shutdown"]="system"
COMMAND_DESCRIPTIONS["shutdown"]="关闭系统"

COMMAND_CATEGORIES["sort"]="system"
COMMAND_DESCRIPTIONS["sort"]="排序工具"

COMMAND_CATEGORIES["systemctl"]="system"
COMMAND_DESCRIPTIONS["systemctl"]="systemd系统和服务管理器"

COMMAND_CATEGORIES["tar"]="system"
COMMAND_DESCRIPTIONS["tar"]="归档工具"

COMMAND_CATEGORIES["top"]="system"
COMMAND_DESCRIPTIONS["top"]="动态显示进程"

COMMAND_CATEGORIES["uname"]="system"
COMMAND_DESCRIPTIONS["uname"]="显示系统信息"

COMMAND_CATEGORIES["unzip"]="system"
COMMAND_DESCRIPTIONS["unzip"]="解压缩工具"

COMMAND_CATEGORIES["uptime"]="system"
COMMAND_DESCRIPTIONS["uptime"]="显示系统运行时间"

COMMAND_CATEGORIES["vim"]="system"
COMMAND_DESCRIPTIONS["vim"]="高级文本编辑器"

COMMAND_CATEGORIES["watch"]="system"
COMMAND_DESCRIPTIONS["watch"]="定期执行命令"

COMMAND_CATEGORIES["yum"]="system"
COMMAND_DESCRIPTIONS["yum"]="CentOS/RHEL包管理器"

COMMAND_CATEGORIES["zip"]="system"
COMMAND_DESCRIPTIONS["zip"]="压缩工具"


# 网络类命令
COMMAND_CATEGORIES["curl"]="network"
COMMAND_DESCRIPTIONS["curl"]="网络请求工具"

COMMAND_CATEGORIES["dig"]="network"
COMMAND_DESCRIPTIONS["dig"]="DNS 查询工具"

COMMAND_CATEGORIES["ifconfig"]="network"
COMMAND_DESCRIPTIONS["ifconfig"]="(已过时，但仍常用) 网络接口配置"

COMMAND_CATEGORIES["nc"]="network"
COMMAND_DESCRIPTIONS["nc"]="网络工具 (netcat)"

COMMAND_CATEGORIES["netstat"]="network"
COMMAND_DESCRIPTIONS["netstat"]="网络连接状态查看"

COMMAND_CATEGORIES["nmcli"]="network"
COMMAND_DESCRIPTIONS["nmcli"]="NetworkManager命令行工具"

COMMAND_CATEGORIES["nslookup"]="network"
COMMAND_DESCRIPTIONS["nslookup"]="DNS 查询工具 (已过时)"

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
COMMAND_DESCRIPTIONS["telnet"]="远程登录 (不安全，但仍用于测试)"

COMMAND_CATEGORIES["traceroute"]="network"
COMMAND_DESCRIPTIONS["traceroute"]="路由追踪"

COMMAND_CATEGORIES["wget"]="network"
COMMAND_DESCRIPTIONS["wget"]="文件下载工具"


# 工具类命令
COMMAND_CATEGORIES["cmake"]="tools"
COMMAND_DESCRIPTIONS["cmake"]="构建工具"

COMMAND_CATEGORIES["docker"]="tools"
COMMAND_DESCRIPTIONS["docker"]="容器化平台"

COMMAND_CATEGORIES["git"]="tools"
COMMAND_DESCRIPTIONS["git"]="分布式版本控制系统"

COMMAND_CATEGORIES["jq"]="tools"
COMMAND_DESCRIPTIONS["jq"]="JSON 处理器"

COMMAND_CATEGORIES["yq"]="tools"
COMMAND_DESCRIPTIONS["yq"]="YAML 处理器"


# 安卓类命令
COMMAND_CATEGORIES["adb"]="android"
COMMAND_DESCRIPTIONS["adb"]="Android调试桥接器"


# 媒体类命令
COMMAND_CATEGORIES["ffmpeg"]="media"
COMMAND_DESCRIPTIONS["ffmpeg"]="音视频处理工具"

COMMAND_CATEGORIES["Imagemagick"]="media"
COMMAND_DESCRIPTIONS["Imagemagick"]="图像处理工具"


# 包管理类命令
COMMAND_CATEGORIES["apk"]="package"
COMMAND_DESCRIPTIONS["apk"]="Alpine Linux 包管理器"

COMMAND_CATEGORIES["brew"]="package"
COMMAND_DESCRIPTIONS["brew"]="macOS 包管理器"

COMMAND_CATEGORIES["composer"]="package"
COMMAND_DESCRIPTIONS["composer"]="PHP 依赖管理器"

COMMAND_CATEGORIES["gem"]="package"
COMMAND_DESCRIPTIONS["gem"]="Ruby Gems 包管理器"

COMMAND_CATEGORIES["npm"]="package"
COMMAND_DESCRIPTIONS["npm"]="Node.js包管理器"

COMMAND_CATEGORIES["pacman"]="package"
COMMAND_DESCRIPTIONS["pacman"]="Arch Linux 包管理器"


COMMAND_CATEGORIES["cargo"]="package"
COMMAND_DESCRIPTIONS["cargo"]="Rust 包管理器"

COMMAND_CATEGORIES["uv"]="package"
COMMAND_DESCRIPTIONS["uv"]="Python 包安装器和解析器"

COMMAND_CATEGORIES["pipx"]="package"
COMMAND_DESCRIPTIONS["pipx"]="Python 包管理器 (隔离环境)"

COMMAND_CATEGORIES["poetry"]="package"
COMMAND_DESCRIPTIONS["poetry"]="Python 包管理器 (依赖管理)"

COMMAND_CATEGORIES["pip"]="package"
COMMAND_DESCRIPTIONS["pip"]="Python 包管理器"

COMMAND_CATEGORIES["pnpm"]="package"
COMMAND_DESCRIPTIONS["pnpm"]="高性能Node.js包管理器"

COMMAND_CATEGORIES["yarn"]="package"
COMMAND_DESCRIPTIONS["yarn"]="替代npm的包管理器"


# 运行时类命令
COMMAND_CATEGORIES["golang"]="runtime"
COMMAND_DESCRIPTIONS["golang"]="Go语言运行时"

COMMAND_CATEGORIES["java"]="runtime"
COMMAND_DESCRIPTIONS["java"]="Java运行时"

COMMAND_CATEGORIES["node"]="runtime"
COMMAND_DESCRIPTIONS["node"]="Node.js运行时"

COMMAND_CATEGORIES["python"]="runtime"
COMMAND_DESCRIPTIONS["python"]="Python运行时"


# Web服务器类命令
COMMAND_CATEGORIES["apachectl"]="webserver"
COMMAND_DESCRIPTIONS["apachectl"]="Apache HTTP 服务器控制工具"

COMMAND_CATEGORIES["caddy"]="webserver"
COMMAND_DESCRIPTIONS["caddy"]="现代化Web服务器"

COMMAND_CATEGORIES["nginx"]="webserver"
COMMAND_DESCRIPTIONS["nginx"]="高性能Web服务器"


# 数据库类命令
COMMAND_CATEGORIES["mongo"]="database"
COMMAND_DESCRIPTIONS["mongo"]="MongoDB shell 客户端"

COMMAND_CATEGORIES["mysql"]="database"
COMMAND_DESCRIPTIONS["mysql"]="MySQL 客户端"

COMMAND_CATEGORIES["psql"]="database"
COMMAND_DESCRIPTIONS["psql"]="PostgreSQL 客户端"

COMMAND_CATEGORIES["redis-cli"]="database"
COMMAND_DESCRIPTIONS["redis-cli"]="Redis 客户端"

COMMAND_CATEGORIES["cmake"]="build"
COMMAND_DESCRIPTIONS["cmake"]="构建工具"

COMMAND_CATEGORIES["gradle"]="build"
COMMAND_DESCRIPTIONS["gradle"]="构建工具 (Java, Android)"

COMMAND_CATEGORIES["mvn"]="build"
COMMAND_DESCRIPTIONS["mvn"]="Maven 构建工具 (Java)"

# 临时目录，用于缓存命令速查表
CACHE_DIR="/tmp/cheatsheet_cache"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 无色

# 函数：显示帮助信息
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
  echo ""
}

# 函数：检测最佳URL前缀
detect_best_url() {
  local timeout=3
  # 尝试连接中国区URL
  if curl -s --connect-timeout "$timeout" "$CN_URL" >/dev/null 2>&1; then
    echo "$CN_URL"
  else
    echo "$DEFAULT_URL"
  fi
}

# 函数：列出所有支持的命令
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

# 函数：从URL获取速查表内容并显示
get_cheatsheet() {
  local cmd="$1"
  local base_url="$2"
  local category="${COMMAND_CATEGORIES[$cmd]}"
  local url="${base_url}${category}/${cmd}-cheatsheet.txt"
  local cache_file="$CACHE_DIR/${category}_${cmd}.txt"

  # 创建缓存目录（如果不存在）
  mkdir -p "$CACHE_DIR"

  # 检查是否有缓存且不超过7天
  if [[ -f "$cache_file" ]] && [[ $(find "$cache_file" -mtime -7 -print 2>/dev/null) ]]; then
    less -R "$cache_file"
  else
    echo -e "${YELLOW}正在获取 $cmd 的速查表...${NC}"

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
      echo "尝试访问: $url"
      return 1
    fi
  fi
}

# 函数：显示交互式菜单
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
        elif [[ -n "${COMMAND_DESCRIPTIONS[$choice]}" ]]; then
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
  else
    base_url=$(detect_best_url)
  fi

  # 无参数时进入交互式菜单
  if [[ -z "$command_name" ]]; then
    show_menu "$base_url"
  else
    # 检查命令是否支持
    if [[ -z "${COMMAND_DESCRIPTIONS[$command_name]}" ]]; then
      echo -e "${RED}错误: 命令 '$command_name' 不在支持列表中${NC}"
      echo "使用 '$0 -l' 查看支持的命令列表"
      exit 1
    fi

    # 获取并显示速查表
    get_cheatsheet "$command_name" "$base_url"
  fi
}

# 运行主程序
main "$@"

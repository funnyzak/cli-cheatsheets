#!/usr/bin/env sh

_exists() {
  cmd="$1"
  if [ -z "$cmd" ] ; then
    echo "Usage: _exists cmd"
    return 1
  fi
  if type command >/dev/null 2>&1 ; then
    command -v $cmd >/dev/null 2>&1
  else
    type $cmd >/dev/null 2>&1
  fi
  ret="$?"
  return $ret
}

if [ -z "$REPO_BRANCH" ]; then
  REPO_BRANCH="main"
fi

SCRIPT_NAME="cheatsheet.sh"
REPO_OWNER="funnyzak"
REPO_NAME="cli-cheatsheets"

DEFAULT_URL="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$REPO_BRANCH"
CN_URL="https://raw.gitcode.com/$REPO_OWNER/$REPO_NAME/raw/$REPO_BRANCH"

_get=""

if _exists curl && [ "${USE_WGET:-0}" = "0" ]; then
  _get="curl -L"
elif _exists wget ; then
  _get="wget -O -"
else
  echo "错误: 您必须先安装 curl 或 wget。"
  echo "请安装其中一个工具后再试。"
  exit 1
fi

# 检测最佳 URL 源
detect_best_url() {
  local timeout=5
  local cn_result=1
  local default_result=1
  
  # 使用适合当前工具的检测方法
  if [ "${_get%% *}" = "curl" ]; then
    curl -s --connect-timeout "$timeout" "$CN_URL/README.md" >/dev/null 2>&1
    cn_result=$?
    curl -s --connect-timeout "$timeout" "$DEFAULT_URL/README.md" >/dev/null 2>&1
    default_result=$?
  elif [ "${_get%% *}" = "wget" ]; then
    wget --timeout="$timeout" --tries=1 -q "$CN_URL/README.md" -O /dev/null >/dev/null 2>&1
    cn_result=$?
    wget --timeout="$timeout" --tries=1 -q "$DEFAULT_URL/README.md" -O /dev/null >/dev/null 2>&1
    default_result=$?
  fi
  
  # 判断最佳 URL
  if [ $cn_result -eq 0 ]; then
    echo "$CN_URL"
  elif [ $default_result -eq 0 ]; then
    echo "$DEFAULT_URL"
  else
    echo "$DEFAULT_URL" # 默认使用 DEFAULT_URL
    echo "警告: 无法连接到远程源，使用默认源。" >&2
  fi
}

BASE_URL=$(detect_best_url)
SCRIPT_URL="$BASE_URL/$SCRIPT_NAME"

TMP_FILE=$(mktemp /tmp/cli-cheatsheets.XXXXXX)

# 错误处理和清理函数
cleanup() {
  [ -f "$TMP_FILE" ] && rm -f "$TMP_FILE"
}

# 捕获中断信号
trap cleanup INT TERM EXIT

# 下载脚本
if ! $_get "$SCRIPT_URL" > "$TMP_FILE"; then
  echo "下载失败! 无法从 $SCRIPT_URL 获取脚本。"
  echo "请检查您的网络连接或稍后再试。"
  cleanup
  exit 1
fi

chmod +x "$TMP_FILE"

# 下载完成，执行脚本
if [ -f "$TMP_FILE" ] && [ -s "$TMP_FILE" ]; then
  if [ $# -eq 0 ]; then
    # 如果没有参数则执行脚本
    "$TMP_FILE" -l
    ret=$?
    cleanup
    exit $ret
  else
    # 如果有参数则执行脚本
    "$TMP_FILE" "$@"
    ret=$?
    cleanup
    exit $ret
  fi
else
  echo "脚本下载失败或内容为空! 请检查网络连接或手动下载脚本。"
  cleanup
  exit 1
fi

# 执行完成后清理
cleanup

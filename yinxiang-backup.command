#!/bin/zsh

set -euo pipefail

BASE="${YINXIANG_BACKUP_DIR:-$HOME/Documents/YinxiangBackup}"
VENV="$BASE/venv"
DATA="$BASE/data"
EXPORT="$BASE/enex-export"

pause() {
  echo
  read "?按回车键关闭窗口。"
}

fail() {
  echo "错误：$1" >&2
  pause
  exit 1
}

trap 'echo; echo "备份没有完成。已下载的数据会保留，下次运行可继续。" >&2' ERR

command -v python3 >/dev/null 2>&1 || fail "找不到 Python 3。请先安装 Python 3 后重试。"

mkdir -p "$DATA" "$EXPORT"

echo "备份目录：$BASE"

if [[ ! -x "$VENV/bin/python" ]]; then
  echo "正在建立独立 Python 环境……"
  python3 -m venv "$VENV"
fi

echo "正在安装或更新 evernote-backup（来自 PyPI）……"
"$VENV/bin/python" -m pip install --upgrade pip evernote-backup

cd "$DATA"

if [[ ! -f "en_backup.db" ]]; then
  echo
  echo "下面将初始化印象笔记中国区账号。"
  echo "请只在终端提示中输入账号信息；脚本本身不会保存你的密码。"
  "$VENV/bin/evernote-backup" init-db --backend china
fi

echo
echo "开始同步笔记到本地数据库……"
"$VENV/bin/evernote-backup" sync \
  --max-download-workers 3 \
  --network-retry-count 5 \
  --download-cache-memory-limit 32

echo
echo "开始导出 ENEX……"
"$VENV/bin/evernote-backup" export "$EXPORT"

echo
echo "完成。"
echo "ENEX 文件：$EXPORT"
echo "本地数据库：$DATA"
echo "警告：这两个目录包含私人笔记或登录令牌，请勿上传或分享。"
pause

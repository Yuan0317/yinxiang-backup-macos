# 印象笔记中国区备份工具（macOS）

一个简单的 macOS 启动脚本，用于把印象笔记中国区的笔记同步到本地，并导出为 ENEX 文件。

本项目是非官方的社区封装，不隶属于印象笔记、Evernote 或第三方工具作者。脚本通过 PyPI 安装并调用开源项目 [evernote-backup](https://github.com/vzhd1701/evernote-backup)。

## 功能

- 自动建立独立的 Python 虚拟环境
- 登录印象笔记中国区后同步笔记
- 网络中断后保留已下载数据，重新运行即可继续
- 将每个笔记本导出为 ENEX 文件
- 默认把数据保存在 `~/Documents/YinxiangBackup`

## 使用方法

### 1. 准备环境

需要 macOS、网络连接和 Python 3。可以在终端执行下面的命令检查：

```sh
python3 --version
```

### 2. 运行脚本

下载 `yinxiang-backup.command`，在终端执行：

```sh
chmod +x yinxiang-backup.command
./yinxiang-backup.command
```

首次运行时，终端会要求输入印象笔记账号信息。请只在本机终端中输入密码，不要把密码发送给任何人。

如果 macOS 阻止打开，可在“系统设置 → 隐私与安全性”中确认允许，或直接使用上面的终端命令运行。

### 3. 查看结果

默认输出位置：

```text
~/Documents/YinxiangBackup/
├── data/          # 本地数据库，包含私人数据及可能的登录令牌
├── enex-export/   # 导出的笔记和附件
└── venv/          # Python 虚拟环境
```

可以通过环境变量更改保存位置：

```sh
YINXIANG_BACKUP_DIR="$HOME/Backups/Yinxiang" ./yinxiang-backup.command
```

## 重要隐私说明

不要上传、分享或提交以下内容：

- `data/` 或任何 `*.db` 文件
- `enex-export/` 或任何 `*.enex` 文件
- 从笔记生成的 Word、Pages、PDF 等文档
- 终端日志、密码、Cookie 或登录令牌

仓库提供的 `.gitignore` 会排除常见的私人文件，但提交前仍应运行 `git status` 并逐项检查。

## 常见问题

### 同步看起来卡住怎么办？

大批量下载可能耗时较长。如果进度长时间没有变化，可按 `Control-C` 安全终止。已下载的数据会保存在本地数据库中，之后重新运行脚本即可继续同步。

### ENEX 可以导入到哪里？

ENEX 可用于迁移或归档。Obsidian 可通过官方 Importer 插件导入；其他软件的支持情况请以相应产品的当前文档为准。

### 脚本会保存密码吗？

脚本不会把密码写入自身。不过 `evernote-backup` 建立的本地数据库可能包含登录令牌，因此整个 `data/` 目录都应视为敏感数据。

## 第三方项目

本项目不包含 `evernote-backup` 的源代码，而是在运行时从 PyPI 安装它。其许可证、使用方法和兼容性请参阅 [vzhd1701/evernote-backup](https://github.com/vzhd1701/evernote-backup)。

## 许可证

本项目中的启动脚本和文档采用 [MIT License](LICENSE)。第三方依赖适用其各自的许可证。

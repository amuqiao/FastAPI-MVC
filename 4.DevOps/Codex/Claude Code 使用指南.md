> **文档职责**：覆盖 Claude Code 日常使用所需的核心命令与操作方式。
> **适用场景**：安装完成后的首次上手、日常查阅命令用法。
> **目标读者**：已完成安装和登录、刚开始使用 Claude Code 的新用户。
> **维护规范**：仅记录日常开发中高频使用的命令；进阶或低频命令不纳入；版本升级后如有命令变动需同步更新。

---

## 1. 两种工作模式

Claude Code 有两种核心工作方式，明确区分后再选命令：

| 模式 | 说明 | 适合场景 |
|------|------|---------|
| **交互模式** | 持续对话，保留上下文 | 调试、重构、多轮问答 |
| **一次性查询**（`-p`）| 执行完立即退出 | 脚本自动化、快速提问 |

---

## 2. 启动会话

```bash
# 进入项目目录后启动交互模式
cd /path/to/project
claude

# 继续上次会话（保留上下文）
claude -c

# 一次性查询后退出
claude -p "解释这段代码的作用"

# 将文件内容作为上下文传入（pipe）
cat error.log | claude -p "分析这段错误日志"

# 启动时追加额外目录到上下文（跨目录访问）
claude --add-dir ../shared-lib

# 指定模型启动
claude --model sonnet
claude --model opus
```

---

## 3. 向上下文添加内容

在交互模式中，有三种方式引入文件或目录：

| 方式 | 用法 | 说明 |
|------|------|------|
| `@` 文件引用 | 输入 `@` 后触发路径补全 | 将指定文件内容附加到当前消息 |
| `/add-dir` | `/add-dir ../other-repo` | 运行中追加目录到上下文 |
| `!` bash 前缀 | `! cat src/api.py` | 直接运行 shell 命令，输出显示在会话中 |

`!` 前缀可在不离开 Claude Code 的情况下执行任意 shell 命令，常用于快速查看文件、运行测试等。

---

## 4. 权限模式说明

`Shift+Tab` 在三种模式间循环切换：

| 模式 | 行为 |
|------|------|
| `default` | 每次文件修改或命令执行前询问确认 |
| `acceptEdits` | 自动接受文件编辑，执行命令仍需确认 |
| `plan` | 只分析和规划，不执行任何操作 |

不确定时用 `plan` 先看 Claude 的计划，确认没问题再切换到 `default` 或 `acceptEdits`。

---

## 5. 项目记忆：CLAUDE.md

`CLAUDE.md` 是项目级的持久指令文件，放在项目根目录，Claude Code 每次启动时自动读取。

适合写入：项目背景、技术栈、编码规范、不要碰的文件等。

```bash
# 生成初始 CLAUDE.md（交互模式内）
/init

# 编辑已有的 CLAUDE.md
/memory
```

---

## 6. 交互模式内：常用斜杠命令

进入交互模式后，输入 `/` 触发命令。

### 会话管理

| 命令 | 作用 |
|------|------|
| `/clear` | 清空当前对话，开启全新上下文 |
| `/compact` | 压缩对话历史，释放上下文空间（上下文快满时使用） |
| `/cost` | 查看本次会话的 token 用量和费用 |
| `/exit` | 退出 Claude Code |

### 上下文管理

| 命令 | 作用 |
|------|------|
| `/add-dir <路径>` | 追加目录到当前会话上下文 |
| `/memory` | 查看和编辑项目记忆（CLAUDE.md） |
| `/init` | 为当前项目生成 CLAUDE.md 初始文件 |

### 功能与配置

| 命令 | 作用 |
|------|------|
| `/model` | 切换模型（交互式选择） |
| `/config` | 打开设置界面（主题、模型、输出风格等） |
| `/permissions` | 管理工具权限（允许/禁止哪些操作） |

### 开发工具

| 命令 | 作用 |
|------|------|
| `/diff` | 查看当前未提交的代码变更 |
| `/review` | 在当前会话中 review Pull Request |
| `/help` | 查看所有可用命令 |

---

## 7. 快捷键

| 快捷键 | 作用 |
|--------|------|
| `Enter` | 发送消息 |
| `Shift+Enter` | 换行（不发送）|
| `Ctrl+C` | 取消当前输入或中断生成 |
| `Ctrl+D` | 退出 Claude Code |
| `↑ / ↓` | 浏览历史命令 |
| `Shift+Tab` | 切换权限模式（default → acceptEdits → plan）|

> `Shift+Enter` 换行需要终端支持，推荐 iTerm2 / Ghostty / WezTerm；如不生效，用 `\ + Enter` 代替。

---

## 8. Cheatsheet

### CLI 命令（终端）

```bash
claude                        # 启动交互会话
claude -c                     # 继续上次会话
claude -p "..."               # 一次性查询
claude --add-dir ../lib       # 启动时追加目录到上下文
cat file.txt | claude -p "..." # pipe 内容作为上下文
claude --model sonnet         # 指定模型
claude --version              # 查看版本
claude doctor                 # 检查安装环境
claude update                 # 更新到最新版本
```

### 交互模式内操作

```
@               触发文件路径补全（引用文件到上下文）
! <命令>        直接执行 shell 命令（如 ! cat src/main.py）
Shift+Tab       切换权限模式（default / acceptEdits / plan）
```

### 斜杠命令（交互模式内）

```
/add-dir <路径> 追加目录到上下文
/clear          清空对话
/compact        压缩上下文
/cost           查看费用
/model          切换模型
/config         打开设置
/permissions    管理工具权限
/memory         编辑项目记忆（CLAUDE.md）
/init           初始化 CLAUDE.md
/diff           查看代码变更
/review         Review PR
/help           查看所有命令
/exit           退出
```

### 快捷键

```
Enter           发送
Shift+Enter     换行
Ctrl+C          取消/中断
Ctrl+D          退出
↑ / ↓           历史命令
Shift+Tab       切换权限模式
```

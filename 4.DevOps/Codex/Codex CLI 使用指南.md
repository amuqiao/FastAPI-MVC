> **文档职责**：覆盖 OpenAI Codex CLI 日常使用所需的核心命令与操作方式。
> **适用场景**：安装完成后的首次上手、日常查阅命令用法。
> **目标读者**：已完成安装和登录、刚开始使用 Codex CLI 的新用户。
> **维护规范**：仅记录日常开发中高频使用的命令；随 Codex CLI 版本更新同步校验命令是否仍有效；不纳入进阶或低频功能。

---

## 1. 两个核心概念

使用 Codex CLI 之前，需要先理解两个维度的控制机制：

### 审批模式（何时需要你确认）

| 模式 | 说明 |
|------|------|
| `untrusted`（默认）| 每次文件修改或命令执行前都需确认 |
| `on-request` | Codex 自动执行，遇到敏感操作时请求确认 |
| `never` | 完全自动，不请求任何确认（谨慎使用）|

### 沙盒策略（能操作哪些范围）

| 策略 | 说明 |
|------|------|
| `read-only` | 只读，不修改任何文件 |
| `workspace-write`（推荐）| 可读写工作目录内的文件，可执行命令 |
| `danger-full-access` | 不受限制，包括网络访问（仅在可信环境下使用）|

`--full-auto` 标志 = `on-request` 审批 + `workspace-write` 沙盒，是日常开发的推荐组合。

---

## 2. 项目级指令：AGENTS.md

Codex CLI 启动时会自动读取项目根目录下的 `AGENTS.md`（也支持 `codex.md`）。

适合写入：项目背景、技术栈、编码规范、禁止修改的文件等。首次使用建议先创建，让 Codex 在每次会话中都能了解项目背景。

```bash
# 手动创建
touch AGENTS.md
# 内容示例：
# - 使用 TypeScript，禁用 any
# - 不要修改 legacy/ 目录
# - 测试框架为 Vitest
```

---

## 3. 启动会话

```bash
# 进入项目目录后启动交互模式
cd /path/to/project
codex

# 推荐：低摩擦全自动模式（工作目录写权限 + 遇敏感操作才确认）
codex --full-auto

# 继续上次会话
codex resume

# 指定模型启动
codex --model gpt-4o

# 使用命名配置文件启动（多项目场景）
codex --profile work

# 只读模式（安全探索，不修改任何文件）
codex --sandbox read-only

# 一次性执行（非交互，适合脚本/CI）
codex exec "为 API 模块生成单元测试"

# 附加图片作为上下文（截图、设计稿）
codex --image mockup.png
```

---

## 4. 向上下文添加内容

启动时可通过 `--image` 附加图片（截图、设计稿）作为视觉上下文：

```bash
codex --image mockup.png
```

> **注意**：交互模式内的文件引用方式（如 `/mention`、`@` 语法）在官方文档中描述不明确，建议进入交互模式后输入 `/help` 确认实际可用命令，以当次 `/help` 输出为准。

---

## 5. 常用 CLI 标志

| 标志 | 说明 |
|------|------|
| `--full-auto` | 低摩擦全自动模式（推荐日常开发）|
| `--model` / `-m` | 指定模型，如 `gpt-4o` |
| `--sandbox` / `-s` | 设置沙盒策略：`read-only` / `workspace-write` / `danger-full-access` |
| `--ask-for-approval` / `-a` | 设置审批模式：`untrusted` / `on-request` / `never` |
| `--profile` / `-p` | 加载命名配置文件（多项目切换）|
| `--image` / `-i` | 附加图片（截图、设计稿等）作为上下文 |
| `--cd` / `-C` | 指定工作目录 |
| `--search` | 启用实时网络搜索 |

---

## 6. 交互模式内：常用斜杠命令

进入交互模式后，输入 `/` 触发命令。

### 会话管理

| 命令 | 作用 |
|------|------|
| `/clear` | 清空对话，开启全新上下文 |
| `/new` | 在当前会话中开始新对话 |
| `/fork` | 将当前对话分叉为独立会话 |
| `/resume` | 加载之前保存的会话 |
| `/compact` | 压缩对话历史，节省 token |
| `/status` | 查看当前会话配置与 token 用量 |
| `/quit` / `/exit` | 退出 Codex CLI |

### 权限与配置

| 命令 | 作用 |
|------|------|
| `/permissions` | 查看并切换审批模式和沙盒策略 |
| `/model` | 切换模型 |
| `/personality` | 调整回复风格（friendly / pragmatic / none）|

### 开发工具

| 命令 | 作用 |
|------|------|
| `/diff` | 查看当前 Git 变更（含未跟踪文件）|
| `/review` | 分析工作目录，不修改任何文件 |
| `/mention` | 将指定文件附加到当前对话 |

---

## 7. 快捷键

| 快捷键 | 作用 |
|--------|------|
| `Enter` | 发送消息 |
| `Ctrl+C` | 取消当前输入或中断生成 |
| `Ctrl+O` | 复制最近一条回复 |

---

## 8. 推荐工作流

**每次任务前后建议创建 Git 检查点**，方便回滚：

```bash
# 任务开始前
git add -A && git commit -m "checkpoint: before codex task"

# 任务完成后
git add -A && git commit -m "feat: codex-generated changes"

# 如需撤销 Codex 的所有变更
git reset --hard HEAD~1
```

---

## 9. Cheatsheet

### CLI 命令（终端）

```bash
codex                              # 启动交互会话
codex --full-auto                  # 全自动模式（推荐）
codex resume                       # 继续上次会话
codex --model gpt-4o               # 指定模型
codex --profile work               # 使用命名配置文件
codex --sandbox read-only          # 只读模式
codex --image mockup.png           # 附加图片作为上下文
codex exec "..."                   # 一次性执行后退出
codex login                        # 登录
```

### 斜杠命令（交互模式内）

```
/clear          清空对话
/new            新对话
/fork           分叉当前对话
/resume         加载历史会话
/compact        压缩上下文
/status         查看配置与用量
/permissions    切换审批/沙盒策略
/model          切换模型
/diff           查看 Git 变更
/review         分析代码（只读）
/quit           退出
```

### 快捷键

```
Enter           发送
Ctrl+C          取消/中断
Ctrl+O          复制最近回复
```

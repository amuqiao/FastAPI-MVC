> **文档职责**：说明 Claude Code 与 Codex CLI 在概念和命令上的核心差异，避免交叉使用时混淆。
> **适用场景**：同时使用两个工具，或从一个工具切换到另一个时查阅。
> **目标读者**：已有其中一个工具使用经验、开始接触另一个的用户。
> **维护规范**：以官方文档为准；有疑问的条目必须标注"待确认"，不得推测填写。

---

## 工具定位

| | Claude Code | Codex CLI |
|--|-------------|-----------|
| 开发方 | Anthropic | OpenAI |
| 模型 | Claude 系列（Sonnet / Opus / Haiku）| OpenAI 模型系列（GPT-4o、o3 等）|
| 认证 | Claude 订阅 / Anthropic API Key / Bedrock / Vertex | ChatGPT 账号 / OpenAI API Key |
| 定位 | 功能丰富、可扩展性强的编程助手 | 轻量、流程简洁的编程助手 |

两者定位相近，都是终端内的 AI 编程助手，但来自不同生态，命令和概念**不通用**。

---

## 核心差异速览

| 维度 | Claude Code | Codex CLI |
|------|-------------|-----------|
| 设置工作目录 | 需提前 `cd` 进入目录再启动 | `codex --cd /path` 启动时指定 |
| 项目指令文件 | `CLAUDE.md` | `AGENTS.md`（也支持 `codex.md`）|
| 权限控制入口 | `Shift+Tab` 在交互模式内切换 | `--ask-for-approval` 启动时指定 |
| 权限模式数量 | 6 种（粒度更细）| 3 种（更简洁）|
| 沙盒机制 | 路径级 + 网络域名级精细控制 | 三档模式（read-only / workspace-write / danger-full-access）|
| 继续上次会话 | `claude -c` | `codex resume` |
| 一次性执行 | `claude -p "..."` | `codex exec "..."` |
| 追加目录到上下文 | `--add-dir <路径>` 或 `/add-dir` | 无直接等价命令 |
| 可扩展性 | Hooks、Skills、MCP、IDE 插件 | 插件市场、MCP（较少）|

---

## 差异详解

### 1. 工作目录

**Claude Code** 没有 `--cd` 标志，必须先进入目录再启动：

```bash
cd /path/to/project
claude
```

**Codex CLI** 支持启动时直接指定：

```bash
codex --cd /path/to/project
# 等价于
cd /path/to/project && codex
```

**影响**：在脚本或 CI 中调用时，Codex 更灵活；Claude Code 需要在调用脚本中先切换目录。

---

### 2. 项目指令文件

两个工具都支持在项目根目录放置一个文件，每次启动时自动读取，用于传递项目背景、规范等持久指令。文件名**不相同，不能互用**：

| | 文件名 | 本地覆盖 |
|--|--------|---------|
| Claude Code | `CLAUDE.md` | `CLAUDE.local.md` |
| Codex CLI | `AGENTS.md` | `AGENTS.override.md` |

两个工具的文件格式相同（Markdown），内容写法可以参考互用，但**文件名必须对应正确**，否则不会被读取。

---

### 3. 权限与审批模型

两者的权限控制思路相似（控制 AI 能自动做什么、什么需要你确认），但机制不同：

**Claude Code**：交互模式内按 `Shift+Tab` 实时切换，共 6 种模式：

| 模式 | 行为 |
|------|------|
| `default` | 每次操作前询问 |
| `acceptEdits` | 自动接受文件编辑，执行命令仍需确认 |
| `plan` | 只分析规划，不执行任何操作 |
| `auto` | 自动审批，保留后台安全检查 |
| `dontAsk` | 自动拒绝未预授权操作 |
| `bypassPermissions` | 跳过所有确认（慎用）|

**Codex CLI**：启动时通过 `--ask-for-approval` 指定，共 3 种，或用 `--full-auto` 组合：

| 模式 | 行为 |
|------|------|
| `untrusted`（默认）| 每次修改或命令前询问 |
| `on-request` | 遇敏感操作才确认 |
| `never` | 完全自动 |

**关键区别**：Claude Code 支持会话中随时切换权限模式；Codex 主要在启动时设定，会话中可通过 `/permissions` 调整。

---

### 4. 沙盒机制

两者都有沙盒，但粒度不同：

**Claude Code** 提供路径级和网络级精细控制，通过 settings 配置文件设定允许读写的路径、允许访问的域名，底层使用 macOS Seatbelt / Linux bubblewrap。交互模式中可通过 `/sandbox` 开关。

**Codex CLI** 提供三档整体模式，通过 `--sandbox` 标志或 `/permissions` 切换：

| 策略 | 说明 |
|------|------|
| `read-only` | 只读，不修改任何文件 |
| `workspace-write` | 可读写工作目录，可执行命令 |
| `danger-full-access` | 无限制，含网络访问 |

**选择建议**：需要精确控制哪些路径可写时用 Claude Code；只需快速设定整体安全级别时 Codex 更直接。

---

### 5. 会话管理

| 操作 | Claude Code | Codex CLI |
|------|-------------|-----------|
| 继续上次会话 | `claude -c` | `codex resume` |
| 指定会话继续 | `claude -r <名称或ID>` | `codex resume`（交互选择）|
| 分叉会话 | `--fork-session` | `codex fork` / `/fork` |
| 清空上下文 | `/clear` | `/clear` 或 `/new` |

---

### 6. 文件与目录上下文

**Claude Code**（已确认）：

| 方式 | 说明 |
|------|------|
| `@` + Tab | 交互模式内触发文件路径补全 |
| `--add-dir <路径>` | 启动时追加额外目录 |
| `/add-dir <路径>` | 会话中追加目录 |
| `cat file \| claude -p "..."` | pipe 内容作为一次性查询上下文 |

**Codex CLI**（部分待确认）：

| 方式 | 说明 |
|------|------|
| `--image <文件>` | 附加图片作为上下文（已确认）|
| `@` 文件引用 | 交互模式内文件补全（官方文档未明确，待确认）|

> **注意**：Codex CLI 的 `@` 文件引用和 `/mention` 命令未能在官方文档中找到明确描述，使用时建议先在交互模式中输入 `/help` 确认实际可用命令。

---

### 7. 可扩展性

Claude Code 扩展能力更强，Codex CLI 更轻量：

| 功能 | Claude Code | Codex CLI |
|------|:-----------:|:---------:|
| MCP 服务器 | ✓ | ✓ |
| Hooks（事件驱动自动化）| ✓ | — |
| Skills / 插件 | ✓ | ✓（插件市场）|
| IDE 集成（VS Code / JetBrains）| ✓ | — |
| Git Worktree 隔离 | ✓（`claude -w`）| ✓ |
| 远程/云端会话 | ✓ | ✓ |

---

## 易混淆命令对照

| 意图 | Claude Code | Codex CLI |
|------|-------------|-----------|
| 启动 | `claude` | `codex` |
| 继续会话 | `claude -c` | `codex resume` |
| 一次性查询 | `claude -p "..."` | `codex exec "..."` |
| 指定模型 | `claude --model sonnet` | `codex --model gpt-4o` |
| 指定工作目录 | 需提前 `cd` | `codex --cd <路径>` |
| 只读模式 | `Shift+Tab` 切换到 `plan` | `codex --sandbox read-only` |
| 全自动模式 | `Shift+Tab` 切换到 `auto` | `codex --full-auto` |
| 项目指令文件 | `CLAUDE.md` | `AGENTS.md` |
| 清空对话 | `/clear` | `/clear` |
| 查看变更 | `/diff` | `/diff` |
| 退出 | `/exit` 或 `Ctrl+D` | `/quit` 或 `Ctrl+C` |
| 更新版本 | `claude update` | `codex update`（需确认）|

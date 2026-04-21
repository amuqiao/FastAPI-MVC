> 文档职责：说明 AI-Engineering-Knowledge-Base 项目当前如何接入和使用 Evolver。
> 适用场景：回到本项目后，希望直接知道该运行哪个脚本、当前有哪两种记忆模式、如何验证和关闭。
> 阅读目标：不再翻主仓库文档，直接在本项目内完成使用。
> 目标读者：本项目维护者、在本项目中使用 Codex + Evolver 的开发者。

# Evolver 使用说明

## 先看结论

本项目已经完成了两种 Evolver 接入方式：

1. **共享主记忆库模式**
2. **项目独立 graph 模式**

它们共用同一套项目级 `.codex/` hook，但记忆落点不同。

## 本项目里已经存在的文件

### 项目级 hook

- `/.codex/hooks.json`
- `/.codex/config.toml`
- `/.codex/hooks/evolver-session-start.js`
- `/.codex/hooks/evolver-signal-detect.js`
- `/.codex/hooks/evolver-session-end.js`

### 共享主记忆库模式脚本

- `/scripts/codex-with-evolver.sh`
- `/scripts/check-evolver-shared-memory.sh`

### 项目独立 graph 模式脚本

- `/scripts/codex-with-evolver-project-memory.sh`
- `/scripts/check-evolver-project-memory.sh`

### 项目独立 graph 文件

- `/memory/evolution/memory_graph.jsonl`

## 模式 1：共享主记忆库

### 适用目的

适合：

- 想复用当前 Evolver 主仓库已经积累下来的经验
- 想让本项目和其他项目共享同一份主记忆库

### 是否必须启动 loop

**不必须。**

只要通过 hook 调用了 Evolver，并且脚本里带了：

```bash
EVOLVER_ROOT=/Users/admin/Downloads/Code/evolver
```

就已经可以：

- 在 `SessionStart` 读取共享主记忆库
- 在 `Stop` 把结果写回共享主记忆库

只有当你希望 Evolver 主仓库自己后台持续演化、持续扫描和持续写状态时，才需要额外启动主仓库的 loop。

### 如何启动

在本项目根目录执行：

```bash
./scripts/codex-with-evolver.sh
```

这个脚本会自动设置：

```bash
EVOLVER_ROOT=/Users/admin/Downloads/Code/evolver
```

然后启动 `codex`。

### 当前共享的是哪份记忆

共享的是：

- `/Users/admin/Downloads/Code/evolver/memory/evolution/memory_graph.jsonl`

### 如何验证共享记忆是否生效

```bash
./scripts/check-evolver-shared-memory.sh
```

如果输出里出现：

- `[Evolution Memory] Recent ...`

就说明 `SessionStart` 已经成功读到共享主记忆库。

### 如何验证是否写回共享记忆

```bash
tail -n 8 /Users/admin/Downloads/Code/evolver/memory/evolution/memory_graph.jsonl
```

如果里面出现：

- `source":"hook:session-end"`

说明本项目的会话结果已经写回共享主记忆库。

## 模式 2：项目独立 graph

### 适用目的

适合：

- 不想和其他项目共享记忆
- 希望本项目有自己的 graph 文件

### 是否必须启动 loop

**不必须。**

只要通过 hook 调用了 Evolver，并且脚本里带了：

```bash
MEMORY_GRAPH_PATH=<本项目>/memory/evolution/memory_graph.jsonl
```

就已经可以：

- 在 `SessionStart` 读取本项目自己的 graph
- 在 `Stop` 把结果写回本项目自己的 graph

只有当你希望本项目自己也有后台持续演化能力时，才需要再额外给本项目启动 loop。

### 如何启动

在本项目根目录执行：

```bash
./scripts/codex-with-evolver-project-memory.sh
```

这个脚本会自动设置：

```bash
MEMORY_GRAPH_PATH=<本项目>/memory/evolution/memory_graph.jsonl
```

然后启动 `codex`。

### 当前独立 graph 在哪里

- `/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/memory/evolution/memory_graph.jsonl`

### 如何验证项目独立 graph 是否生效

```bash
./scripts/check-evolver-project-memory.sh
```

如果输出里出现：

- `[Evolution Memory] Recent 1 outcomes ...`

就说明 `SessionStart` 已经成功从本项目自己的 graph 读回记录。

### 如何验证是否写回本项目自己的 graph

```bash
tail -n 8 memory/evolution/memory_graph.jsonl
```

如果里面出现：

- `source":"hook:session-end"`

说明本项目的会话结果已经写进自己的 graph。

## 两种模式怎么选

### 选共享主记忆库

适合：

- 想跨项目复用经验
- 想直接借用 Evolver 主仓库已有记忆

代价：

- 不同项目的经验会混在一起

### 选项目独立 graph

适合：

- 想让本项目记忆独立
- 不希望不同项目互相影响

代价：

- 本项目自己的 graph 需要单独维护

## 如何切换两种模式

这两种模式的切换点，不在 hook 本身，而在**你启动 `codex` 时带的环境变量**。

### 切到共享主记忆库模式

运行：

```bash
./scripts/codex-with-evolver.sh
```

这会带上：

```bash
EVOLVER_ROOT=/Users/admin/Downloads/Code/evolver
```

此时：

- `SessionStart` 读取 Evolver 主仓库的主记忆库
- `Stop` 把结果写回 Evolver 主仓库的主记忆库

### 切到项目独立 graph 模式

运行：

```bash
./scripts/codex-with-evolver-project-memory.sh
```

这会带上：

```bash
MEMORY_GRAPH_PATH=<本项目>/memory/evolution/memory_graph.jsonl
```

此时：

- `SessionStart` 读取本项目自己的 graph
- `Stop` 把结果写回本项目自己的 graph

### 切换后怎么确认自己现在在哪个模式

#### 确认共享模式

```bash
./scripts/check-evolver-shared-memory.sh
```

再查看：

```bash
tail -n 8 /Users/admin/Downloads/Code/evolver/memory/evolution/memory_graph.jsonl
```

#### 确认项目独立 graph 模式

```bash
./scripts/check-evolver-project-memory.sh
```

再查看：

```bash
tail -n 8 memory/evolution/memory_graph.jsonl
```

### 切换时的注意事项

1. 同一轮工作尽量固定用一种模式，不要中途混用。
2. 如果你刚刚用共享模式写入了结果，再切到独立模式，后续新结果只会写到本项目自己的 graph，不会自动同步到共享主记忆库。
3. 反过来也一样：独立 graph 里的记录不会自动写回共享主记忆库。
4. 如果你不确定当前在哪个模式，先跑对应的 `check-...` 脚本，再开始工作。

## 推荐默认模式

如果你们团队没有明确约定，建议先统一一个默认模式，避免不同成员在同一阶段混用。

### 推荐默认：项目独立 graph 模式

推荐理由：

- 本项目的记忆和其他项目隔离
- 更容易判断“这条记录是不是本项目写的”
- 不会把其他项目的噪声混进来

默认启动命令：

```bash
./scripts/codex-with-evolver-project-memory.sh
```

### 什么时候改用共享主记忆库模式

适合这些场景：

- 你明确希望复用 Evolver 主仓库已经积累下来的经验
- 你在做跨项目通用工作，不在意项目间经验混用
- 你正在验证“共享主记忆库”这条链路

切换命令：

```bash
./scripts/codex-with-evolver.sh
```

### 团队使用建议

1. 日常开发默认用“项目独立 graph 模式”
2. 只有在明确需要共享经验时，再切到“共享主记忆库模式”
3. 如果切换模式，先在会话开始前切，不要中途切
4. 如果要做团队协作，建议在任务说明里写清当前使用哪种模式
5. 如果要排查问题，先确认当前使用的模式，再看对应的 graph 文件

## 如何关闭或回退

### 只是不想继续用 Evolver 启动 Codex

直接不要运行这些脚本，改用普通 `codex` 即可。

### 卸载本项目 hook

在本项目根目录执行：

```bash
node /Users/admin/Downloads/Code/evolver/index.js setup-hooks --platform=codex --uninstall
```

### 停止 Evolver 主仓库里的 loop

在 Evolver 主仓库执行：

```bash
cd /Users/admin/Downloads/Code/evolver
node src/ops/lifecycle.js stop
```

## 推荐用法

如果你只是日常在本项目里稳定使用，建议优先选其中一个脚本长期固定下来：

- 共享模式：`./scripts/codex-with-evolver.sh`
- 独立模式：`./scripts/codex-with-evolver-project-memory.sh`

不要同一天来回混用，除非你明确知道自己在验证哪种模式。

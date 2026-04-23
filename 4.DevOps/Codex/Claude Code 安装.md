> **文档职责**：记录 Claude Code 在 macOS Apple Silicon 国内网络环境下的安装与首次配置流程。
> **适用场景**：首次安装、安装失败排查、登录方式选择。
> **目标读者**：macOS 用户，熟悉终端基本操作。
> **维护规范**：每次安装验证后更新"本机环境"节的版本号；如命令有变动，同步更新安装命令和排查步骤；不记录与安装无关的使用技巧。

---

## 1. 安装前检查

```bash
node -v        # 需要 18+
npm -v
npm config get registry   # 确认当前源
```

---

## 2. 安装

官方包名：`@anthropic-ai/claude-code`

```bash
npm install -g @anthropic-ai/claude-code \
  --registry=https://registry.npmjs.org \
  --prefer-offline \
  --fetch-retries=1 \
  --fetch-timeout=120000 \
  --loglevel=verbose \
  --timing \
  --progress=true
```

国内可先试 `--registry=https://registry.npmmirror.com`，明显卡住再换官方源。

**判断是否卡死**：连续 1~2 分钟无新输出（无 `http fetch`/`postinstall`/`reify`）才考虑 Ctrl+C。

**安装前可先测试连通性**（不安装）：

```bash
npm ping --registry=https://registry.npmjs.org --loglevel=verbose
npm view @anthropic-ai/claude-code version --registry=https://registry.npmjs.org --loglevel=verbose
```

---

## 3. 验证

```bash
claude --version   # 示例输出：2.1.117 (Claude Code)
claude doctor
```

---

## 4. 首次启动与登录

```bash
cd /path/to/your/project
claude
```

登录方式选择：

| 选项 | 适用账户 |
|------|---------|
| 1. Claude account | Pro / Max / Team / Enterprise 订阅 |
| 2. Anthropic Console | API key / 按用量计费 |
| 3. 3rd-party platform | AWS Bedrock / Foundry / Vertex AI |

常见企业订阅选 `1`；API key 用户选 `2`。

首次启动还会出现两个确认：Security notes（读完回车）、terminal setup（选 `1` 启用推荐设置）。

---

## 5. 常用命令

```bash
claude            # 启动交互会话
claude -c         # 继续最近会话
claude -p "..."   # 一次性查询后退出
claude doctor     # 检查安装环境
claude --help
```

---

## 6. 常见问题

**`claude` 命令不可用（包已装）**：平台原生二进制未下载完整，重跑安装命令即可。

**两条 warning 不影响安装**：

```
npm warn Unknown env config "disturl"
npm warn Unknown env config "electron-mirror"
```

临时消除：`unset npm_config_disturl && unset npm_config_electron_mirror`

**不建议**一上来就清缓存（`npm cache clean --force`），除非明确出现校验失败。

---

## 本机环境（最后验证）

- Node.js `v24.15.0` · npm `11.12.1` · macOS Apple Silicon
- 成功版本：`claude 2.1.117`

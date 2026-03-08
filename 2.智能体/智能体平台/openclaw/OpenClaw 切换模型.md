# 解决 API 提供商计费错误的指南

您遇到的错误是 API 提供商的计费问题，与飞书配置本身无关。以下是详细的解决方案：

## 错误原因

```
⚠️ API provider returned a billing error — your API key has run out of credits or has an insufficient balance. Check your provider's billing dashboard and top up or switch to a different API key.
```

这意味着您当前使用的 AI 模型 API 密钥已经用完了信用额度或余额不足。

## 解决方案

### 1. 检查 API 提供商的计费状态

1. **登录您的 API 提供商账户**（如 OpenAI、Anthropic 等）
2. **访问计费仪表板**，查看余额状态
3. **充值**（如果需要）

### 2. 在 OpenClaw 中配置新的 API 密钥

#### 方法 A：通过命令行配置

```bash
# 设置新的 API 密钥
pnpm openclaw config set agent.model "<新的模型名称>"
pnpmopenclaw config set agent.apiKey "<新的 API 密钥>"

# 例如：
# openclaw config set agent.model "openai/gpt-4o"
# openclaw config set agent.apiKey "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

#### 方法 B：直接编辑配置文件

编辑 `~/.openclaw/openclaw.json` 文件：

```json5
{
  "agent": {
    "model": "openai/gpt-4o", // 或其他可用模型
    "apiKey": "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" // 您的新 API 密钥
  }
}
```

### 3. 切换到不同的模型提供商

如果您不想为当前提供商充值，可以切换到其他模型提供商。OpenClaw 支持多种模型，例如：

- OpenAI (GPT-4o, GPT-4 Turbo)
- Anthropic (Claude 3.5 Sonnet, Claude 3 Opus)
- Google (Gemini 1.5 Pro)
- 以及其他本地和开源模型

### 4. 重启网关使更改生效

```bash
openclaw gateway restart
```

## 预防措施

1. **监控 API 使用情况**：定期检查 API 提供商的使用情况和余额
2. **设置预算警报**：在 API 提供商处设置预算警报，当接近限额时收到通知
3. **多模型配置**：在 OpenClaw 中配置多个模型作为备用，当一个模型用尽时自动切换

## 验证解决方案

1. 重启网关后，在飞书中 @ 机器人发送消息
2. 检查是否不再出现计费错误
3. 确认机器人能够正常回复

希望这些步骤能帮助您解决 API 计费问题！如果您需要进一步的帮助，请随时告诉我。


```
{
  "auth": {
    "profiles": {
      "qwen-portal:default": {
        "provider": "qwen-portal",
        "mode": "oauth"
      }
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "qwen-portal": {
        "baseUrl": "https://portal.qwen.ai/v1",
        "apiKey": "qwen-oauth",
        "api": "openai-completions",
        "models": [
          {
            "id": "coder-model",
            "name": "Qwen Coder",
            "reasoning": false,
            "input": [
              "text"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 128000,
            "maxTokens": 8192
          },
          {
            "id": "vision-model",
            "name": "Qwen Vision",
            "reasoning": false,
            "input": [
              "text",
              "image"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      },
      "bailian": {
        "baseUrl": "https://dashscope.aliyuncs.com/compatible-mode/v1",
        "apiKey": "${DASHSCOPE_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "qwen-plus",
            "name": "通义千问 Plus",
            "reasoning": false,
            "input": ["text"],
            "cost": { "input": 0.008, "output": 0.008, "cacheRead": 0, "cacheWrite": 0 },
            "contextWindow": 262144,
            "maxTokens": 32000
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "bailian/qwen-plus"
      },
      "models": {
        "bailian/qwen-plus": { "alias": "通义千问 Plus" }
      },
      "workspace": "C:\\Users\\97821\\.openclaw\\workspace"
    }
  },
  "tools": {
    "profile": "coding"
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto",
    "restart": true,
    "ownerDisplay": "raw"
  },
  "session": {
    "dmScope": "per-channel-peer"
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "0666bd3752420e86544fba97dce807d09479e0a40bd1de30"
    },
    "tailscale": {
      "mode": "off",
      "resetOnExit": false
    },
    "nodes": {
      "denyCommands": [
        "camera.snap",
        "camera.clip",
        "screen.record",
        "contacts.add",
        "calendar.add",
        "reminders.add",
        "sms.send"
      ]
    }
  },
  "plugins": {
    "entries": {
      "qwen-portal-auth": {
        "enabled": true
      },
      "feishu": {
        "enabled": true
      }
    },
    "installs": {
      "feishu": {
        "source": "npm",
        "spec": "@openclaw/feishu",
        "installPath": "C:\\Users\\97821\\.openclaw\\extensions\\feishu",
        "version": "2026.3.7",
        "resolvedName": "@openclaw/feishu",
        "resolvedVersion": "2026.3.7",
        "resolvedSpec": "@openclaw/feishu@2026.3.7",
        "integrity": "sha512-CHPcL+WHYKYR2HJKRYsRtlXx/wbQRy5axltjjH9qXkR8ghxygDmOHZREjxyFEbjFJ3wnIuvgjLE7JYTg3nPpDA==",
        "shasum": "c4b31dbe2ff0bc7034334873482ad18ac60a0767",
        "resolvedAt": "2026-03-08T15:10:08.448Z",
        "installedAt": "2026-03-08T15:10:11.092Z"
      }
    }
  },
  "meta": {
    "lastTouchedVersion": "2026.3.7",
    "lastTouchedAt": "2026-03-08T15:10:12.438Z"
  }
}
```
### 更新步骤：
1. 打开 c:\Users\97821\.openclaw\openclaw.json 文件
2. 将上述内容复制粘贴到文件中，替换原有内容
3. 保存文件
4. 设置环境变量 DASHSCOPE_API_KEY 为您的阿里云 DashScope API 密钥
5. 重启 OpenClaw 网关：
```
openclaw gateway restart
```
这样，您就成功将 Qwen 模型配置为默认模型了。

### 注意事项：
- 确保您已经获取了有效的阿里云 DashScope API 密钥
- 环境变量 DASHSCOPE_API_KEY 需要在系统中正确设置
- 重启网关后，OpenClaw 将使用 Qwen 模型进行响应

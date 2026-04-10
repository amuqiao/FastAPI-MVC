# Skill 目录结构与工程实践

## 1. 先轻量，后升级

创建 Skill 时，默认先从最小目录开始：

```text
my-skill/
└── SKILL.md
```

只有当入口文件开始过重时，再升级为生产级结构。

## 2. 生产级目录示意

```text
my-skill/
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
│   ├── domain-spec.md
│   ├── workflow-guide.md
│   └── quality-checklist.md
├── scripts/
│   ├── prepare_input.py
│   ├── build_messages.py
│   └── export_result.py
├── assets/
│   ├── templates/
│   └── examples/
├── pyproject.toml
├── uv.lock
└── .env.example
```

## 3. 各目录职责

| 路径 | 放什么 | 不该放什么 |
|------|--------|-----------|
| `SKILL.md` | 入口说明、步骤、输出、校验 | 冗长背景资料 |
| `references/` | 规范、清单、Schema、长说明 | 运行产物 |
| `scripts/` | 稳定、机械、确定性的动作 | 说明性大段文档 |
| `assets/` | 模板、样例、静态资源 | 需要频繁阅读的长规范 |
| `agents/openai.yaml` | 平台展示和平台附加元信息 | 主要业务逻辑 |

一个实用判断是：

- `references/` 给模型读
- `assets/` 给结果用

## 4. 什么时候升级为生产级

满足以下任意两条，通常就可以考虑升级：

- `SKILL.md` 已经过长
- 有长规格或清单适合拆到 `references/`
- 有稳定命令流程适合沉到 `scripts/`
- 有模板和样例适合沉到 `assets/`

## 5. 维护建议

长期维护时，建议采用这些做法：

- 主入口保持简短，只写骨架
- 长知识拆到 `references/`
- 确定性动作拆到 `scripts/`
- 输出模板沉到 `assets/`
- 平台差异单独维护，不与主骨架混写

## 6. 从主源到派生

跨平台维护时，推荐采用以下结构思路：

1. 先维护一份稳定主源
2. 再按平台派生适配文件
3. 平台目录只保留差异项

这样可以降低重复编辑和版本漂移。

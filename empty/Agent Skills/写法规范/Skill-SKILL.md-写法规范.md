# Skill `SKILL.md` 写法规范

## 1. 写作目标

`SKILL.md` 的目标不是堆知识，而是清晰定义：

- 什么时候该用这个 Skill
- 接收什么输入
- 按什么步骤工作
- 交付什么输出
- 在什么条件下终止或报错

## 2. 最小写法

一个可维护的最小版本通常包含：

- frontmatter
- 简短标题
- 输入
- 步骤
- 输出
- 校验

示例：

```markdown
---
name: review-summary
description: >
  Use this skill when the user wants a concise summary of code changes,
  review findings, or verification status for a patch or pull request.
---

# Review Summary

## 输入
- `target`：PR 编号、commit hash 或文件路径

## 步骤
1. 检查目标范围内的变更文件。
2. 区分用户可见变更与技术变更。
3. 明确标注未验证部分。

## 输出
- 简洁摘要

## 校验
- 输入为空时终止并提示补充。
```

## 3. `description` 的写法原则

`description` 更接近路由规则，而不是宣传文案。写法应满足三点：

1. 写清楚适用场景
2. 写清楚核心动作
3. 尽量写清楚不适用场景

反例：

- “一个非常强大的代码助手”

正例：

- “Use this skill when code files changed and a concise change summary is needed. Do not use it for docs-only edits.”

## 4. 正文结构建议

正文建议固定为四段：

1. 输入
2. 步骤
3. 输出
4. 校验

这样做的好处是：

- 读者更容易扫读
- 后续更容易扩写到 `references/` 或 `scripts/`
- 多个 Skill 之间更容易形成统一风格

## 5. 写作边界

不建议把以下内容大量塞进 `SKILL.md`：

- 冗长背景资料
- 大量示例数据
- 长清单和长 Schema
- 复杂脚本说明

这些内容更适合拆分到：

- `references/`
- `assets/`
- `scripts/`

## 6. 可维护性的最低要求

一份适合长期维护的 `SKILL.md`，至少应满足：

- 任务边界清楚
- 术语统一
- 步骤顺序稳定
- 输出形式明确
- 终止条件可判断

# Mermaid 作图规范参考 · Prompt 路引入口

> 这个文件是给 Prompt 直接引用的唯一稳定入口。
> 使用原则：先读本文件做路由，再决定是否读取 `README.md` 与具体 `A/B/C/D/E` reference。

## 使用顺序

当任务需要 Mermaid 图时，严格按下面顺序执行：

1. 先读取本文件，只做路由判断，不立即出图
2. 先判断当前问题是否真的需要出图
3. 先输出本次路由结果：
   - 这次要回答的核心问题
   - 是否需要出图
   - 推荐图型
   - 应读取的 reference 文件
4. 只有在"需要出图"时，才继续读取：
   - `README.md`，当你还不确定该图型的细化边界时
   - 对应的单个 reference 文件，或最多两个 reference 文件
5. 出图时必须显式继承所选 reference 的语法、配色和输出契约，不能只借用图型名称

## 路由规则

按你真正要回答的问题选：

```text
想看"系统由哪些层/服务/模块组成"       → A
想看"能力按哪些阶段或层次展开"         → A
想看"一个请求从头到尾怎么同步流转"     → A

想看"数据表/持久化结构怎么关联"         → B
想看"类/接口/抽象层次怎么组织"         → B

想看"实体状态如何变化"                 → C
想看"跨组件/跨进程消息如何交互"         → C

想看"项目如何排期"                     → D
想看"技术/产品如何沿时间演进"           → D

想看"技术栈/模块/主题如何分层归类"      → E
```

## 是否需要读取 README

只有下面几种情况才读取 `README.md`：

- 当前任务只说"要 Mermaid 图"，但没有明确图型
- 一条需求同时命中两类以上问题，需要先拆图
- 你不确定该选 A 里的"系统架构图 / 分层能力结构图 / 端到端流程图"哪一个
- 你不确定是否该补图，还是文字已经足够

如果当前问题已经能明确映射到单一 reference，就不要再额外读取 `README.md`。

## 实际规范文件

按路由结果引用：

- A 系统认知层：
  `@/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/Mermaid作图规范参考/references/mermaid-A-系统认知层.md`
- B 代码深潜层：
  `@/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/Mermaid作图规范参考/references/mermaid-B-代码深潜层.md`
- C 运行时行为层：
  `@/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/Mermaid作图规范参考/references/mermaid-C-运行时行为层.md`
- D 规划与演进层：
  `@/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/Mermaid作图规范参考/references/mermaid-D-规划与演进层.md`
- E 知识结构层：
  `@/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/Mermaid作图规范参考/references/mermaid-E-知识结构层.md`

## 强制输出约束

如果最终决定出图，必须同时满足下面约束：

**结构约束**

- 先写"Mermaid 路由声明"，明确：
  - 当前图回答什么问题
  - 使用哪份 reference
  - 为什么选它而不是别的
- 每张图前必须有 1-3 句前导语，说明阅读焦点和阅读路径
- 每张图后必须有文字说明
  - 节点不多时，至少 2 条要点
  - 节点超过 8 个或依赖复杂时，补 2-4 条要点解释设计判断
- 一张图只回答一个主问题
- 多张图时，先列出"图 1 / 图 2 / 图 3"分别回答什么问题
- 不能把不同 Mermaid 语法混成一张图

**样式约束（A / B 文件适用）**

- 必须使用 reference 中定义的 `classDef` 配色体系，不得自创颜色
- 按职责语义分配颜色：入口/客户端用深灰 `#1f2937`，编排/平台用蓝 `#1d4ed8`，生成能力用青蓝 `#0891b2` 或红 `#dc2626`，存储/分发用绿 `#059669`，注记节点用暖黄 `#fffbeb`
- `linkStyle` 必须按边的声明顺序从 0 开始精确计数；所有 `A & B --> C` 写法必须拆成独立行；在 `linkStyle` 前插入 `%% 边索引：0-N，共 X 条` 注释核对总数
- 每个 `subgraph` 末尾加 `class SubgraphName layerStyle` 统一背景色
- 关键路径附 `NOTE` 注记节点，用 `NOTE -.- 核心节点` 悬挂，不插入主流程连接线

**样式约束（C 文件适用）**

- `stateDiagram-v2` 和 `sequenceDiagram` 不支持 `classDef`、`linkStyle`、`subgraph`，不得从 A/B 借用 flowchart 写法
- 时序图必须在第一行写 `autonumber`
- 每个逻辑阶段前插入 `Note over 参与者A,参与者B: ① 阶段名 — 关键约束`

**样式约束（E 文件适用）**

- 整体低饱和，偏墨绿 / 深青 / 灰蓝主色，辅助色控制在 2-3 个
- 层次越深颜色越浅；禁用紫色、荧光色、糖果色
- 换行用 `<br/>`，不沿用 flowchart 的 `<br>`

## 常见失败模式

下面这些都算没有严格遵守本入口：

- 只写"这张图回答什么问题"，但没有声明用的是 A/B/C/D/E 哪份 reference
- 选了 `A` 或 `B`，却没有使用 reference 的 `classDef` 配色，自创了颜色
- 选了 `A` 或 `B`，`linkStyle` 计数错误或使用了 `&` 写法未拆行，导致渲染崩溃
- 选了 `C`，却混用了 `classDef`、`subgraph` 等 flowchart 语法
- 选了 `C`，却没有继承 `autonumber`、`Note over`、状态名贴源码等约束
- 选了 `B`，却没有用数据模型图或类层级图的表达方式
- 选了 `E`，却仍然画依赖流向或时间演进
- 图画出来了，但图后没有文字解释设计判断
- 实际问题是"是否需要图"，却默认强行补图

## 简版 Prompt 模板

如果你希望模型严格走这套路由，可直接在任务里加：

```text
先读取 @7.提示词与AI协作/Mermaid作图规范参考/mermaid-路引入口.md。
先输出 Mermaid 路由声明，再决定是否出图。
如果出图，只能读取必要的 reference 文件，严格继承该 reference 的配色体系和语法规范。
每张图都要有前导语和图后要点。
```

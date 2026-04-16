# Mermaid 作图风格指南 · A 系统认知层

> 适用场景：初探项目、架构评审、梳理核心业务链路、还原产品级分层总览图。
> 包含图表：① 系统架构图　② 分层能力结构图　③ 端到端流程图

## 目录

- 一、三种图的区别与选用
- 二、系统架构图
- 三、分层能力结构图
- 四、端到端流程图
- 五、作图规范
- 六、输出契约

---

## 一、三种图的区别与选用

### 1.1 先做速判

如果你只想快速决定该画哪一张，先用这张表：

| 你真正想看什么 | 应优先选择 |
|---------------|-----------|
| 系统里有哪些服务、组件、存储，它们怎么连接 | **系统架构图** |
| 方案按哪些阶段、能力域或生产环节分层展开 | **分层能力结构图** |
| 一个请求或任务从开始到结束怎么同步流转 | **端到端流程图** |

再换成更口语的判断方式：

- 想看“**系统怎么组成**”：
  - 选 **系统架构图**
- 想看“**方案按哪些层或阶段展开**”：
  - 选 **分层能力结构图**
- 想看“**事情怎么一步步发生**”：
  - 选 **端到端流程图**

常见混淆点：

- “分了很多层”不一定就是系统架构图  
  如果重点是“创作层、生成层、合成层、发布层”这类阶段或能力分组，通常更适合 **分层能力结构图**
- “有箭头连接”不一定就是流程图  
  如果箭头只是表达大阶段之间的主线推进，而不是严格步骤顺序，通常仍然是 **分层能力结构图**
- “看起来像系统全景”不一定就是平台分层图  
  如果重点不是职责边界，而是能力模块归组和总览排布，优先考虑 **分层能力结构图**

### 1.2 三种图的差异表

| 维度 | 系统架构图 | 分层能力结构图 | 端到端流程图 |
|------|-----------|---------------|------------|
| **Mermaid 语法** | `flowchart TB` | `flowchart TB` 或 `flowchart LR` | `flowchart LR` |
| **回答的问题** | 系统由哪些组件构成？如何部署和连接？ | 系统按哪些阶段或能力域分层展开？ | 一个请求如何在系统中同步流转？ |
| **视角** | 静态结构视图 | 分层总览视图 | 动态流程视图 |
| **节点代表** | 服务 / 组件 | 层内并列能力块 | 处理步骤 |
| **箭头代表** | 调用 / 部署关系 | 主线推进关系 | 数据流转顺序 |
| **类比** | 建筑平面图（房间布局） | 展厅导览图（按展区分层） | 消防演练路线图（人怎么走） |

```
需要理解"系统长什么样"                 → 系统架构图
需要理解"方案按哪些层或阶段展开"       → 分层能力结构图
需要理解"请求怎么走"（同步）           → 端到端流程图
```

推荐判断顺序：

```
第一步：先判断要看"组件连接"还是"能力分层"还是"处理流程"
    ↓
第二步：系统架构图 / 分层能力结构图 / 端到端流程图 三选一
```

一个系统可以同时有：

- 1 张系统架构图
- 1 张分层能力结构图
- 多张端到端流程图

---

## 二、系统架构图

### 2.1 适用场景

用于回答：这个项目有哪些服务？各层职责是什么？数据存在哪？如何部署？

首次接触一个项目需要理解系统整体构成时，或进行架构设计 / 评审时使用。

### 2.2 完整参考原图

> 展示客户端 → API 网关 → 服务网格 → 数据层的标准分层微服务架构

```mermaid
flowchart TB
    %% ── 配色主题：现代渐变紫蓝，按职责区分层次 ─────────────────────
    classDef clientStyle  fill:#1f2937,stroke:#111827,stroke-width:2px,color:#f9fafb
    classDef gatewayStyle fill:#1d4ed8,stroke:#1e3a8a,stroke-width:2.5px,color:#fff
    classDef authStyle    fill:#dc2626,stroke:#991b1b,stroke-width:2px,color:#fff
    classDef svcStyle     fill:#0891b2,stroke:#155e75,stroke-width:2px,color:#fff
    classDef mqStyle      fill:#d97706,stroke:#92400e,stroke-width:2px,color:#fff
    classDef dbStyle      fill:#059669,stroke:#064e3b,stroke-width:2px,color:#fff
    classDef cacheStyle   fill:#ea580c,stroke:#7c2d12,stroke-width:2px,color:#fff
    classDef noteStyle    fill:#fffbeb,stroke:#f59e0b,stroke-width:1.5px,color:#78350f
    classDef layerStyle   fill:#f8fafc,stroke:#cbd5e0,stroke-width:1.5px
    classDef infraStyle   fill:#fafaf9,stroke:#a8a29e,stroke-width:1.5px

    %% ── 客户端层 ─────────────────────────────────────────────────────
    subgraph CLIENT["客户端层"]
        direction LR
        WEB["Web 应用"]:::clientStyle
        APP["移动端 App"]:::clientStyle
        OPEN["三方开放平台"]:::clientStyle
    end
    class CLIENT layerStyle

    %% ── 接入层 ───────────────────────────────────────────────────────
    subgraph GATEWAY["接入层"]
        GW["API Gateway<br>限流 / 路由 / 熔断 / 负载均衡"]:::gatewayStyle
        AUTH["Auth Service<br>JWT 鉴权 / OAuth2"]:::authStyle
    end
    class GATEWAY layerStyle

    %% ── 业务服务层 ───────────────────────────────────────────────────
    subgraph SERVICES["业务服务层（Service Mesh）"]
        direction LR
        SVC_ORDER["订单服务<br>Order Service"]:::svcStyle
        SVC_USER["用户服务<br>User Service"]:::svcStyle
        SVC_NOTIFY["通知服务<br>Notify Service"]:::svcStyle
    end
    class SERVICES layerStyle

    %% ── 基础设施层 ───────────────────────────────────────────────────
    subgraph INFRA["基础设施层"]
        direction LR
        MQ[("消息队列<br>Kafka / RabbitMQ")]:::mqStyle
        CACHE[("缓存<br>Redis Cluster")]:::cacheStyle
        DB[("数据库<br>MySQL / PostgreSQL")]:::dbStyle
    end
    class INFRA infraStyle

    %% ── 数据流 ───────────────────────────────────────────────────────
    WEB   -->|"HTTPS 请求"| GW
    APP   -->|"HTTPS 请求"| GW
    OPEN  -->|"HTTPS 请求"| GW
    GW    -->|"Token 验证"| AUTH
    AUTH  -.->|"验证通过"| GW
    GW    -->|"路由分发"| SVC_ORDER
    GW    -->|"路由分发"| SVC_USER
    GW    -->|"路由分发"| SVC_NOTIFY

    SVC_ORDER  -->|"写入 / 查询"| DB
    SVC_ORDER  -->|"缓存加速"| CACHE
    SVC_ORDER  -->|"异步事件"| MQ
    MQ         -->|"消费通知"| SVC_NOTIFY
    SVC_USER   -->|"读写"| DB

    %% ── 设计注记 ─────────────────────────────────────────────────────
    NOTE["架构要点<br>① Gateway 统一处理横切关注点（鉴权/限流/日志）<br>② 服务间优先异步解耦（MQ），同步调用走内网<br>③ 热点数据走 Cache，DB 仅做持久化兜底"]:::noteStyle
    NOTE -.- SERVICES

    %% 边索引：0-13，共 14 条
    linkStyle 0,1,2 stroke:#374151,stroke-width:2px
    linkStyle 3      stroke:#dc2626,stroke-width:1.5px,stroke-dasharray:4 3
    linkStyle 4      stroke:#dc2626,stroke-width:1.5px,stroke-dasharray:4 3
    linkStyle 5,6,7  stroke:#1d4ed8,stroke-width:2px
    linkStyle 8,9    stroke:#059669,stroke-width:2px
    linkStyle 10     stroke:#ea580c,stroke-width:2px
    linkStyle 11     stroke:#d97706,stroke-width:2px,stroke-dasharray:4 3
    linkStyle 12     stroke:#d97706,stroke-width:2px
    linkStyle 13     stroke:#059669,stroke-width:2px
```

---

## 三、分层能力结构图

> 适用场景：产品能力总览图、阶段式架构图、原始分层大图 Mermaid 化。

用于回答：一个系统或方案按哪些阶段、能力域或生产环节分层展开？每层中有哪些并列能力块？层与层之间的主线如何推进？

它和常规系统架构图的区别：

- **不是技术架构图**
  - 不强调服务调用拓扑、数据库、消息队列、模型网关等实现细节
- **不完全等于平台分层图**
  - 重点不是职责边界，而是能力分组、阶段组织和整体主线
- **更适合产品级总览**
  - 常见于“创作层 -> 生成层 -> 合成层 -> 发布层”这类结构

推荐 Mermaid 结构模式：

- 语义上采用“分层 + 层内并列 + 主线串联”
- 每一层使用一个 `subgraph`
- 每层内部使用 `direction LR`
- 层内节点表达并列能力块
- 层间只保留主线箭头，不默认展开细碎调用关系

布局方向不要机械写死，按图面密度决定：

- 需要强调“自上而下”的阶段推进时，外层优先 `flowchart TB`
- 需要保留原始产品大图的横向展开感时，外层可以使用 `flowchart LR`

完整参考示例：

```mermaid
flowchart LR
    classDef entryStyle   fill:#1f2937,stroke:#111827,stroke-width:2px,color:#f9fafb
    classDef scriptStyle  fill:#1d4ed8,stroke:#1e3a8a,stroke-width:2px,color:#fff
    classDef visualStyle  fill:#0891b2,stroke:#155e75,stroke-width:2px,color:#fff
    classDef videoStyle   fill:#dc2626,stroke:#991b1b,stroke-width:2px,color:#fff
    classDef editStyle    fill:#d97706,stroke:#92400e,stroke-width:2px,color:#fff
    classDef storeStyle   fill:#059669,stroke:#064e3b,stroke-width:2px,color:#fff
    classDef noteStyle    fill:#fffbeb,stroke:#f59e0b,stroke-width:1.5px,color:#78350f
    classDef layerStyle   fill:#f8fafc,stroke:#cbd5e0,stroke-width:1.5px

    subgraph ENTRY["入口层 Entry"]
        direction LR
        USER["用户输入<br>主题 / 故事梗概 / 角色设定"]:::entryStyle
        STUDIO["创作平台<br>Web / App<br>创作者工作台"]:::entryStyle
        API["API 接入<br>第三方调用<br>批量生成任务"]:::entryStyle
        ASSET_IN["素材导入<br>自定义角色<br>参考图 / 风格图"]:::entryStyle
    end
    class ENTRY layerStyle

    subgraph SCRIPT["剧本生成层 Script Generation"]
        direction LR
        STORY["故事规划<br>主题分析<br>世界观设定"]:::scriptStyle
        BOARD_SCRIPT["分镜脚本<br>剧情拆分<br>分镜描述生成"]:::scriptStyle
        DIALOG["台词生成<br>角色对话<br>情绪与语气控制"]:::scriptStyle
        SCENE_OUT["分镜表输出<br>Scene List<br>镜头编号 / 时长"]:::scriptStyle
    end
    class SCRIPT layerStyle

    subgraph VISUAL["视觉生成层 Visual Generation"]
        direction LR
        CHAR["角色生成<br>角色形象设计<br>表情 / 姿态示例"]:::visualStyle
        SCENE["场景生成<br>背景图生成<br>多风格场景切换"]:::visualStyle
        SHOT["分镜画面生成<br>按分镜描述生成<br>保持角色一致性"]:::visualStyle
        IMG_POST["图像后处理<br>超分辨率放大<br>风格统一 / 修复"]:::visualStyle
    end
    class VISUAL layerStyle

    subgraph VIDEO["视频合成层 Video Composition"]
        direction LR
        ANIM["动画 / 运镜生成<br>关键帧补间<br>动态镜头切换"]:::videoStyle
        TTS["语音合成 TTS<br>角色配音<br>情感语气 / 口型适配"]:::videoStyle
        MUSIC["配乐音效<br>背景音乐生成<br>环境音循环 / 增强"]:::videoStyle
        SUB["字幕与特效<br>自动字幕生成<br>滤镜特效 / 转场"]:::videoStyle
    end
    class VIDEO layerStyle

    subgraph EDIT["编辑与优化层 Editing & Optimize"]
        direction LR
        EDIT_TIME["时间轴编辑<br>分镜顺序调整<br>时长裁剪 / 节奏控制"]:::editStyle
        EDIT_IMAGE["画面微调<br>镜像翻转<br>风格滤镜 / 色彩调整"]:::editStyle
        EDIT_AUDIO["声音调节<br>音量 / 音效平衡<br>背景音乐替换"]:::editStyle
        EXPORT["一键导出<br>预览播放<br>多格式视频输出"]:::editStyle
    end
    class EDIT layerStyle

    subgraph STORE["存储与分发层 Storage & Distribution"]
        direction LR
        LIB["素材资产库<br>角色 / 场景缓存<br>可复用素材管理"]:::storeStyle
        WORK["作品管理<br>版本记录<br>草稿与成片管理"]:::storeStyle
        PUBLISH["分发发布<br>多平台发布<br>封面 / 标签 / 简介生成"]:::storeStyle
        ANALYTICS["数据分析<br>播放量 / 完播率<br>用户互动数据"]:::storeStyle
    end
    class STORE layerStyle

    ENTRY -->|"创作输入"| SCRIPT
    SCRIPT -->|"脚本与分镜"| VISUAL
    VISUAL -->|"视觉素材"| VIDEO
    VIDEO -->|"视频草稿"| EDIT
    EDIT -->|"导出成片"| STORE

    NOTE["整体主线<br>入口层 -> 剧本生成层 -> 视觉生成层 -> 视频合成层 -> 编辑与优化层 -> 存储与分发层<br><br>结构重点<br>① 每一层表示一组并列能力块，不表示服务调用拓扑<br>② 层内节点强调能力归属，不强调先后顺序<br>③ 层间箭头只表达主流程推进，不展开技术细节"]:::noteStyle
    NOTE -.- STORE
```

这种图的阅读方式是：

- 先按“层”看整体结构
- 再看每层里的并列能力块
- 最后看层与层之间的主线推进

它不适合回答：

- 哪个服务调哪个服务
- 哪个组件读写哪个数据库
- 哪一步发生异步回调

这些问题应改用系统架构图、时序图或异步链路图。

---

## 四、端到端流程图

### 4.1 适用场景

用于回答：一个用户操作从发起到完成，经过了哪些步骤？数据如何被加工和传递？

梳理核心业务功能的完整处理链路、排查请求路径的性能瓶颈、向新成员讲解业务流程时使用。

### 4.2 完整参考原图

> 展示用户输入 → 预处理 → 记忆检索 → 上下文构建 → LLM 推理 → 后处理 → 持久化的完整 AI 对话记忆流程

```mermaid
flowchart LR
    %% ── 配色定义：按流程阶段职责分色 ──────────────────────────────
    classDef userStyle     fill:#1e40af,stroke:#1e3a8a,stroke-width:2.5px,color:#fff
    classDef routeStyle    fill:#4f46e5,stroke:#3730a3,stroke-width:2px,color:#fff
    classDef retrieveStyle fill:#d97706,stroke:#92400e,stroke-width:2px,color:#fff
    classDef llmStyle      fill:#dc2626,stroke:#991b1b,stroke-width:2.5px,color:#fff
    classDef storeStyle    fill:#059669,stroke:#064e3b,stroke-width:2px,color:#fff
    classDef dbStyle       fill:#374151,stroke:#111827,stroke-width:2px,color:#fff
    classDef noteStyle     fill:#fffbeb,stroke:#f59e0b,stroke-width:1.5px,color:#78350f
    classDef layerStyle    fill:#f8fafc,stroke:#cbd5e0,stroke-width:1.5px

    %% ── 起始节点 ────────────────────────────────────────────────
    USER["用户输入<br>User Input"]:::userStyle

    %% ── 预处理层 ─────────────────────────────────────────────────
    subgraph Preprocessing["预处理层"]
        direction LR
        PP1["意图识别<br>Intent Classification"]:::routeStyle
        PP2["实体提取<br>NER Extraction"]:::routeStyle
        PP3["记忆信号检测<br>Memory Signal Detection"]:::routeStyle
    end
    class Preprocessing layerStyle

    %% ── 记忆检索层 ───────────────────────────────────────────────
    subgraph MemoryRetrieval["记忆检索层"]
        direction LR
        MR1["语义检索<br>Semantic Search"]:::retrieveStyle
        MR2["结构化查询<br>Structured Query"]:::retrieveStyle
        MR3["结果融合排序<br>RRF Fusion"]:::retrieveStyle
    end
    class MemoryRetrieval layerStyle

    %% ── 上下文构建层 ─────────────────────────────────────────────
    subgraph ContextBuild["上下文构建层"]
        direction LR
        CB1["System Prompt<br>角色与规则"]:::routeStyle
        CB2["记忆注入<br>Memory Injection"]:::retrieveStyle
        CB3["当前对话<br>Current Dialog"]:::userStyle
    end
    class ContextBuild layerStyle

    %% ── 核心推理节点 ─────────────────────────────────────────────
    LLM["大语言模型推理<br>LLM Inference"]:::llmStyle

    %% ── 后处理层 ─────────────────────────────────────────────────
    subgraph PostProcess["后处理层"]
        direction LR
        POST1["回复质量检查<br>Quality Check"]:::routeStyle
        POST2["新记忆提取<br>Memory Extraction"]:::storeStyle
        POST3["记忆价值评估<br>Value Assessment"]:::storeStyle
    end
    class PostProcess layerStyle

    %% ── 持久化层 ─────────────────────────────────────────────────
    subgraph Storage["持久化层"]
        direction LR
        DB1[("向量数据库<br>Vector DB")]:::dbStyle
        DB2[("用户画像文件<br>Profile JSON")]:::dbStyle
        DB3[("情景日志<br>Episode Log")]:::dbStyle
    end
    class Storage layerStyle

    %% ── 终止节点 ────────────────────────────────────────────────
    RESPONSE["输出回复<br>Response"]:::userStyle

    %% ── 主流程数据流 ─────────────────────────────────────────────
    USER --> Preprocessing
    Preprocessing --> MemoryRetrieval
    Preprocessing --> CB3
    MemoryRetrieval --> CB2
    CB1 --> LLM
    CB2 --> LLM
    CB3 --> LLM
    LLM --> PostProcess
    LLM --> RESPONSE
    PostProcess -->|"高价值记忆"| DB1
    PostProcess -->|"结构化信息"| DB2
    PostProcess -->|"情景摘要"| DB3
    DB1 --> MR1
    DB2 --> MR2

    %% ── 设计注记 ─────────────────────────────────────────────────
    NOTE["完整流程关键路径<br>① 检索延迟目标：< 50ms<br>② 存储操作：异步执行<br>③ 上下文记忆占比：< 30%<br>④ 每用户记忆上限：建议 10K 条"]:::noteStyle
    NOTE -.- LLM

    %% 边索引：0-13，共 14 条
    linkStyle 0 stroke:#1e40af,stroke-width:2px
    linkStyle 1 stroke:#4f46e5,stroke-width:2px
    linkStyle 2 stroke:#1e40af,stroke-width:1.5px
    linkStyle 3 stroke:#d97706,stroke-width:2px
    linkStyle 4 stroke:#dc2626,stroke-width:2px
    linkStyle 5 stroke:#dc2626,stroke-width:2px
    linkStyle 6 stroke:#dc2626,stroke-width:2px
    linkStyle 7 stroke:#4f46e5,stroke-width:2px
    linkStyle 8 stroke:#dc2626,stroke-width:2.5px
    linkStyle 9 stroke:#059669,stroke-width:2px
    linkStyle 10 stroke:#059669,stroke-width:2px
    linkStyle 11 stroke:#059669,stroke-width:2px
    linkStyle 12 stroke:#374151,stroke-width:1.5px,stroke-dasharray:4 3
    linkStyle 13 stroke:#374151,stroke-width:1.5px,stroke-dasharray:4 3
```

---

## 五、最佳实践速查

| 设计原则 | 说明 |
|----------|------|
| **配色语义** | 按职责或阶段区分节点颜色：入口/客户端可用深灰（`#1f2937`），平台/编排可用蓝（`#1d4ed8`），生成能力可用青蓝（`#0891b2`）或红（`#dc2626`），治理与编辑可用琥珀（`#d97706`），存储与分发可用绿（`#059669`），注记节点用低饱和暖色（`#fffbeb`） |
| **流程方向** | 系统架构图常用 `TB`；端到端流程图常用 `LR`；分层能力结构图按图面选择 `TB` 或 `LR`，但层内统一 `direction LR` 横排 |
| **分层能力结构图** | 优先表达“层”和“层内并列能力块”；层间只保留主线箭头，不默认补技术调用边 |
| **分层 subgraph** | 用 `subgraph` 将同职责节点归组；每个子图对应一个处理层级；`class SubgraphName layerStyle` 统一背景色区分层级 |
| **起止节点突出** | 起始节点（用户输入）和终止节点（输出回复）使用最高对比度颜色（`#1e40af` 深蓝），与中间处理节点形成视觉区分 |
| **连接线语义** | `-->` 表示同步调用；`-.->` 表示异步调用或可选路径；`==>` 表示关键/强制路径；连接线标签简明描述数据内容或操作语义 |
| **`linkStyle` 索引精准计数** | `linkStyle N` 按边的**声明顺序**从 0 开始编号，索引越界会触发渲染崩溃。两条规避守则：① **展开 `&`**：`A & B --> C` 会展开为多条独立边，凡使用 `linkStyle` 的图一律拆成独立行；② **注释标注边总数**：在连接线声明结束后、`linkStyle` 之前插入 `%% 边索引：0-N，共 X 条` 注释强制核对 |
| **节点形状语义** | `["text"]` 矩形表示服务/处理步骤；`[("text")]` 圆柱体表示持久化存储（DB、向量库、文件等） |
| **节点换行** | 换行用 `<br>`；首行写中文业务名，`<br>` 后补英文技术名，兼顾可读性与技术精确性 |
| **NOTE 注记** | 通过 `NOTE` 节点附加关键路径说明；用 `NOTE -.- 核心节点` 悬浮挂载，与主流程连接线视觉隔离 |
| **中英双语** | 节点文本和连接线标签适当中英双语（如 `"语义检索<br>Semantic Search"`） |

## 六、输出契约

| 规则 | 说明 |
|------|------|
| **先问题，后出图** | 每张图输出前，先用一句话说明“这张图回答什么问题” |
| **按需补图** | 不预设固定图数量，按当前问题复杂度决定补 0-N 张图 |
| **一图一职责** | 单张图只回答一个主问题；如果需要同时解释“系统组成”和“请求怎么走”，应拆成两张图 |
| **先选图型，再套风格** | 先判断当前更适合系统架构图、分层能力结构图还是端到端流程图，再复用本 reference 的视觉语言 |
| **避免为完整感硬补图** | 如果文字已经足够清楚，就不要为了显得完整而额外补图 |
| **多图时先列清单** | 如果需要多张图，先列出“第 1 张回答什么、第 2 张回答什么”，再依次输出 |

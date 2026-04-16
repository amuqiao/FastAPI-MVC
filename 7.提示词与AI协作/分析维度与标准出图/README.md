# 分析维度与标准出图

> 文档职责：定义项目分析场景下的标准图名、所属维度、采用标准和一句话用途，并作为本目录的唯一入口。  
> 适用场景：为任意项目快速决定“该画哪些图”时使用。  
> 阅读目标：先确定分析维度，再用唯一图名定位标准图种，最后进入对应图文档。  
> 目标读者：需要维护项目分析方法和出图标准的人。

## 1. 目录标准

本目录只维护两类内容：

- 一张总表：说明 `维度 / 图名 / 标准 / 一行解释`
- 对应图文档：每个文档只负责一种图

## 2. 命名原则

- 图名是唯一索引，不用同义词并列做主名称
- 只有总表里的 `图名` 一栏保留 `中文名（English Name）` 形式
- `标准` 一栏优先写正式标准名；如果没有正式标准，则写通用业界名称
- 旧图名只作为历史别名，不再作为主命名继续维护

## 3. 标准图总表

### 3.1 核心图

| 维度 | 图名 | 标准 | 一行解释 |
|------|------|------|---------|
| 认知维度 | 目录结构图（Directory Structure Diagram） | Tree View / Annotated Tree | 使用文本树展示源码、文档或资源目录层级，并标注关键模块职责。 |
| 认知维度 | 技术栈图（Tech Stack Diagram） | Tech Stack Diagram | 按前端、后端、数据层、基础设施、运维工具等维度分类展示技术组件。 |
| 上下文维度 | 系统上下文图（System Context Diagram） | C4 Model Level 1 | 展示系统与用户、外部系统和业务环境之间的关系。 |
| 结构维度 | 整体架构图（High-Level Architecture Diagram） | C4 Model Level 2 | 展示系统边界、核心子系统、外部依赖及主要交互协议。 |
| 能力维度 | 分层能力结构图（Layered Capability Map） | Layered Capability Map | 按用户层、应用层、服务层、数据层、基础平台层组织关键能力。 |
| 动态维度 | 核心业务链路图（Key Business Flow Diagram） | UML Sequence / Business Flow | 选取一个典型端到端业务场景，展示关键节点、数据流向和异常分支。 |
| 数据维度 | 数据模型图（Data Model Diagram） | Data Model / ERD | 展示核心实体、表关系和关键引用字段。 |
| 部署维度 | 部署图（Deployment Diagram） | C4 Deployment | 展示运行环境、节点区域、网络入口和部署边界。 |

### 3.2 按需补充图

| 维度 | 图名 | 标准 | 一行解释 |
|------|------|------|---------|
| 结构维度 | 核心组件图（Component Diagram） | C4 Model Level 3 | 深潜某个核心容器内部的组件划分与协作关系。 |
| 代码维度 | 代码图（Code Diagram） | C4 Model Level 4 / UML Class | 深潜某个核心组件内部的代码结构、接口层次和实现关系。 |
| 结构维度 | 模块依赖图（Module Dependency Diagram） | Module Dependency Diagram | 展示模块依赖方向、公共模块边界和循环依赖风险。 |
| 动态维度 | 状态机图（State Machine Diagram） | UML State Machine | 展示核心实体或异步任务的状态迁移和触发条件。 |
| 规划维度 | 甘特图（Gantt Chart） | Gantt | 展示项目分阶段排期、任务依赖和并行关系。 |
| 演进维度 | 时间线图（Timeline Diagram） | Timeline | 展示技术、产品或架构在时间轴上的演进节点。 |

## 4. 旧图名归并关系

为了保证“图名 = 唯一索引”，旧图名统一按下面方式归并：

- `架构图`、`系统架构图`、`系统容器图` 统一归到 `整体架构图`
- `核心业务链图`、`端到端流程图` 统一归到 `核心业务链路图`
- `思维导图`、`技术栈与模块地图` 在项目分析场景下优先归到 `技术栈图`
- `部署架构图` 统一归到 `部署图`
- `项目上下文图` 统一归到 `系统上下文图`
- `数据模型关系图` 统一归到 `数据模型图`

## 5. 当前目录图文档

- [目录结构图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/目录结构图.md)
- [分层能力结构图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/分层能力结构图.md)
- [系统上下文图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/系统上下文图.md)
- [整体架构图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/整体架构图.md)
- [核心组件图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/核心组件图.md)
- [代码图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/代码图.md)
- [模块依赖图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/模块依赖图.md)
- [状态机图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/状态机图.md)
- [核心业务链路图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/核心业务链路图.md)
- [部署图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/部署图.md)
- [数据模型图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/数据模型图.md)
- [技术栈图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/技术栈图.md)
- [甘特图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/甘特图.md)
- [时间线图](/Users/admin/Downloads/Code/AI-Engineering-Knowledge-Base/7.提示词与AI协作/分析维度与标准出图/时间线图.md)

## 6. 当前状态

当前总表中的图种都已经有对应文档。

## 7. 维护规则

- 不再拆维度子文档
- 文档名直接与图名对齐
- 每个图文档只负责一种图，不混入别的图种
- 如果后续新增图种，先更新总表，再新增对应图文档

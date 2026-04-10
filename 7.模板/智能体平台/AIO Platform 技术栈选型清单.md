# AIO Platform 技术栈选型清单

## 前端

| 类别 | 选型 | 版本 |
| --- | --- | --- |
| 框架 | Next.js (App Router) | 14.2+ |
| 语言 | TypeScript | 5.4 |
| UI 组件 | shadcn/ui (Radix UI primitives) | — |
| 样式 | Tailwind CSS | 3.4 |
| 状态管理 | Zustand（全局）+ React Query（服务端） | 4.5 / 5.28 |
| 数据请求 | Axios + TanStack React Query | 1.6 / 5.28 |
| 拖拽 | dnd-kit | 6.3 |
| 流程画布 | XYFlow (React Flow) | 12.9 |
| 动画 | Framer Motion | 11.0 |
| 国际化 | next-intl | 4.5 |
| 图标 | Lucide React | 0.356 |
| 单测 | Vitest + Testing Library + happy-dom | 1.3 |
| E2E | Playwright | 1.58 |
| Lint | ESLint (next config) + Prettier | 8.57 / 3.2 |
| Runtime | Node 20 (Alpine) | >=18 |

## 后端

| 类别 | 选型 | 版本 |
| --- | --- | --- |
| 框架 | FastAPI | 0.109+ |
| 语言 | Python | 3.11 |
| ASGI | Uvicorn | 0.24+ |
| ORM | SQLAlchemy | 2.0 |
| 迁移 | Alembic | 1.13 |
| 数据校验 | Pydantic | 2.5 |
| 异步任务 | Celery | 5.3 |
| 缓存/消息 | Redis | 5.0 |
| 认证 | python-jose (JWT) + passlib (bcrypt) | — |
| 限流 | SlowAPI | 0.1.9 |
| 日志 | Loguru | 0.7 |
| HTTP 客户端 | HTTPX | 0.25 |
| 模板引擎 | Jinja2 | 3.1 |
| 图片处理 | Pillow | 10.0 |
| 文档解析 | pdfplumber + python-docx | — |
| JSON 修复 | json-repair + jsonschema | — |
| 测试 | pytest + httpx | 7.4 |

## AI / 生成服务

| 类别 | 选型 | 说明 |
| --- | --- | --- |
| LLM Gateway | 多 Provider 统一网关 | 自建 ModelHandler |
| LLM — Gemini | google-genai SDK | 叙事分析 / prompt 组装 / 安全重写 |
| LLM — OpenAI | openai SDK | GPT 系列 |
| LLM — Claude | anthropic SDK | Anthropic 系列 |
| 图片生成 | Gemini Image (google-genai) | 主力，多参考图 |
| 图片生成 | Kling Image (PiAPI) | 备选，无参考图支持 |
| 视频生成 | Google Veo (REST API) | 主力，首帧+尾帧 |
| 视频生成 | Kling Video (PiAPI) | 备选，仅首帧 |
| Prompt 引擎 | ConfigBasedPromptBuilder | 自建，配置驱动 |

## 数据存储

| 类别 | 选型 | 说明 |
| --- | --- | --- |
| 关系数据库 | PostgreSQL (Cloud SQL) | 主存储 |
| 对象存储 | Google Cloud Storage (GCS) | 图片/视频文件 |
| 缓存/队列 | Redis | Celery broker + 缓存 |

## 部署 & DevOps

| 类别 | 选型 | 说明 |
| --- | --- | --- |
| 容器化 | Docker | 前后端各一个 Dockerfile |
| CI/CD | Google Cloud Build | cloudbuild.yaml |
| 运行平台 | Google Cloud Run | 前后端独立服务 |
| 前端构建 | Next.js standalone output | node server.js |
| 后端运行 | Uvicorn | 单进程 ASGI |

## 架构模式

| 模式 | 说明 |
| --- | --- |
| 前后端分离 | Next.js (SSR/CSR) ↔ FastAPI (REST API) |
| Tower 隔离 | 5 业务塔 + 1 基础设施塔，塔间通过 Kernel 共享 |
| 配置驱动生成 | hierarchy_templates YAML 定义实体层级和生成规则 |
| Provider Registry | YAML 注册表声明 provider capabilities，运行时动态加载 |
| 异步任务 | Celery + Redis 处理长时间生成任务 |
| 轮询状态 | 前端 React Query refetchInterval（无 WebSocket/SSE） |

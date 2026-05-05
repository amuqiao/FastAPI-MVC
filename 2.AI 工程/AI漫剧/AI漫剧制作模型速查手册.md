---
tags: [AI工具, 漫剧制作, 速查手册]
updated: 2026-04-25
cssclasses: [comic-ref]
---

# 🎬 AI 漫剧制作 · 模型与平台速查手册

> **更新于** 2026-04-25 ｜ 按厂商分组 · 覆盖全链路 · 含 API 接入信息

## 📌 核心概念区分（新手必读）

> [!tip] 三种角色，别搞混
> - **底层模型**（有API）：真正做生成的 AI，开发者通过 API 调用。如 Seedance 2.0、Kling 3.0、Wan2.5
> - **创作平台**（无/少API）：把多个模型封装成可视化工作台。如即梦、LibTV、可灵网页端
> - **云服务入口**（API网关）：大厂的开发者平台，用来拿 API Key。如阿里云百炼、火山引擎、Google AI Studio

> [!warning] 常见混淆澄清
> - **通义千问** = 文字对话模型 ｜ **通义万相（Wanx）** = 文生图 ｜ **Wan2.5** = 视频生成 → 同一家公司，三个不同模型
> - **即梦** = 字节创作平台，底层是 Seedance ｜ **火山引擎** = 字节 API 网关 ｜ **Seedance** = 底层视频模型
> - **HappyHorse** = 阿里淘天集团出品，本质阿里系，前快手可灵负责人张迪带队
> - **LibTV** = LiblibAI 出品的全流程创作平台，底层聚合了 20+ 主流模型

---

## 🗺️ 完整创作流程

```
① 文本/剧本  →  ② 文生图/角色  →  ③ 分镜一致性  →  ④ 首尾帧/参考  →  ⑤ 视频生成  →  ⑥ 语音合成
```

---

## 💬 一、文本对话 · 剧本生成 · 提示词工程

| 厂商 | 模型 | 效果 | 价格参考 | API Endpoint |
|------|------|------|----------|--------------|
| `OpenAI` | **GPT-4o** | ⭐⭐⭐⭐⭐ 多模态理解强，图像解读 | $2.5/$10 per M tokens | `POST api.openai.com/v1/chat/completions` model: `gpt-4o` |
| `OpenAI` | **o3**（推理） | ⭐⭐⭐⭐⭐ 复杂剧情推演，逻辑自洽 | $10–$40 per M tokens | `POST api.openai.com/v1/chat/completions` model: `o3` |
| `Anthropic` | **Claude Sonnet 4.6** 🏆 | ⭐⭐⭐⭐⭐ 创意写作最强，长文本角色对话 | $3/$15 per M tokens | `POST api.anthropic.com/v1/messages` model: `claude-sonnet-4-6` |
| `Anthropic` | **Claude Opus 4** | ⭐⭐⭐⭐⭐ 最高质量，复杂剧本 | $15/$75 per M tokens | `POST api.anthropic.com/v1/messages` model: `claude-opus-4-5` |
| `Google` | **Gemini 2.5 Pro** | ⭐⭐⭐⭐⭐ 长上下文 2M，视频理解 | $1.25/$10 per M tokens | `POST generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent` |
| `Google` | **Gemini 2.0 Flash** | ⭐⭐⭐⭐ 快速响应，适合批量生成 | 免费额度 / $0.1/$0.4 | `POST .../gemini-2.0-flash:generateContent` |
| `DeepSeek` | **DeepSeek V3** 💰 | ⭐⭐⭐⭐ 中文极优，低延迟批量 | ¥0.27/M tokens 极低 | `POST api.deepseek.com/v1/chat/completions` model: `deepseek-chat` |
| `DeepSeek` | **DeepSeek R1**（推理） | ⭐⭐⭐⭐ 深度剧情推演 | ¥1.0/$4 per M tokens | `POST api.deepseek.com/v1/chat/completions` model: `deepseek-reasoner` |
| `阿里云` | **Qwen3-235B** 🏆国内 | ⭐⭐⭐⭐⭐ 中文剧本优秀，MoE架构 | ¥0.8/M tokens，有免费额度 | `POST dashscope.aliyuncs.com/compatible-mode/v1/chat/completions` model: `qwen3-235b-a22b` |
| `阿里云` | **Qwen3-30B-A3B** 轻量 | ⭐⭐⭐⭐ 低成本批量台词生成 | ¥0.2/M tokens 极低 | `POST dashscope.aliyuncs.com/compatible-mode/v1` model: `qwen3-30b-a3b` |
| `字节跳动` | **豆包 1.5 Pro** | ⭐⭐⭐⭐ 中文语义优秀，字节生态 | ¥0.8/M tokens，有免费额度 | `POST ark.cn-beijing.volces.com/api/v3/chat/completions` model: `doubao-1.5-pro-32k` |

---

## 🎨 二、文生图 · 角色设计 · 场景插画

| 厂商 | 模型 | 效果 | 价格参考 | API Endpoint |
|------|------|------|----------|--------------|
| `OpenAI` | **GPT-Image-2** 🔥2026.4.21 | ⭐⭐⭐⭐⭐ 推理生图，文字渲染近完美，2K | $8/$30 per M tokens | `POST api.openai.com/v1/images/generations` model: `gpt-image-2`（API 5月开放） |
| `OpenAI` | **GPT-Image-1.5** | ⭐⭐⭐⭐ 速度快4倍，稳定可靠 | $5/$20 per M tokens | `POST api.openai.com/v1/images/generations` model: `gpt-image-1.5` |
| `Google` | **Imagen 3**（Vertex AI） | ⭐⭐⭐⭐⭐ 构图理解强，Arena 排名 #1 | $0.04/张，高性价比 | `POST us-central1-aiplatform.googleapis.com/v1/projects/{proj}/locations/us-central1/publishers/google/models/imagegeneration@006:predict` |
| `BFL` | **FLUX 1.1 Pro Ultra** 🏆 | ⭐⭐⭐⭐⭐ 漫画/写实细节极致，无审查 | $0.04–0.06/张 | `POST fal.run/fal-ai/flux-pro/v1.1-ultra`（通过 fal.ai） |
| `BFL` | **FLUX 1.1 Pro** 快速版 | ⭐⭐⭐⭐ 适合批量分镜草稿 | $0.025/张，低成本 | `POST fal.run/fal-ai/flux-pro/v1.1`（通过 fal.ai） |
| `阿里云` | **通义万相 Wanx2.1** 🏆国内 | ⭐⭐⭐⭐ 国风/动漫优秀，中文提示词佳 | ¥0.14/张，高性价比 | `POST dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis` model: `wanx2.1-t2i-turbo` |
| `阿里云` | **Qwen-Image-2.0** | ⭐⭐⭐⭐ 文字渲染强，漫画排版 | ¥0.12/张 | `POST dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis` model: `qwen-image-2.0` |
| `腾讯` | **HunyuanImage 2.1** | ⭐⭐⭐⭐ 2K高清，毫秒级实时生图 | 腾讯云按量，有免费额度 | `POST hunyuan.tencentcloudapi.com` Action: `TextToImageLite` |
| `MiniMax` | **MiniMax Image-01** 💰 | ⭐⭐⭐ 批量出图首选，质量中上 | $0.01/张 极低成本 | `POST api.minimax.chat/v1/image_generation` model: `image-01` |
| `智谱AI` | **CogView-4** | ⭐⭐⭐ 动漫风格好，中文强 | ¥0.1/张，极低 | `POST open.bigmodel.cn/api/paas/v4/images/generations` model: `cogView-4` |
| `开源` | **Stable Diffusion 3.5 + LoRA** | ⭐⭐⭐⭐ 角色一致性最强，LoRA定制 | 本地免费（需 8GB+ VRAM） | `POST 127.0.0.1:7860/sdapi/v1/txt2img`（本地 WebUI） |
| `开源` | **FLUX 本地部署** | ⭐⭐⭐⭐ 画质媲美商业，完全开源 | 本地免费（需 12–24GB VRAM） | `POST 127.0.0.1:8188/api/prompt`（ComfyUI） |

---

## 🎞️ 三、视频生成 · 图生视频 · 首尾帧控制

> [!info] 开发者注意
> 视频生成均为**异步任务**：先提交获取 `task_id`，再轮询状态接口，`completed` 后下载视频 URL

| 厂商 | 模型 | 效果 | 价格参考 | API Endpoint |
|------|------|------|----------|--------------|
| `OpenAI` | **Sora 2** | ⭐⭐⭐⭐⭐ 电影级，多镜头一致性 | $0.03–0.08/秒，偏贵 | ⚠️ API 预计 2026 下半年开放，现用 ChatGPT 界面或 fal.ai 代理 |
| `Google` | **Veo 3**（Vertex AI） | ⭐⭐⭐⭐⭐ 电影级，原生音视频同步 | $0.05/秒，中高端 | `POST us-central1-aiplatform.googleapis.com/v1/projects/{proj}/locations/us-central1/publishers/google/models/veo-3:predictLongRunning` |
| `字节/火山` | **Seedance 2.0** 🏆 | ⭐⭐⭐⭐⭐ 12路输入，良品率 90%+，音画同步 | 火山引擎约 ¥0.4–0.8/5秒 | `POST open.volcengineapi.com/v1/video_generation/seedance`（需企业资质）📱 即梦平台：jimeng.jianying.com |
| `阿里云` | **通义万相 Wan2.5** 🏆音画 | ⭐⭐⭐⭐⭐ 首个音画同步（人声+音效+BGM），已开源 | DashScope按秒，约 ¥0.3–0.6/5秒 | `POST dashscope.aliyuncs.com/api/v1/services/aigc/video-generation/video-synthesis` model: `wan2.5-vace-14b` |
| `阿里（淘天）` | **HappyHorse-1.0** 🔥 | ⭐⭐⭐⭐⭐ T2V+I2V 全球双榜 #1，原生音视频，7语言唇同步 | 开源免费（H100）/ 云端约 $0.03–0.06/秒 | 📱 happyhorse.app（网页端）｜GitHub 即将开源 ｜fal.ai 代理接入 |
| `快手` | **Kling 3.0** 🏆首尾帧 | ⭐⭐⭐⭐⭐ 首尾帧最成熟，1080p/30fps | ¥0.35/5秒，高性价比 | `POST api.klingai.com/v1/videos/image2video` `{"image":"首帧URL","image_tail":"尾帧URL","duration":5,"model":"kling-v1-5"}` |
| `快手` | **Kling 3.0 Pro** 文生视频 | ⭐⭐⭐⭐⭐ 智能分镜，电影级构图 | ¥0.7/5秒，中等 | `POST api.klingai.com/v1/videos/text2video` `{"prompt":"...","model":"kling-v1-5","mode":"pro"}` |
| `腾讯` | **HunyuanVideo I2V** 开源 | ⭐⭐⭐⭐ 130B开源，2K，对口型+动作驱动 | 开源自部署 / 腾讯云按量 | `POST hunyuan.tencentcloudapi.com` Action: `SubmitHunyuanToVideoJob` GitHub: `Tencent/HunyuanVideo-I2V` |
| `MiniMax` | **Hailuo 2.3** | ⭐⭐⭐⭐ S2V主体参考，角色一致性强 | 约 ¥0.3–0.5/5秒 | `POST api.minimax.chat/v1/video_generation` `{"model":"video-01","subject_reference":[{"image":"参考图URL"}]}` |
| `Runway` | **Gen-4 Turbo** | ⭐⭐⭐⭐ 精确镜头控制，电影感 | $0.05/秒，偏贵 | `POST api.runwayml.com/v1/image_to_video` `{"promptImage":"URL","duration":5,"ratio":"1280:720","model":"gen4_turbo"}` |
| `开源` | **HappyHorse / daVinci-MagiHuman** | ⭐⭐⭐⭐⭐ 15B参数，8步推理，5秒1080p仅需38秒 | 开源免费（需 H100） | GitHub: 即将发布 ｜当前可通过 happyhorse.app 网页体验 |

### 首尾帧专项对比

| 模型 | 首尾帧支持 | 参数名 | 备注 |
|------|-----------|--------|------|
| **Kling 3.0** | ✅ 最成熟 | `image` + `image_tail` | 业界标杆，文档完善 |
| **Wan2.5** | ✅ 支持 | `first_frame_image` + `last_frame_image` | 同时支持音画同步 |
| **Hailuo S2V** | ✅ 主体参考 | `subject_reference` | 单图角色全程一致 |
| **Runway Gen-4** | ✅ 支持 | `firstFrame` + `lastFrame` | 镜头控制精细 |
| **Sora 2** | ✅ 支持 | API 待开放 | 现需 ChatGPT 界面 |

---

## 🔊 四、语音合成 · 声音克隆 · 角色配音

| 厂商 | 模型 | 效果 | 价格参考 | API Endpoint |
|------|------|------|----------|--------------|
| `MiniMax` | **Speech-02** 🏆全球双料冠军 | ⭐⭐⭐⭐⭐ TTS Arena #1，32语言，中文极优 | ElevenLabs 的 1/4 价 约 $0.5/百万字符 | `POST api.minimax.chat/v1/t2a_v2` `{"model":"speech-02-hd","text":"...","voice_id":"...","emotion":"happy"}` |
| `MiniMax` | **Speech-02 声音克隆** | ⭐⭐⭐⭐⭐ 6秒克隆，12语言，6种情绪 | 同上，克隆需开通权限 | `POST api.minimax.chat/v1/voice_clone` `{"audio_file":"...","voice_name":"..."}` 后用 voice_id 调用 t2a_v2 |
| `ElevenLabs` | **Multilingual v2** 🏆国际 | ⭐⭐⭐⭐⭐ 30语言，情感自然，生态最成熟 | $0.18/千字符，Free: 1万/月 | `POST api.elevenlabs.io/v1/text-to-speech/{voice_id}` `{"text":"...","model_id":"eleven_multilingual_v2"}` |
| `ElevenLabs` | **IVC / PVC 声音克隆** | ⭐⭐⭐⭐⭐ IVC: 10秒上传即克隆；PVC: 高保真定制 | Starter $5 起 | `POST api.elevenlabs.io/v1/voices/add` `{"name":"...","files":[音频文件]}` |
| `OpenAI` | **gpt-4o-mini-tts** | ⭐⭐⭐⭐ 指令可控：情感/语速/口音/风格 | $15/百万字符，中高 | `POST api.openai.com/v1/audio/speech` `{"model":"gpt-4o-mini-tts","input":"...","voice":"alloy","instructions":"用温柔语气"}` |
| `字节/火山` | **Seed-TTS 2.0 / 豆包TTS** | ⭐⭐⭐⭐ 中文韵律自然，情绪多风格 | 火山引擎有免费额度，约 ¥0.1/千字 | `POST openspeech.bytedance.com/api/v1/tts` 或火山引擎控制台接入 |
| `阿里云` | **CosyVoice 2** 开源 | ⭐⭐⭐⭐ 中文自然度高，可本地部署 | ¥0.1/千字；开源自部署免费 | `POST dashscope.aliyuncs.com/api/v1/services/aigc/text2audio/call` model: `cosyvoice-v2` GitHub: `FunAudioLLM/CosyVoice` |
| `Google` | **Chirp 3 / Cloud TTS** | ⭐⭐⭐⭐ 多语言，Google 生态集成 | $16/百万字符，中高 | `POST texttospeech.googleapis.com/v1/text:synthesize` voice: `zh-CN-Chirp3-HD-Aoede` |

---

## 🏭 五、一站式创作平台（可视化工作台）

> [!warning] 开发者注意
> 以下平台主要面向**网页/App端**使用，通常不提供开放 API。需要程序化批量生产，建议直接调用底层模型的官方 API。

| 平台 | 所属厂商 | 底层模型 | 特色 | 价格 | 网址 |
|------|---------|---------|------|------|------|
| **即梦AI** | 字节跳动 | Seedance 2.0 | 中文优化最佳，故事创作/首尾帧/对口型，新手友好 | 免费60秒/天；69–499元/月 ⚠️多次涨价 | jimeng.jianying.com |
| **可灵AI** | 快手 | Kling 3.0 | MAU 1200万，商业最成熟，✅ 同时提供 API | 免费额度；66–399元/月 | kling.kuaishou.com |
| **LibTV** 🔥 | LiblibAI | 可灵/Wan/Seedance等20+ | 无限画布全流程，Agent双入口，积分消耗比即梦低92% | 专业版 499元/年；大师版 1299元/年 | liblib.tv |
| **纳米漫剧流水线** | 360集团 | 自研世界模型 | 工业级，单集30–60min完成，合作保利影业 | B端企业定制 | nano.360.com |
| **有戏AI** | 风平智能 | 自研 | 5万字超长剧本，角色三视图，¥0.1/秒，1人1天1部剧 | 约¥0.1/秒，邀请制内测 | youxi.ai |
| **Catimind Ani** | Catimind | 多模型编排 | 面向工作室，整季风格统一管理，零部署 | 企业定制 | 联系官方 |
| **白日梦AI** | — | 多模型 | 新手友好，免费额度，适合入门体验 | 免费额度+付费 | aibrm.com |
| **Runway** | Runway | Gen-4 | 国际电影感首选，Multi-Shot App，中文不友好 | $15–144/月，偏贵 | runway.com |

---

## 🚀 六、推荐全流程组合方案

### 💰 极低成本（国内·个人/新手）
```
DeepSeek V3（剧本）
  → 通义万相 Wanx2.1（文生图 ¥0.14/张）
  → ComfyUI + IP-Adapter（角色一致性·本地免费）
  → 可灵 Kling 3.0（视频 ¥0.35/5秒 + 首尾帧）
  → MiniMax Speech-02（配音·全球最低价）
```

### ⭐ 效果优先（国内·工作室）
```
Claude Sonnet 4.6（剧本）
  → FLUX 1.1 Pro Ultra（高品质文生图）
  → LibTV 或 即梦（可视化分镜工作台）
  → Seedance 2.0（视频·良品率 90%+）
  → 通义万相 Wan2.5（音画同步合成）
  → MiniMax Speech-02（配音）
```

### 🌍 国际方案（海外市场·英文内容）
```
Claude Sonnet 4.6（剧本）
  → GPT-Image-2（文生图·推理生成）
  → Midjourney v7（分镜美化）
  → Sora 2 / Runway Gen-4（视频）
  → ElevenLabs Multilingual v2（配音·30语言）
```

### 🔓 开源自部署（技术团队·完全掌控）
```
DeepSeek V3/R1（本地/API）
  → FLUX 本地（文生图）
  → ComfyUI + ControlNet + IP-Adapter（分镜一致性）
  → HappyHorse-1.0（即将开源·图生视频+原生音频）
  → CosyVoice 2（本地 TTS·开源）
```

---

## 🔑 七、API 接入快速参考

> [!info] 通用规则
> 1. 所有请求 Header 加入 `Authorization: Bearer {YOUR_API_KEY}`
> 2. 视频生成均为异步：提交 → 获取 `task_id` → 每 10 秒轮询 → `completed` 后下载
> 3. 国内模型（阿里/字节/腾讯）需中国大陆账号或企业资质
> 4. `fal.ai` 是国际代理平台，可同时访问 FLUX / HappyHorse 等

| 厂商 | Base URL | Auth Header | 控制台 |
|------|----------|------------|--------|
| OpenAI | `https://api.openai.com/v1` | `Authorization: Bearer sk-xxx` | platform.openai.com/api-keys |
| Anthropic | `https://api.anthropic.com/v1` | `x-api-key: sk-ant-xxx` | console.anthropic.com |
| Google AI Studio | `https://generativelanguage.googleapis.com` | `?key=AIzaSy-xxx` | aistudio.google.com |
| Google Vertex AI | `https://us-central1-aiplatform.googleapis.com` | `Bearer {gcloud token}` | console.cloud.google.com |
| DeepSeek | `https://api.deepseek.com/v1` | `Authorization: Bearer xxx` | platform.deepseek.com |
| 阿里云百炼 | `https://dashscope.aliyuncs.com` | `Authorization: Bearer xxx` | dashscope.console.aliyun.com |
| 字节/火山引擎 | `https://ark.cn-beijing.volces.com/api/v3` | `Authorization: Bearer xxx` | console.volcengine.com/ark |
| 腾讯混元 | `https://hunyuan.tencentcloudapi.com` | TC3-HMAC-SHA256 签名 | console.cloud.tencent.com |
| MiniMax | `https://api.minimax.chat/v1` | `Authorization: Bearer xxx` | platform.minimaxi.com |
| ElevenLabs | `https://api.elevenlabs.io/v1` | `xi-api-key: xxx` | elevenlabs.io/app/settings |
| 可灵（Kling） | `https://api.klingai.com/v1` | `Authorization: Bearer xxx` | klingai.com/developer |
| Runway | `https://api.runwayml.com/v1` | `Authorization: Bearer xxx` | app.runwayml.com/settings |
| fal.ai（多模型代理） | `https://fal.run` | `Authorization: Key xxx` | fal.ai/dashboard/keys |

---

*📅 最后更新：2026-04-25 ｜ 以官方文档为准*

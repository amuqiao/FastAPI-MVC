# OpenAI 环境变量配置规范
## 一、配置项说明
| 环境变量名       | 作用                  | 必填性 | 默认值                  |
|------------------|-----------------------|--------|-------------------------|
| OPENAI_API_KEY   | OpenAI 接口认证密钥   | 必填   | 无                      |
| OPENAI_BASE_URL  | OpenAI 兼容接口地址   | 可选   | https://api.openai.com/v1 |

---

## 二、临时配置（仅当前终端生效）
关闭终端后配置自动失效，适合临时测试使用
1. 仅配置密钥
```bash
export OPENAI_API_KEY='sk-your-real-key'
```
2. 同时配置密钥+接口地址
```bash
export OPENAI_API_KEY='sk-your-real-key'
export OPENAI_BASE_URL='https://api.openai.com/v1'
```

---

## 三、永久配置（写入 ~/.zshrc，全终端生效）
配置后永久生效，提供两种写入方式
### 方式1：编辑器手动写入
1. 打开配置文件
```bash
nano ~/.zshrc
```
2. 在文件**末尾**添加配置：
```bash
export OPENAI_API_KEY='sk-your-real-key'
export OPENAI_BASE_URL='https://api.openai.com/v1'
```
3. 使配置立即生效
```bash
source ~/.zshrc
```

### 方式2：命令行直接追加（无需编辑器）
1. 一键追加配置到文件
```bash
echo "export OPENAI_API_KEY='sk-your-real-key'" >> ~/.zshrc
echo "export OPENAI_BASE_URL='https://api.openai.com/v1'" >> ~/.zshrc
```
2. 使配置立即生效
```bash
source ~/.zshrc
```

---

## 四、配置验证
执行命令查看输出，有对应值即代表配置生效
```bash
# 验证密钥
echo $OPENAI_API_KEY
# 验证接口地址
echo $OPENAI_BASE_URL
```
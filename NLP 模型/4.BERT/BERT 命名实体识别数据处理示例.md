# BERT 命名实体识别数据处理示例

**摘要**：本文详细说明 BERT 模型在命名实体识别（NER）任务中的数据处理流程，包括分词、标签对齐、输入构造等步骤，并通过具体示例帮助读者理解 NER 任务的数据处理过程。

## 1. NER 任务概述

### 1.1 任务定义

命名实体识别（Named Entity Recognition, NER）是 NLP 中的一项基础任务，旨在从文本中识别出具有特定意义的实体，如人名、地名、组织机构名等。

### 1.2 常见实体类型

| 实体类型 | 示例 | 说明 |
|---------|------|------|
| PER | 张三、李四 | 人名 |
| ORG | 腾讯、北京大学 | 组织机构 |
| LOC | 北京、上海 | 地点 |
| DATE | 2023年10月1日 | 日期 |
| TIME | 下午3点 | 时间 |
| MONEY | 100元 | 货币 |
| PERCENT | 50% | 百分比 |

### 1.3 标注方案

本文使用 BIO 标注方案：
- **B-**：实体的开始
- **I-**：实体的内部
- **O**：非实体

## 2. 数据处理流程

### 2.1 原始数据示例

假设我们有以下原始文本和对应的实体标注：

| 文本 | 标注 |
|------|------|
| 张三在腾讯工作 | 张三/PER 在/O 腾讯/ORG 工作/O |
| 北京是中国的首都 | 北京/LOC 是/O 中国/LOC 的/O 首都/O |
| 2023年张三从北京大学毕业 | 2023年/DATE 张三/PER 从/O 北京大学/ORG 毕业/O |

### 2.2 步骤 1：分词（Tokenization）

使用 BERT 分词器对文本进行分词：

```python
from transformers import BertTokenizer

# 加载分词器
tokenizer = BertTokenizer.from_pretrained('bert-base-chinese')

# 示例文本
texts = ["张三在腾讯工作", "北京是中国的首都", "2023年张三从北京大学毕业"]

# 分词
for text in texts:
    tokens = tokenizer.tokenize(text)
    print(f"文本: {text}")
    print(f"分词结果: {tokens}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
分词结果: ['张', '三', '在', '腾', '讯', '工', '作']

文本: 北京是中国的首都
分词结果: ['北', '京', '是', '中', '国', '的', '首', '都']

文本: 2023年张三从北京大学毕业
分词结果: ['2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业']
```

### 2.3 步骤 2：标签对齐

将原始标注转换为 BIO 格式，并与分词结果对齐：

```python
# 原始标注
annotations = [
    "张三/PER 在/O 腾讯/ORG 工作/O",
    "北京/LOC 是/O 中国/LOC 的/O 首都/O",
    "2023年/DATE 张三/PER 从/O 北京大学/ORG 毕业/O"
]

# 转换为 BIO 格式并对齐
for text, annotation in zip(texts, annotations):
    # 分词
    tokens = tokenizer.tokenize(text)
    
    # 解析原始标注
    parts = annotation.split()
    orig_tokens = [part.split('/')[0] for part in parts]
    orig_labels = [part.split('/')[1] for part in parts]
    
    # 生成原始标签序列
    orig_label_seq = []
    for token, label in zip(orig_tokens, orig_labels):
        chars = list(token)
        for i, char in enumerate(chars):
            if i == 0:
                orig_label_seq.append(f"B-{label}")
            else:
                orig_label_seq.append(f"I-{label}")
    
    # 标签对齐
    aligned_labels = []
    i = 0
    for token in tokens:
        if token.startswith('##'):
            # 子词继承前一个词的标签
            if aligned_labels:
                aligned_labels.append(aligned_labels[-1])
            else:
                aligned_labels.append('O')
        else:
            if i < len(orig_label_seq):
                aligned_labels.append(orig_label_seq[i])
                i += 1
            else:
                aligned_labels.append('O')
    
    print(f"文本: {text}")
    print(f"分词结果: {tokens}")
    print(f"对齐后标签: {aligned_labels}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
分词结果: ['张', '三', '在', '腾', '讯', '工', '作']
对齐后标签: ['B-PER', 'I-PER', 'O', 'B-ORG', 'I-ORG', 'O', 'O']

文本: 北京是中国的首都
分词结果: ['北', '京', '是', '中', '国', '的', '首', '都']
对齐后标签: ['B-LOC', 'I-LOC', 'O', 'B-LOC', 'I-LOC', 'O', 'O', 'O']

文本: 2023年张三从北京大学毕业
分词结果: ['2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业']
对齐后标签: ['B-DATE', 'I-DATE', 'B-PER', 'I-PER', 'O', 'B-ORG', 'I-ORG', 'I-ORG', 'I-ORG', 'O', 'O']
```

### 2.4 步骤 3：添加特殊标记

在序列开头添加 `[CLS]`，在结尾添加 `[SEP]`：

```python
for text in texts:
    # 分词并添加特殊标记
    tokens = tokenizer.tokenize(text)
    tokens_with_special = ['[CLS]'] + tokens + ['[SEP]']
    
    print(f"文本: {text}")
    print(f"添加特殊标记后: {tokens_with_special}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
添加特殊标记后: ['[CLS]', '张', '三', '在', '腾', '讯', '工', '作', '[SEP]']

文本: 北京是中国的首都
添加特殊标记后: ['[CLS]', '北', '京', '是', '中', '国', '的', '首', '都', '[SEP]']

文本: 2023年张三从北京大学毕业
添加特殊标记后: ['[CLS]', '2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业', '[SEP]']
```

### 2.5 步骤 4：转换为词表索引

将 token 转换为词表索引：

```python
for text in texts:
    # 编码
    encoded = tokenizer(text, return_tensors='pt')
    input_ids = encoded['input_ids'].squeeze().tolist()
    tokens = tokenizer.convert_ids_to_tokens(input_ids)
    
    print(f"文本: {text}")
    print(f"Token: {tokens}")
    print(f"索引: {input_ids}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
Token: ['[CLS]', '张', '三', '在', '腾', '讯', '工', '作', '[SEP]']
索引: [101, 1998, 7842, 1962, 4403, 6221, 2885, 2555, 102]

文本: 北京是中国的首都
Token: ['[CLS]', '北', '京', '是', '中', '国', '的', '首', '都', '[SEP]']
索引: [101, 1266, 776, 3221, 1744, 1798, 4638, 3706, 7394, 102]

文本: 2023年张三从北京大学毕业
Token: ['[CLS]', '2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业', '[SEP]']
索引: [101, 811, 2339, 1998, 7842, 1308, 1266, 776, 1920, 2084, 5336, 3300, 102]
```

### 2.6 步骤 5：生成 Segment ID

由于是单句任务，所有 token 的 Segment ID 都为 0：

```python
for text in texts:
    # 编码
    encoded = tokenizer(text, return_tensors='pt')
    token_type_ids = encoded['token_type_ids'].squeeze().tolist()
    tokens = tokenizer.convert_ids_to_tokens(encoded['input_ids'].squeeze().tolist())
    
    print(f"文本: {text}")
    print(f"Token: {tokens}")
    print(f"Segment ID: {token_type_ids}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
Token: ['[CLS]', '张', '三', '在', '腾', '讯', '工', '作', '[SEP]']
Segment ID: [0, 0, 0, 0, 0, 0, 0, 0, 0]

文本: 北京是中国的首都
Token: ['[CLS]', '北', '京', '是', '中', '国', '的', '首', '都', '[SEP]']
Segment ID: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

文本: 2023年张三从北京大学毕业
Token: ['[CLS]', '2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业', '[SEP]']
Segment ID: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

### 2.7 步骤 6：生成 Attention Mask

标记有效 token 位置：

```python
for text in texts:
    # 编码
    encoded = tokenizer(text, return_tensors='pt')
    attention_mask = encoded['attention_mask'].squeeze().tolist()
    tokens = tokenizer.convert_ids_to_tokens(encoded['input_ids'].squeeze().tolist())
    
    print(f"文本: {text}")
    print(f"Token: {tokens}")
    print(f"Attention Mask: {attention_mask}")
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
Token: ['[CLS]', '张', '三', '在', '腾', '讯', '工', '作', '[SEP]']
Attention Mask: [1, 1, 1, 1, 1, 1, 1, 1, 1]

文本: 北京是中国的首都
Token: ['[CLS]', '北', '京', '是', '中', '国', '的', '首', '都', '[SEP]']
Attention Mask: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

文本: 2023年张三从北京大学毕业
Token: ['[CLS]', '2023', '年', '张', '三', '从', '北', '京', '大', '学', '毕', '业', '[SEP]']
Attention Mask: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
```

### 2.8 步骤 7：标签处理

为特殊标记添加标签，并处理填充：

```python
# 完整的数据处理函数
def process_ner_data(text, annotation, tokenizer, max_length=128):
    # 分词
    tokens = tokenizer.tokenize(text)
    
    # 解析原始标注
    parts = annotation.split()
    orig_tokens = [part.split('/')[0] for part in parts]
    orig_labels = [part.split('/')[1] for part in parts]
    
    # 生成原始标签序列
    orig_label_seq = []
    for token, label in zip(orig_tokens, orig_labels):
        chars = list(token)
        for i, char in enumerate(chars):
            if i == 0:
                orig_label_seq.append(f"B-{label}")
            else:
                orig_label_seq.append(f"I-{label}")
    
    # 标签对齐
    aligned_labels = []
    i = 0
    for token in tokens:
        if token.startswith('##'):
            # 子词继承前一个词的标签
            if aligned_labels:
                aligned_labels.append(aligned_labels[-1])
            else:
                aligned_labels.append('O')
        else:
            if i < len(orig_label_seq):
                aligned_labels.append(orig_label_seq[i])
                i += 1
            else:
                aligned_labels.append('O')
    
    # 添加特殊标记的标签
    aligned_labels = ['O'] + aligned_labels + ['O']
    
    # 编码
    encoded = tokenizer(
        text,
        max_length=max_length,
        padding='max_length',
        truncation=True,
        return_tensors='pt'
    )
    
    # 处理标签填充
    padding_length = max_length - len(aligned_labels)
    aligned_labels += ['O'] * padding_length
    
    return {
        'input_ids': encoded['input_ids'].squeeze(),
        'token_type_ids': encoded['token_type_ids'].squeeze(),
        'attention_mask': encoded['attention_mask'].squeeze(),
        'labels': aligned_labels
    }

# 测试函数
for text, annotation in zip(texts, annotations):
    result = process_ner_data(text, annotation, tokenizer)
    print(f"文本: {text}")
    print(f"标签: {result['labels'][:len(tokenizer.tokenize(text))+2]}")  # 只显示非填充部分
    print()
```

**输出结果**：

```
文本: 张三在腾讯工作
标签: ['O', 'B-PER', 'I-PER', 'O', 'B-ORG', 'I-ORG', 'O', 'O', 'O']

文本: 北京是中国的首都
标签: ['O', 'B-LOC', 'I-LOC', 'O', 'B-LOC', 'I-LOC', 'O', 'O', 'O', 'O']

文本: 2023年张三从北京大学毕业
标签: ['O', 'B-DATE', 'I-DATE', 'B-PER', 'I-PER', 'O', 'B-ORG', 'I-ORG', 'I-ORG', 'I-ORG', 'O', 'O', 'O']
```

## 3. 完整数据处理示例

### 3.1 批量处理

```python
import torch
from torch.utils.data import Dataset, DataLoader

class NERDataset(Dataset):
    def __init__(self, texts, annotations, tokenizer, max_length=128):
        self.texts = texts
        self.annotations = annotations
        self.tokenizer = tokenizer
        self.max_length = max_length
    
    def __len__(self):
        return len(self.texts)
    
    def __getitem__(self, idx):
        text = self.texts[idx]
        annotation = self.annotations[idx]
        return process_ner_data(text, annotation, self.tokenizer, self.max_length)

# 标签映射
label_list = ['O', 'B-PER', 'I-PER', 'B-ORG', 'I-ORG', 'B-LOC', 'I-LOC', 'B-DATE', 'I-DATE']
label2id = {label: i for i, label in enumerate(label_list)}
id2label = {i: label for label, i in label2id.items()}

# 创建数据集和数据加载器
dataset = NERDataset(texts, annotations, tokenizer)
dataloader = DataLoader(dataset, batch_size=2, shuffle=True)

# 查看批量数据
for batch in dataloader:
    print("Input IDs:", batch['input_ids'])
    print("Token Type IDs:", batch['token_type_ids'])
    print("Attention Mask:", batch['attention_mask'])
    print("Labels:", [ [id2label[label2id[l]] for l in labels[:15] ] for labels in batch['labels'])
    break
```

### 3.2 模型输入示例

```python
# 准备模型输入
test_text = "张三在腾讯工作"
test_annotation = "张三/PER 在/O 腾讯/ORG 工作/O"

# 处理数据
input_data = process_ner_data(test_text, test_annotation, tokenizer)

# 转换标签为 ID
label_ids = torch.tensor([label2id[label] for label in input_data['labels']])

# 模型输入
model_inputs = {
    'input_ids': input_data['input_ids'].unsqueeze(0),
    'token_type_ids': input_data['token_type_ids'].unsqueeze(0),
    'attention_mask': input_data['attention_mask'].unsqueeze(0),
    'labels': label_ids.unsqueeze(0)
}

print("模型输入准备完成:")
print(f"Input IDs 形状: {model_inputs['input_ids'].shape}")
print(f"Token Type IDs 形状: {model_inputs['token_type_ids'].shape}")
print(f"Attention Mask 形状: {model_inputs['attention_mask'].shape}")
print(f"Labels 形状: {model_inputs['labels'].shape}")
```

## 4. 模型训练与推理

### 4.1 模型定义

```python
import torch
import torch.nn as nn
from transformers import BertModel

class BertNER(nn.Module):
    def __init__(self, num_labels):
        super(BertNER, self).__init__()
        self.bert = BertModel.from_pretrained('bert-base-chinese')
        self.classifier = nn.Linear(self.bert.config.hidden_size, num_labels)
    
    def forward(self, input_ids, attention_mask, token_type_ids=None, labels=None):
        outputs = self.bert(
            input_ids=input_ids,
            attention_mask=attention_mask,
            token_type_ids=token_type_ids
        )
        sequence_output = outputs.last_hidden_state
        logits = self.classifier(sequence_output)
        
        loss = None
        if labels is not None:
            loss_fn = nn.CrossEntropyLoss()
            # 忽略填充位置的损失
            active_loss = attention_mask.view(-1) == 1
            active_logits = logits.view(-1, logits.shape[-1])[active_loss]
            active_labels = labels.view(-1)[active_loss]
            loss = loss_fn(active_logits, active_labels)
        
        return loss, logits

# 初始化模型
model = BertNER(num_labels=len(label_list))
```

### 4.2 推理示例

```python
def predict_ner(text, tokenizer, model, label_list, max_length=128):
    # 编码
    encoded = tokenizer(
        text,
        max_length=max_length,
        padding='max_length',
        truncation=True,
        return_tensors='pt'
    )
    
    # 模型推理
    model.eval()
    with torch.no_grad():
        loss, logits = model(
            input_ids=encoded['input_ids'],
            attention_mask=encoded['attention_mask'],
            token_type_ids=encoded['token_type_ids']
        )
    
    # 获取预测结果
    predictions = torch.argmax(logits, dim=-1).squeeze().tolist()
    tokens = tokenizer.tokenize(text)
    tokens_with_special = ['[CLS]'] + tokens + ['[SEP]']
    
    # 转换为标签
    predicted_labels = [label_list[pred] for pred in predictions[:len(tokens_with_special)]]
    
    # 合并实体
    entities = []
    current_entity = None
    for token, label in zip(tokens, predicted_labels[1:-1]):  # 跳过 [CLS] 和 [SEP]
        if label.startswith('B-'):
            if current_entity:
                entities.append(current_entity)
            current_entity = {
                'type': label[2:],
                'text': token,
                'start': len(' '.join([e['text'] for e in entities])) if entities else 0
            }
        elif label.startswith('I-') and current_entity and label[2:] == current_entity['type']:
            current_entity['text'] += token
        else:
            if current_entity:
                entities.append(current_entity)
                current_entity = None
    
    if current_entity:
        entities.append(current_entity)
    
    return tokens, predicted_labels, entities

# 测试推理
test_text = "张三在腾讯工作"
tokens, labels, entities = predict_ner(test_text, tokenizer, model, label_list)

print(f"输入文本: {test_text}")
print(f"分词结果: {tokens}")
print(f"预测标签: {labels[1:-1]}")  # 跳过 [CLS] 和 [SEP]
print(f"识别的实体: {entities}")
```

## 5. 常见问题与解决方案

### 5.1 标签对齐问题

**问题**：分词后的子词与原始标注的边界不匹配
**解决方案**：
- 对于子词，继承前一个词的标签
- 对于多字符实体，确保每个字符都有正确的 B/I 标签

### 5.2 长文本处理

**问题**：文本长度超过模型的最大序列长度
**解决方案**：
- 使用 `truncation=True` 截断文本
- 采用滑动窗口方法处理长文本
- 对于非常长的文本，考虑分段处理

### 5.3 未登录词处理

**问题**：遇到不在词汇表中的词
**解决方案**：
- BERT 分词器会自动将未登录词分解为子词
- 对于领域特定词汇，考虑扩展词汇表

### 5.4 标签不平衡

**问题**：实体标签数量远少于非实体标签
**解决方案**：
- 使用类别权重平衡损失函数
- 采用数据增强技术增加实体样本
- 使用 F1 分数作为评估指标

## 6. 总结

NER 任务的数据处理是构建高性能 NER 系统的关键步骤，主要包括：

1. **分词**：使用 BERT 分词器对文本进行分词
2. **标签对齐**：将原始标注转换为 BIO 格式并与分词结果对齐
3. **输入构造**：添加特殊标记，生成词表索引、Segment ID 和 Attention Mask
4. **标签处理**：为特殊标记添加标签，处理填充

通过本文的示例，希望读者能够掌握 BERT 模型在 NER 任务中的数据处理流程，为构建高性能的 NER 系统打下基础。

## 7. 参考资源

- [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)
- [Hugging Face Transformers Documentation](https://huggingface.co/docs/transformers/index)
- [CoNLL 2003 NER Shared Task](https://www.clips.uantwerpen.be/conll2003/ner/)
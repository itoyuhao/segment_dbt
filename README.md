# Segment dbt Project

PoC for Segment data transformation using dbt and BigQuery.

## 專案概述

這個專案使用 dbt (Data Build Tool) 來轉換和建模來自 Segment 的原始事件資料。資料存儲在 Google BigQuery 中。

## 專案結構

```
segment_dbt/
├── dbt_project.yml          # dbt 專案主要設定檔
├── profiles.yml             # BigQuery 連接設定
├── packages.yml             # dbt 套件依賴
├── models/
│   ├── sources.yml          # 定義 BigQuery 原始資料來源
│   ├── staging/             # Staging 層：清理和標準化原始資料
│   │   ├── schema.yml
│   │   ├── stg_segment__pages.sql
│   │   ├── stg_segment__tracks.sql
│   │   └── stg_segment__identifies.sql
│   └── marts/               # Marts 層：業務邏輯和最終資料表
│       ├── schema.yml
│       ├── fct_page_views.sql   # 頁面瀏覽事實表
│       ├── fct_events.sql       # 事件事實表
│       └── dim_users.sql        # 用戶維度表
├── macros/                  # 自定義 SQL 巨集
├── tests/                   # 自定義資料測試
├── seeds/                   # CSV 參考資料
├── snapshots/               # 快照定義
└── analyses/                # 臨時分析查詢
```

## 資料架構

### Staging 層
- `stg_segment__pages`: 清理後的頁面瀏覽事件
- `stg_segment__tracks`: 清理後的追蹤事件
- `stg_segment__identifies`: 清理後的用戶識別呼叫

### Marts 層
- `fct_page_views`: 頁面瀏覽事實表，包含分析維度
- `fct_events`: 所有追蹤事件的統一事實表
- `dim_users`: 用戶維度表，包含最新屬性和活動指標

## 設定步驟

### 1. 安裝 dbt

```bash
# 使用 pip 安裝 dbt-bigquery
pip install dbt-bigquery
```

### 2. 設定 BigQuery 連接

1. 編輯 `profiles.yml` 檔案，替換以下值：
   - `your-gcp-project-id`: 你的 GCP 專案 ID
   - `dbt_dev`: 開發環境的 dataset 名稱
   - BigQuery location (預設為 US)

2. 設定 GCP 認證：

**開發環境 (使用 OAuth):**
```bash
gcloud auth application-default login
```

**生產環境 (使用 Service Account):**
- 建立 service account 並下載 JSON key
- 在 `profiles.yml` 中設定 `keyfile` 路徑
- 確保 service account 有 BigQuery Data Editor 和 BigQuery Job User 權限

### 3. 設定資料來源

編輯 `models/sources.yml`，設定你的 BigQuery 原始資料：
- 替換 `your-gcp-project-id` 為實際的 GCP 專案 ID
- 替換 `segment_raw` 為實際的 dataset 名稱
- 根據你的 Segment schema 調整 table 和 column 定義

### 4. 安裝 dbt 套件

```bash
dbt deps
```

### 5. 測試連接

```bash
dbt debug
```

## 使用方式

### 執行所有 models

```bash
dbt run
```

### 執行特定 models

```bash
# 只執行 staging 層
dbt run --select staging

# 只執行 marts 層
dbt run --select marts

# 執行特定 model
dbt run --select stg_segment__pages
```

### 執行測試

```bash
# 執行所有測試
dbt test

# 測試特定 model
dbt test --select stg_segment__pages
```

### 生成文檔

```bash
# 生成文檔
dbt docs generate

# 啟動文檔伺服器
dbt docs serve
```

### 其他有用的命令

```bash
# 編譯但不執行
dbt compile

# 顯示 model 依賴關係
dbt ls --select staging

# 清理舊的 build artifacts
dbt clean
```

## 資料品質

專案包含以下資料品質檢查：

1. **唯一性測試**: 確保主鍵的唯一性
2. **非空值測試**: 確保關鍵欄位不為空
3. **接受值測試**: 驗證分類欄位的值範圍
4. **參照完整性**: 確保 foreign keys 的有效性

## 開發指南

### 命名規範

- **Staging models**: `stg_<source>__<entity>.sql`
- **Fact tables**: `fct_<entity>.sql`
- **Dimension tables**: `dim_<entity>.sql`
- **中間 models**: `int_<entity>__<description>.sql`

### 最佳實踐

1. 所有 staging models 使用 `view` materialization
2. Marts models 使用 `table` materialization
3. 使用 CTE (Common Table Expressions) 組織 SQL
4. 在每個 model 開頭添加描述註解
5. 使用 `ref()` 和 `source()` 函數引用資料
6. 在 schema.yml 中記錄所有 models 和 columns

## 設定變數

在 `dbt_project.yml` 中可以設定的變數：

```yaml
vars:
  project_id: "your-project-id"
  dataset_name: "your_dataset"
```

在 SQL 中使用：
```sql
{{ var('project_id') }}
```

## 疑難排解

### 認證問題
```bash
# 重新認證
gcloud auth application-default login

# 檢查當前認證
gcloud auth application-default print-access-token
```

### 連接問題
```bash
# 檢查 dbt 設定
dbt debug

# 驗證 profiles.yml 語法
cat profiles.yml
```

## 參考資料

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt BigQuery Setup](https://docs.getdbt.com/reference/warehouse-setups/bigquery-setup)
- [Segment Documentation](https://segment.com/docs/)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)

## 授權

MIT License

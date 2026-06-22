# Delegated Type Sandbox

Rails の `delegated_type` を学ぶための練習用アプリ。「給湯器の製品カタログ」を題材に、共通データを持つ親モデルと、種別ごとに固有データを持つ子モデルを `delegated_type` で結びつける構成を示します。

## 題材とモデル構成

製品（`Product`）は共通項目（製品名・発売日）だけを持ち、種別固有のスペックは `delegated_type :heater` で各給湯器モデルに委譲します。

```
Product (製品)                      … name, released_on
  └─ delegated_type :heater
       ├─ GasWaterHeater (ガス給湯器)   … gas_type(enum), gas_consumption
       ├─ OilWaterHeater (石油給湯器)   … fuel_type(enum), fuel_consumption
       └─ EcoCute       (エコキュート) … tank_capacity, max_current
```

- `products` テーブルが `heater_type` / `heater_id` を持ち、`product.heater` で実体（`GasWaterHeater` など）を取得できる。
- **`Product` と各給湯器クラスは Ruby の継承関係ではない**（別クラス）。`delegated_type` はポリモーフィック関連による委譲で「継承のような構造」を実現する仕組み。
- 委譲先が共有する逆関連（`has_one :product, as: :heater`）は `app/models/concerns/heaterable.rb` に集約。

### 主なファイル

| 役割 | パス |
|---|---|
| 委譲元モデル | `app/models/product.rb` |
| 委譲先モデル | `app/models/{gas_water_heater,oil_water_heater,eco_cute}.rb` |
| 逆関連の concern | `app/models/concerns/heaterable.rb` |
| 一覧コントローラ | `app/controllers/products_controller.rb` |
| 一覧ビュー | `app/views/products/index.html.erb`, `_product.html.erb` |
| 種別ごとの部分テンプレート | `app/views/{gas_water_heaters,oil_water_heaters,eco_cutes}/_*.html.erb` |
| ロケール（日本語） | `config/locales/ja.yml` |

製品一覧ページ（`/`）では `render product.heater` により、`to_partial_path` の規約で種別ごとの部分テンプレートが自動的に選ばれます（`delegated_type` の利点）。

## Rails 標準の i18n / enum の活用

- 発売日は `l product.released_on` で表示（フォーマットは `ja.yml` の `date.formats.default`）。
- 種別名は `product.heater.model_name.human`（`activerecord.models`）で表示。
- `gas_type` / `fuel_type` は整数バックエンドの `enum`。表示用の日本語ラベルは `activerecord.attributes.<model>.<enum>s` に定義し、ビューで `t(...)` で引く（gem 不要）。
- `config.i18n.default_locale = :ja`（`config/application.rb`）。

## 動かし方

### 必要環境
- Ruby 4.0.5（`.ruby-version` 参照）
- Rails 8.1 / SQLite3
- スタイルは Tailwind CSS（`tailwindcss-rails`）

### セットアップ

```sh
bundle install
bin/rails db:prepare   # DB作成・マイグレーション
bin/rails db:seed      # サンプルデータ投入
```

### 起動

```sh
bin/dev                # Rails サーバ + Tailwind ビルドを foreman で起動
```

ブラウザで http://localhost:3000 を開くと製品一覧が表示されます。

### テスト

```sh
bin/rails test
```
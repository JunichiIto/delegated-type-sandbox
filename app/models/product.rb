# 製品の「委譲元」モデル。
# 製品名・発売日といった給湯器の種別を問わず共通のデータをここに集約し、
# 種別固有のスペックは delegated_type で各給湯器モデルに委譲する。
#
# 注意: Product と GasWaterHeater 等は Ruby の継承関係ではない（別クラス）。
#       delegated_type は heater_type / heater_id カラムを使った委譲で
#       「継承のような構造」を実現する仕組み。
class Product < ApplicationRecord
  # これにより product.heater で実体（GasWaterHeater / OilWaterHeater / EcoCute）を取得でき、
  # gas_water_heater? といった判定メソッドや gas_water_heaters スコープが自動生成される。
  delegated_type :heater,
    types: %w[GasWaterHeater OilWaterHeater EcoCute],
    dependent: :destroy
end

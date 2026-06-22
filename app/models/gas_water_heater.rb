# ガス給湯器のスペック。対応ガス種とガス消費量を持つ。
# 表示用の種別名は model_name.human（config/locales/ja.yml の activerecord.models）で取得する。
class GasWaterHeater < ApplicationRecord
  include Heaterable

  # 対応ガス種。表示用の日本語ラベルは config/locales/ja.yml の
  # activerecord.attributes.gas_water_heater.gas_types に定義する。
  enum :gas_type, { city_gas: 0, propane: 1 }
end

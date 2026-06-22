# 石油給湯器のスペック。対応燃料種と燃料消費を持つ。
# 表示用の種別名は model_name.human（config/locales/ja.yml の activerecord.models）で取得する。
class OilWaterHeater < ApplicationRecord
  include Heaterable

  # 対応燃料種。表示用の日本語ラベルは config/locales/ja.yml の
  # activerecord.attributes.oil_water_heater.fuel_types に定義する。
  enum :fuel_type, { kerosene: 0, heavy_oil: 1 }
end

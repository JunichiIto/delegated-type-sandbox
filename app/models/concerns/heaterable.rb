# 委譲先（GasWaterHeater / OilWaterHeater / EcoCute）が共有する振る舞い。
# Product 側の `delegated_type :heater` に対応する逆向きの関連を定義する。
module Heaterable
  extend ActiveSupport::Concern

  included do
    # ポリモーフィックな逆関連。スペックが更新されたら親 Product の updated_at も更新する。
    has_one :product, as: :heater, touch: true
  end
end

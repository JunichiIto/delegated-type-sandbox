# delegated_type サンプル用のシードデータ。
# 何度実行しても同じ結果になるよう、既存データを消してから作り直す。
[ Product, GasWaterHeater, OilWaterHeater, EcoCute ].each(&:delete_all)

# name には型名を含めない（"ガス給湯器" 等の種別名はビューの type_label で付与する）。
# heater: に各スペックの実体を渡すだけで、delegated_type が heater_type/heater_id を保存してくれる。
Product.create!(name: "GX-24", released_on: Date.new(2024, 4, 1),
                heater: GasWaterHeater.new(gas_type: :city_gas, gas_consumption: 30500))
Product.create!(name: "GX-16P", released_on: Date.new(2022, 6, 10),
                heater: GasWaterHeater.new(gas_type: :propane, gas_consumption: 20000))
Product.create!(name: "OL-46", released_on: Date.new(2023, 9, 15),
                heater: OilWaterHeater.new(fuel_type: :kerosene, fuel_consumption: 4.1))
Product.create!(name: "EQ-370", released_on: Date.new(2025, 1, 20),
                heater: EcoCute.new(tank_capacity: 370, max_current: 18))

puts "Seed 完了: products=#{Product.count} " \
     "(gas=#{GasWaterHeater.count}, oil=#{OilWaterHeater.count}, ecocute=#{EcoCute.count})"

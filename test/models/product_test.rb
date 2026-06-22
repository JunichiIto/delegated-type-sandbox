require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "heater は種別ごとに正しい実体クラスを返す" do
    assert_instance_of GasWaterHeater, products(:gas_product).heater
    assert_instance_of OilWaterHeater, products(:oil_product).heater
    assert_instance_of EcoCute, products(:ecocute_product).heater
  end

  test "delegated_type が生成する判定メソッド" do
    gas = products(:gas_product)
    assert gas.gas_water_heater?
    assert_not gas.oil_water_heater?
    assert_not gas.eco_cute?
  end

  test "委譲先から固有データをたどれる" do
    assert_equal "city_gas", products(:gas_product).heater.gas_type
    assert products(:gas_product).heater.city_gas?
    assert_equal 30500, products(:gas_product).heater.gas_consumption
    assert_equal "kerosene", products(:oil_product).heater.fuel_type
    assert products(:oil_product).heater.kerosene?
    assert_equal 370, products(:ecocute_product).heater.tank_capacity
  end

  test "Product と GasWaterHeater は継承関係ではない" do
    assert_not GasWaterHeater.ancestors.include?(Product)
    assert_not products(:gas_product).heater.is_a?(Product)
  end

  test "製品を destroy すると委譲先も dependent: :destroy で削除される" do
    product = products(:gas_product)
    heater = product.heater
    product.destroy
    assert_not GasWaterHeater.exists?(heater.id)
  end
end

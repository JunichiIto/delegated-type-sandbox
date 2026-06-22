class CreateOilWaterHeaters < ActiveRecord::Migration[8.1]
  def change
    create_table :oil_water_heaters do |t|
      t.integer :fuel_type, null: false
      t.decimal :fuel_consumption, precision: 4, scale: 1

      t.timestamps
    end
  end
end

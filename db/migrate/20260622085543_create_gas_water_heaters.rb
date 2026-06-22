class CreateGasWaterHeaters < ActiveRecord::Migration[8.1]
  def change
    create_table :gas_water_heaters do |t|
      t.integer :gas_type, null: false
      t.integer :gas_consumption

      t.timestamps
    end
  end
end

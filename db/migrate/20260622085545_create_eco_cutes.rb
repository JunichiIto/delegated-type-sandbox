class CreateEcoCutes < ActiveRecord::Migration[8.1]
  def change
    create_table :eco_cutes do |t|
      t.integer :tank_capacity
      t.integer :max_current

      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.date :released_on
      t.references :heater, polymorphic: true, null: false

      t.timestamps
    end
  end
end

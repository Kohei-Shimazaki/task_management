class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :title, null: false
      t.integer :color, null: false, default: 0
      t.integer :shape, null: false, default: 0

      t.timestamps
    end
  end
end

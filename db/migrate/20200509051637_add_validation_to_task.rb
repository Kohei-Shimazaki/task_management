class AddValidationToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false, limit: 30
    change_column :tasks, :content, :text, null: false, limit: 150
  end
end

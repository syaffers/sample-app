class AddEditorToUsers < ActiveRecord::Migration
  def up
    add_column :users, :editor, :boolean, default: false
  end
  
  def down
    remove_column :users, :editor
  end
end

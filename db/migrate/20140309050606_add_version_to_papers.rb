class AddVersionToPapers < ActiveRecord::Migration
  def up
    add_column :papers, :version, :integer, default: 1
  end
  
  def down
    remove_column :papers, :version
  end
end

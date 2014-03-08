class RemoveUrlFromPapers < ActiveRecord::Migration
  def up
    remove_column :papers, :url
  end
  
  def down
    add_column :papers, :url, :string
  end
end

class AddPaperIdToComments < ActiveRecord::Migration
  def up
    add_column :comments, :paper_id, :integer
  end
  
  def down
    remove_column :comments, :paper_id
  end
end

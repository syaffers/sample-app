class AddPaperStatusToPapers < ActiveRecord::Migration
  def up
    add_column :papers, :paper_status, :integer, default: 0
  end
  
  def down
    remove_column :papers, :paper_status
  end
end

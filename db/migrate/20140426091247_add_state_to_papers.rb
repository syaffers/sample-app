class AddStateToPapers < ActiveRecord::Migration
  def up
    add_column :papers, :state, :string
  end
    
  def down
    remove_column :papers, :state
  end
end

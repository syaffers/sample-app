class AddDetailsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :job_title, :string, default: ""
    add_column :users, :institution, :string, default: ""
    add_column :users, :summary, :text, default: ""
  end
  
  def down
    remove_column :users, :job_title, :string, default: ""
    remove_column :users, :institution, :string, default: ""
    remove_column :users, :summary, :text, default: ""
  end
end

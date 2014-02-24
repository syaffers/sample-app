class ChangeSubjectFieldToSubjectId < ActiveRecord::Migration
  def up
    add_column :papers, :subject_id, :integer
    remove_column :papers, :subject_field
  end
  
  def down
    remove_column :papers, :subject_id
    add_column :papers, :subject_field, :string
  end
end

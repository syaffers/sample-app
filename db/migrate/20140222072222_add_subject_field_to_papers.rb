class AddSubjectFieldToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :subject_field, :string
  end
end

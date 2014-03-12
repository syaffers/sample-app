class AddReviewLimitToPapers < ActiveRecord::Migration
  def up
    add_column :papers, :review_limit, :integer, default: 3
  end
  
  def down
    remove_column :papers, :review_limit
  end
end

class AddReviewStatusToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :review_status, :integer
  end
  
  def down
    remove_column :reviews, :review_status
  end
end

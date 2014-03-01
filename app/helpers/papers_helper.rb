module PapersHelper
  def comment_user?(comment)
    comment.user == current_user
  end
end

module LikeHelper
  def liked(record)
    record.likes.pluck(:user_id).include?(current_user.id)
  end
end

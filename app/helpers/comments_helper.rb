module CommentsHelper
  def unique_id_generator(record)
    record.class.name.downcase + '__' + record.id.to_s
  end

  def unique_class_generator(record)
    record.class.name.downcase + '___' + record.id.to_s
  end

  def commenter(comment)
    comment.user == current_user
  end
  def poster(post)
    if post.is_a?(Post)
      return post.user == current_user
    else
      return post.company.users.include?(current_user)
    end
  end
end

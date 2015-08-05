module PostsHelper

  def post_creator(post)
    post.user == current_user
  end

end

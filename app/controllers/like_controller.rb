class LikeController < ApplicationController

  before_action :authenticate_user!

  respond_to :js

  def create
    @likable = find_likable
    unless @likable.likes.pluck(:user_id).include?(current_user.id)
      @like = @likable.likes.new(:user_id => current_user.id)
      @like.save
    end
  end

  def destroy
    @likable = find_likable
    @likable.likes.find_by_user_id(current_user.id).destroy
  end

  private
  def find_likable
    if params[:post_id].present?
      @likable = Post.find(params[:post_id].to_i)
    elsif params[:job_id].present?
      @likable = Job.find(params[:job_id].to_i)
    elsif params[:jobs_user_id].present?
      @likable = JobsUser.find(params[:jobs_user_id].to_i)
    end
  end
end

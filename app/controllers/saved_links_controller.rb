class SavedLinksController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard_widget'

  respond_to :js

  def index
    @posts_tab = 'active'
    @saved_links = current_user.saved_links
    respond_to do |format|
      format.html
    end
  end

  def create
    @saveable = find_saveable
    @saveable.saved_links.new(:user_id => current_user.id)
    @saveable.save
  end

  def destroy
    @saved_link = SavedLink.find(params[:id])
    @saveable = @saved_link.saveable
    @saved_link.destroy
  end

  def find_saveable
    if params[:post_id]
      @saveable = Post.find(params[:post_id].to_i)
    elsif params[:job_id]
      @saveable = Job.find(params[:job_id].to_i)
    end
  end
end

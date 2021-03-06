class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :check_user_post_ability, :only => [:new, :create, :edit, :destroy]

  layout 'dashboard'

  # GET /posts
  # GET /posts.json
  def index
    @posts_tab = 'active'
    if params[:company].present?
      @company = Company.find(params[:company].to_i)
      @posts = @company.posts
    else
      @user = User.find(params[:user].to_i)
      @posts = @user.posts
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @posts_tab = 'active'
    @post = Post.new
    @company_id = params[:company] if params[:company].present?
  end

  # GET /posts/1/edit
  def edit
    if @post.user == current_user
      @company_id = @post.company_id if @post.company_id.present?
    else
      redirect_to dashboard_path, :flash => {alert: "You are trying to edit other user's post!"   }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        @post.update_post_skills_attributes(params[:post][:skills])
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.update_post_skills_attributes(params[:post][:skills])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
      @posts_tab = 'active'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :company_id, :title, :description, :feature_image, :post_type)
    end

    def check_user_post_ability
      if current_user.companies.count > 0 || current_user.profile.can_post
        return true
      else
        redirect_to dashboard_path, flash: {notice: "You don't have the privilege to post."}
      end
    end
end

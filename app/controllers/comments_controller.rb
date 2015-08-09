class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :js

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @commentable.comments
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update_column(:content, params[:comment][:content])
    @comments = @commentable.comments
    respond_with(@comment)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    @comments = @commentable.comments
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @commentable = @comment.commentable
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :job_id, :post_id)
    end

    def find_commentable
      if params[:comment][:post_id]
        @commentable = Post.find(params[:comment][:post_id].to_i)
      elsif params[:comment][:job_id]
        @commentable = Job.find(params[:comment][:job_id].to_i)
      end
    end

end

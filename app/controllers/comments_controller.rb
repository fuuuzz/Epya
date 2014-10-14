class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  
  def index
   
  end
  
  def new
  end
  
  # POST-AJAX /projects/:id --> Project#comment_tab
  def create
  @comment = Comment.new(comment_params)
  @comment.user = current_user
  @comment.project_id = params[:project_id]
  respond_to do |format|
    if @comment.save
      format.js
    end
    end
  end

  def destroy
  end
  
  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :project_id)
    end
end

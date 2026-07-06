class CommentsController < ApplicationController
  layout "workspace"
  before_action :require_login
  before_action :set_task, only: [ :create ]
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_edit, only: [ :edit, :update ]
  before_action :authorize_delete, only: [ :destroy ]

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment added successfully."
    else
      flash[:alert] = "Failed to add comment: #{@comment.errors.full_messages.join(', ')}"
    end
    redirect_to task_path(@task)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully."
      redirect_to task_path(@comment.task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = @comment.task
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to task_path(task), status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_edit
    unless current_user == @comment.user
      flash[:alert] = "You can only edit your own comments."
      redirect_to task_path(@comment.task)
    end
  end

  def authorize_delete
    unless current_user.admin? || current_user.manager? || current_user == @comment.user
      flash[:alert] = "You are not authorized to delete this comment."
      redirect_to task_path(@comment.task)
    end
  end
end

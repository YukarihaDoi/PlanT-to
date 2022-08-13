class Public::CommentsController < ApplicationController
# コメント作成
  def create
  @post_image = PostImage.find(params[:post_image_id])
  comment = Comment.new(comment_params)
  comment.user_id = current_user.id
  comment.post_image_id = @book.id
  comment.save
  @comment = Comment.new
  end

  # コメント削除
  def destroy
  @post_image = PostImage.find(params[:post_image_id])
  @comment=Comment.find_by(id: params[:id], post_image_id: params[:post_image_id])
  @comment.destroy
  @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

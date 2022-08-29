class Public::CommentsController < ApplicationController

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_image_id = @post_image.id
    @comment.save
    redirect_to post_image_path(@post_image)
  end

  def destroy
  comment = Comment.find(params[:id])
  comment.destroy
    if current_user == comment.user
       redirect_to post_image_path(params[:post_image_id])
    else
       redirect_to admin_post_images_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_image_id)
  end

end
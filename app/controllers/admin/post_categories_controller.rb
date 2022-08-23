class Admin::PostCategoriesController < ApplicationController
    def index
     @post_categories = PostCategory.all
     @post_category = PostCategory.new
    end

    def create
     @post_category = PostCategory.new(post_category_params)
      if @post_category.save
        redirect_to admin_post_categories_path
      else
        @post_category = PostCategory.all
        render :index
      end
    end

    def edit
     @post_category = PostCategory.find(params[:id])
    end

    def update
     @post_category = PostCategory.find(params[:id])
      if @post_category.update(post_category_params)
        redirect_to admin_post_categories_path
      else
        render :edit
      end
    end
    private

    def post_category_params
      params.require(:post_category).permit(:post_category)
    end
end
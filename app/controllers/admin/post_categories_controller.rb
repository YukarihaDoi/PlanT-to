class Admin::PostCategoriesController < ApplicationController
    def index
     @p_categories = PostCategory.all
     @p_category = PostCategory.new
    end
    
    def create
     @p_category = PostCategory.new(p_category_params)
      if @p_category.save
        redirect_to admin_post_categories_path
      else
        @p_category = PostCategory.all
        render :index
      end
    end

    def edit
     @p_category = PostCategory.find(params[:id])
    end

    def update
     @p_category = PostCategory.find(params[:id])
      if @p_category.update(p_category_params)
        redirect_to admin_post_categories_path
      else
        render :edit
      end
    end
    private

    def p_category_params
      params.require(:post_category).permit(:post_category)
    end
  end
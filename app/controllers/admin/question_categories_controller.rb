class Admin::QuestionCategoriesController < ApplicationController

  def index
     @q_categories = QuestionCategory.all
     @q_category = QuestionCategory.new
    end

    def create
     @q_category = QuestionCategory.new(q_category_params)
      if @q_category.save
        redirect_to admin_question_categories_path
      else
        @q_category = QuestionCategory.all
        render :index
      end
    end

    def edit
     @q_category = QuestionCategory.find(params[:id])
    end

    def update
     @q_category = QuestionCategory.find(params[:id])
      if @q_category.update(q_category_params)
        redirect_to admin_question_categories_path
      else
        render :edit
      end
    end
    private

    def q_category_params
      params.require(:question_category).permit(:question_category)
    end
  end

class Admin::QuestionCategoriesController < ApplicationController

  def index
     @question_categories = QuestionCategory.all
     @question_category = QuestionCategory.new
  end

    def create
     @question_category = QuestionCategory.new(question_category_params)
      if @question_category.save
        redirect_to admin_question_categories_path
      else
        @question_category = QuestionCategory.all
        render :index
      end
    end

    def edit
     @question_category = QuestionCategory.find(params[:id])
    end

    def update
     @question_category = QuestionCategory.find(params[:id])
      if @question_category.update(question_category_params)
        redirect_to admin_question_categories_path
      else
        render :edit
      end
    end
    private

    def question_category_params
      params.require(:question_category).permit(:question_category)
    end
end

class SearchesController < ApplicationController

 before_action :side_view, only: [ :search ]
 before_action :login_check, only: [ :search ]

  def search
    @method = params[:method]
    @word = params[:word]
    @search = params[:search]
      if @method == "「投稿」からさがす"
         @post_images = PostImage.search_for(@word,@search)
      else
         @users = User.search_for(@word,@search)
      end
  end

    private
    
    def side_view
      @post_categories = PostCategory.all
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    end

      # ログインの確認
    def login_check
      unless signed_in?
        redirect_to root_path
      end
    end
end
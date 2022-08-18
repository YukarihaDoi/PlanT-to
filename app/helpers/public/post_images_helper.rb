module Public::PostImagesHelper
  def render_with_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post_image/hashtag/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end
end
module Public::PostImagesHelper
  def render_with_hashtags(caption)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post_image/hashtag/#{word.delete("#")}"}.html_safe
  end
end

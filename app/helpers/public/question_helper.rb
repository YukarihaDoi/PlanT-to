module Public::QuestionHelper
 def render_with_hashtags(question_body)
    question_body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){ |word| link_to word, "/questions/hashtag/#{word.delete("#")}" }.html_safe
 end
end
